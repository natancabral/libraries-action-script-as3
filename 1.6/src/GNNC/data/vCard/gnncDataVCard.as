package GNNC.data.vCard
{
	import GNNC.UI.gnncAlert.gnncAlert;
	import GNNC.data.vCard.vCardAddress;
	import GNNC.data.vCard.vCardData;
	import GNNC.data.vCard.vCardEmail;
	import GNNC.data.vCard.vCardPhone;
	
	import mx.utils.Base64Decoder;
	import mx.utils.StringUtil;

	public class gnncDataVCard
	{
		public static function parse(vcardStr:String):Array
		{
			var vcards:Array = new Array();
			var lines:Array = vcardStr.split(/\r\n/);
			var vcard:vCardData;
			var type:String;
			var typeTmp:String;
			var line:String;
			
			new gnncAlert().__alert(lines.length+'<<');
			
			for (var i:uint = 0; i < lines.length; ++i)
			{
				line = lines[i];
				if (line == "BEGIN:VCARD")
				{
					vcard = new vCardData();
				}
				else if (line == "END:VCARD")
				{
					if (vcard != null)
					{
						vcards.push(vcard);
					}
				}
				else if(line.search(/^ORG/i) != -1)
				{
					var org:String = line.substring(4, line.length);
					var orgArray:Array = org.split(";");
					for each (var orgToken:String in orgArray)
					{
						if (StringUtil.trim(orgToken).length > 0)
						{
							vcard.orgs.push(orgToken);
						}
					}
				}
				else if(line.search(/^TITLE/i) != -1)
				{
					var title:String = line.substring(6, line.length);
					vcard.title = title;
				}
				else if (line.search(/^FN:/i) != -1)
				{
					var fullName:String = line.substring(3, line.length);
					vcard.fullName = fullName;
				}
				else if (line.search(/^TEL/i) != -1)
				{
					type = new String();
					typeTmp = new String();
					
					var phone:vCardPhone = new vCardPhone();
					var number:String;
					var phoneTokens:Array = line.split(";");
					
					for each (var phoneToken:String in phoneTokens)
					{
						if (phoneToken.search(/^TYPE=/i) != -1)
						{
							if (phoneToken.indexOf(":") != -1)
							{
								typeTmp = phoneToken.substring(5, phoneToken.indexOf(":"));
								number = phoneToken.substring(phoneToken.indexOf(":")+1, phoneToken.length);
							}
							else
							{                                                                      
								typeTmp = phoneToken.substring(5, phoneToken.length);
							}
							
							typeTmp = typeTmp.toLocaleLowerCase();
							
							if (typeTmp == "pref")
							{
								continue;
							}
							if (type.length != 0)
							{
								type += (" ");
							}
							type += typeTmp;
						}
					}
					if (type.length > 0 && number != null)
					{
						phone.type = type;
						phone.number = number;
					}
					vcard.phones.push(phone);
				}
				else if (line.search(/^EMAIL/i) != -1)
				{
					type = new String();
					typeTmp = new String();
					
					var email:vCardEmail = new vCardEmail();
					var emailAddress:String;
					var emailTokens:Array = line.split(";");
					
					for each (var emailToken:String in emailTokens)
					{
						if (emailToken.search(/^TYPE=/i) != -1)
						{
							if (emailToken.indexOf(":") != -1)
							{
								typeTmp = emailToken.substring(5, emailToken.indexOf(":"));
								emailAddress = emailToken.substring(emailToken.indexOf(":")+1, emailToken.length);
							}
							else
							{                                                                      
								typeTmp = emailToken.substring(5, emailToken.length);
							}
							
							typeTmp = typeTmp.toLocaleLowerCase();
							
							if (typeTmp == "pref" || typeTmp == "internet")
							{
								continue;
							}
							if (type.length != 0)
							{
								type += (" ");
							}
							type += typeTmp;
						}
					}
					if (type.length > 0 && emailAddress != null)
					{
						email.type = type;
						email.address = emailAddress;
					}
					vcard.emails.push(email);
				}
				else if (line.indexOf("ADR;") != -1)
				{
					var addressTokens:Array = line.split(";");
					var address:vCardAddress = new vCardAddress();
					
					for (var j:uint = 0; j < addressTokens.length; ++j)
					{
						var addressToken:String = addressTokens[j];
						if (addressToken.search(/^home:+$/i) != -1) // For Outlook, which uses non-standard vCards.
						{
							address.type = "home";
						}
						else if (addressToken.search(/^work:+$/i) != -1) // For Outlook, which uses non-standard vCards.
						{
							address.type = "work";
						}
						if (addressToken.search(/^type=/i) != -1)  // The "type" parameter is the standard way (which Address Book uses)
						{
							// First, remove the optional ":" character.
							addressToken = addressToken.replace(/:/,"");
							var addressType:String = addressToken.substring(5, addressToken.length).toLowerCase();
							if (addressType == "pref") // Not interested in which one is preferred.
							{
								continue;
							}
							else if (addressType.indexOf("home") != -1) // home
							{
								addressType = "home";
							}
							else if (addressType.indexOf("work") != -1) // work
							{
								addressType = "work";
							}
							else if (addressType.indexOf(",") != -1) // if the comma technique is used, just use the first one
							{
								var typeTokens:Array = addressType.split(",");
								for each (var typeToken:String in typeTokens)
								{
									if (typeToken != "pref")
									{
										addressType = typeToken;
										break;
									}
								}
							}
							address.type = addressType;
						}
						else if (addressToken.search(/^\d/) != -1 && address.street == null)
						{
							address.street = addressToken.replace(/\\n/, "");
							address.city = addressTokens[j+1];
							address.state = addressTokens[j+2];
							address.postalCode = addressTokens[j+3];
						}
					}
					if (address.type && address.street && address.city )
					{
						//vcard.addresses.push(address+' ');

						/** CABRAL START **/
						try
						{
							vcard.addresses.push(address);
						}
						catch(e:*)
						{
							//vcard.addresses.push('1');
						}
						/** CABRAL END **/
					}
					
				}
				else if (line.search(/^PHOTO;BASE64/i) != -1)
				{
					var imageStr:String = new String();
					for (var k:uint = i+1; k < lines.length; ++k)
					{
						imageStr += lines[k];
						//if (lines[k].search(/.+\=$/) != -1) // Very slow in Mac due to RegEx bug
						if (lines[k].indexOf('=') != -1)
						{
							var decoder:Base64Decoder = new Base64Decoder();
							decoder.decode(imageStr);
							vcard.image = decoder.flush();
							break;
						}
					}
				}
			}
			return vcards;
		}
	}
}
