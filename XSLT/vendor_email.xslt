<?xml version="1.0" encoding="ISO-8859-1"?> 

<xsl:stylesheet version="2.0" 
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
  xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes"
  xmlns:date="http://exslt.org/dates-and-times"
  exclude-result-prefixes="xsl fn xs xdt date">

<xsl:output method="xhtml" encoding="ISO-8859-1" indent="yes" omit-xml-declaration="yes" media-type="text/html" 
 doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

	<xsl:template match="/payment-model">
		<!-- select the languages to use default is english-->
		<xsl:variable name="i18n" select="document('i18n.xml')" />
		<xsl:variable name="requiredlang" select="language" as="xs:string"/>
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="string-length($i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='email_header']) > 0">
					<xsl:value-of select="language" />
				</xsl:when>
				<xsl:otherwise>en</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="imageloc" select="concat(imagesURL,vendor/vendortemplate,'/')" as="xs:string"/>
		<xsl:variable name="vpsprotocol" select="transaction/vpsprotocol"/>		
		<xsl:variable name ="state" select="transactionstate/txstateid"/>

		<xsl:variable name="txtypename">
			<xsl:choose>
				<xsl:when test="transaction/transactiontypeid='1'">
					PAYMENT
				</xsl:when>
				<xsl:when test="transaction/transactiontypeid='2'">	
					REFUND
				</xsl:when>
				<xsl:when test="transaction/transactiontypeid='3'">	
					DEFERRED
				</xsl:when>
				<xsl:when test="transaction/transactiontypeid='4'">	
					PREAUTH
				</xsl:when>																	
				<xsl:when test="transaction/transactiontypeid='5'">	
					AUTHENTICATE
				</xsl:when>
				<xsl:when test="transaction/transactiontypeid='6'">	
					REPEAT
				</xsl:when>
				<xsl:when test="transaction/transactiontypeid='7'">	
					REPEATDEFERRED
				</xsl:when>
				<xsl:when test="transaction/transactiontypeid='10'">	
					AUTHORISE
				</xsl:when>																		
				<xsl:when test="transaction/transactiontypeid='11'">	
					MANUAL
				</xsl:when>																
				<xsl:otherwise>
					UNKNOWN
				</xsl:otherwise>
			</xsl:choose>	
		</xsl:variable>	
		<html>
			<head>
				<title>
					Transaction Processing Results
				</title>
				<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
				<style type="text/css">@import url("<xsl:copy-of select="$imageloc"/>vsp3.css");</style>
				<style type="text/css">
					a:hover {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #006699;
					}
					a:link {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #006699;
					}
					a:visited {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #006699;
					}
					a:active {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #006699;
					}
					#textblue {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					color: #006699;
					}
					#textbluebold {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10px;
					font-weight: bold;
					color: #006699;
					}
					#smalltextwhite {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 8pt;
					color: #FFFFFF;
					}
					#largetextblue {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 12pt;
					color: #006699;
					font-weight: bold;
					}
					
					#textred {
					font-family: Verdana, Arial, Helvetica, sans-serif;
					font-size: 10pt;
					color: #CC0000;
					}
				</style>
			</head>
			<body>
		    <div id="pageWrapper">
		    <div id="headerTop"/>
			<div id="header">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td width="50%" valign="top">
                            <img src="{concat(imagesURL,'sagepay/sagepay_logo.gif')}" id="sagePayLogo" />												
                        </td>
                        <td width="50%" valign="top">
						<xsl:if test="string-length(vendor/logo)">
                            <img src="{concat(imagesURL,vendor/vspvendorname,'/',vendor/logo)}" id="vendorLogo"/>
						</xsl:if>
                        </td>
                    </tr>
                </tbody>
            </table>
			<div class="sectionheader noTopMargin">
                Notification	
            </div>		   
		</div>
        <div class="greyHzShadeBar">&#160;</div>
		<div>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="100%" height="409" align="center" valign="top">
							<table width="600" cellpadding="0" cellspacing="0" border="0">
							<br/>
								<tr>
									<td width="1" >
										<img border="0">
											<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='blankpixel_img_file']"/></xsl:attribute>
										</img>
									</td>
									<td width="653" align="center">
										<table width="100%" cellpadding="0" cellspacing="2" border="0">
											<tr>
												<td width="600" colspan="2" align="left">
                                                    <xsl:if test="string-length(transaction/test) != 0">
                                                        <p class="bodytextGreen">** This is a TEST Order placed on the Sage Pay Test Environment **<br/>** NO MONEY WILL BE TAKEN FROM THE CUSTOMER **</p>
														</xsl:if>
														<xsl:choose>
															<xsl:when test="$state='16' or $state='15' or $state='14' or $state='21'">
                                                                <p class="bodytextGreen">
                                                                    <strong>SUCCESS</strong> notification
                                                                </p>
                                                                <p class="bodytextGreen">The unique reference for this transaction is: <b>
																		<xsl:value-of select="transaction/vendortxcode"/>
																	</b></p>
															</xsl:when>
                                                            <xsl:when test="$state='11'">
                                                           		<strong>*** VERY IMPORTANT - Cancellation Notification ***</strong>
                                                             </xsl:when>
															<xsl:otherwise>
                                                                <p class="bodytextGreen">**  <b>FAILURE</b> notification **</p>
                                                            </xsl:otherwise>
														</xsl:choose>
												</td>
											</tr>
											<tr>
												<td width="600" colspan="2" height="5px">
												</td>
											</tr>

											<tr>
												<td width="600" colspan="2" class="greyHzShadeBar">
												</td>
											</tr>
											<tr>
												<td width="600" colspan="2" height="5px">
												</td>
											</tr>
											<tr>
												<td width="600" colspan="2" align="left">
													<p>
														<xsl:choose>
															<xsl:when test="$state='16' or $state='14' or $state='15' or $state='21'">
											        A customer performed a successful 
															<b>
															<xsl:value-of select="$txtypename"/>
														</b> 
														transaction with the following order details:
										        </xsl:when>
															<xsl:when test="$state='12'">	
													The following transaction FAILED... The Bank did <b>NOT AUTHORISE</b> the customer's card.										        									        
										        </xsl:when>
															<xsl:when test="$state='11'">	
													The following transaction FAILED... The <b>Customer Aborted</b> the payment process.
										        </xsl:when>
															<xsl:when test="$state='8'">	
													The following transaction FAILED... The <b>Sage Pay System TIMED-OUT</b> the payment process.
										        </xsl:when>
															<xsl:when test="$state='10'">	
													The following transaction was REJECTED... By <b>Vendor Rules</b>.
										        </xsl:when>
															<xsl:when test="$state='15'">	
													The following transaction was AUTHENTICATED successful.
										        </xsl:when>
															<xsl:otherwise>
											    The following transaction FAILED... <b>An error occurred at Sage Pay</b>.  Please contact us with the details shown below.
											    </xsl:otherwise>
														</xsl:choose>
													</p>
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">Transaction type:</td>
												<td width="450" class="bodysmalltext">
														<xsl:value-of select="$txtypename"/>
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">VendorTxCode:</td>
												<td width="450" class="bodysmalltext">
													<xsl:value-of select="transaction/vendortxcode"/>
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">VPSTxId:</td>
												<td width="450" class="bodysmalltext">
													<xsl:value-of select="transaction/transactionid"/>
												</td>
											</tr>
											<xsl:if test="$state='16' or $state='14'">
												<tr>
													<td width="150" class="bodysmalltextBold">VPS Auth Code:</td>
													<td width="450" class="bodysmalltext">
														<xsl:value-of select="authorisationstate/vpsauthcode"/>
													</td>
												</tr>
											</xsl:if>
											<tr>
												<td width="150" class="bodysmalltextBold">Amount:</td>
												<td width="450" class="bodysmalltext">
													<xsl:value-of select ="transaction/formatedamount" />
													<xsl:text> </xsl:text>
													<xsl:value-of select ="transaction/currency" />
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">Gift Aid:</td>
												<td width="450" class="bodysmalltext">
													<xsl:choose>
														<xsl:when test="transaction/allowgiftaid='2'">
													Yes - The customer checked the Gift Aid box on the payment pages.										        
										        </xsl:when>
														<xsl:when test="transaction/allowgiftaid='1'">
											        No - The Gift Aid option was present by the customer did not check it.										        
										        </xsl:when>
														<xsl:otherwise>
													No - Not a Gift Aid transaction.											    
											    </xsl:otherwise>
													</xsl:choose>
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">AVS/CV2 Response:</td>
												<td width="450" class="bodysmalltext">
													<xsl:value-of select="authorisationstate/avscv2response"/>
													<xsl:text> - CV2:</xsl:text>
													<xsl:value-of select ="authorisationstate/cv2resultvalue" />
													<xsl:text>, Address:</xsl:text>
													<xsl:value-of select ="authorisationstate/addressresultvalue" />
													<xsl:text>, Post Code:</xsl:text>
													<xsl:value-of select ="authorisationstate/postcoderesultvalue" />
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">3D Secure Result:</td>
												<td width="450" class="bodysmalltext">
													<xsl:value-of select="authorisationstate/threedsatatus"/>
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">Customer Name:</td>
												<td width="450" class="bodysmalltext">
													<xsl:choose>
                                                    <xsl:when test = "string-length(transaction/customername) != 0" >
                                                    <xsl:value-of select ="transaction/customername" />
                                                    </xsl:when>
                                                    <xsl:when test = "string-length(card/cardholder) != 0" >
                                                    <xsl:value-of select ="card/cardholder" />
                                                    </xsl:when> 
                                                    <xsl:otherwise>
                                                    </xsl:otherwise> 
                                                    </xsl:choose>
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">Customer e-mail:</td>
												<td width="450" class="bodysmalltext">
													<a>
														<xsl:attribute name="href"><xsl:text disable-output-escaping="yes">mailto:</xsl:text><xsl:value-of select="transaction/customeremail"/></xsl:attribute>
														<xsl:value-of select="transaction/customeremail"/>
													</a>
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">Contact Number:</td>
												<td width="450" class="bodysmalltext">
													<xsl:value-of select="transaction/contactnumber"/>
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">Contact Fax:</td>
												<td width="450" class="bodysmalltext">
													<xsl:value-of select="transaction/contactfax"/>
												</td>
											</tr>
											<tr>
												<td width="150" class="bodysmalltextBold">IP Address Location:</td>
												<td width="450" class="bodysmalltext">
													<xsl:value-of select="iplocation"/>
												</td>
											</tr>											
											<tr>
												<td width="150" class="bodysmalltextBold">Card Used:</td>
												<td width="450" class="bodysmalltext">Card used: <xsl:value-of select ="paymentsystem/paymentsystemname" /> - <xsl:value-of select ="card/cardnumber" /> - Attempt:<xsl:value-of select ="authorisationstate/authorisationattempt" />
												</td>
											</tr>											
											<tr>
												<td width="150" class="bodysmalltextBold">Card Issuer:</td>
												<td width="450" class="bodysmalltext">
													<xsl:value-of select ="card/cardissuer" />
												</td>
											</tr>											
											<tr>
												<td width="600" colspan="2" class="greyHzShadeBar">
												</td>
											</tr>
										</table>
										<table width="100%" cellpadding="0" cellspacing="0" border="0">
											<tr>
												<td width="100%" align="left">
													<!--Basket contents table start-->
													<table width="100%" cellpadding="0" cellspacing="5" border="0">
													  <tr>
														<td width="20" valign="top">
														 <img border="0">
																			<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='email_bullet_img_file']"/></xsl:attribute>
																			<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='email_bullet']"/></xsl:attribute>
																		</img>
																		</td>
																		<td width="578" class="sagepayOrangeHeading">Order total: <xsl:value-of select ="transaction/formatedamount" /><xsl:text disable-output-escaping="yes"> </xsl:text><xsl:value-of select ="transaction/currency" /> </td>
																	</tr>	
																	<tr>
																		<td width="20" valign="top"></td>
																		<td width="578"  class="sagepaySmalltext">Card used: <xsl:value-of select ="card/cardissuer" /> - <xsl:value-of select ="paymentsystem/paymentsystemname" /> - <xsl:value-of select ="card/cardnumber" /> - Attempt:<xsl:value-of select ="authorisationstate/authorisationattempt" /></td>
					
																	</tr>
											<tr>
												<td width="100%" colspan="2" class="greyHzShadeBar">
												</td>
											</tr>				
																	
														<tr>
															<td width="20" valign="top">
																<img border="0">
																	<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='email_bullet_img_file']"/></xsl:attribute>
																	<xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='email_bullet']"/></xsl:attribute>
																</img>
															</td>
															<td width="578" class="sagepayOrangeHeading">
																<b>Your customer bought: <xsl:value-of select="transaction/description"/>
																</b>
															</td>
														</tr>
														<tr>
															<td width="598" colspan="2">
																<!--Basket contents table start-->
																<table width="598" cellpadding="0" cellspacing="5" border="0">
												<xsl:if test="showbasket = 'true'">
																	<tr>
																		<td width="598" colspan="2">
																			<table class="formTable" id="shoppingBasket">
                                                                                <thead>
																				    <tr>
																					    <td width="30%" align="left">
																						    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_description']"/>
																					    </td>
																					    <td width="14%" align="right">
																						    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_quantity']"/>
																					    </td>
																					    <td width="14%" align="right">
																						    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_value']"/>
																					    </td>
																					    <td width="14%" align="right">
																						    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_tax']"/>
																					    </td>
																					    <td width="14%" align="right">
																						    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_total']"/>
																					    </td>
																					    <td width="14%" align="right">
																						    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_linetotal']"/>
																					    </td>
																				    </tr>
                                                                                </thead>
                                                                                <tbody>
																				    <xsl:for-each select="//lineitem">
																					    <tr>
																						    <td align="left">
																							    <xsl:value-of select="description" disable-output-escaping="yes"/>
																						    </td>
																						    <td align="right">
																							    <xsl:value-of select="quantity" disable-output-escaping="yes"/>
																						    </td>
																						    <td align="right">
																							    <xsl:value-of select="itemvalue" disable-output-escaping="yes"/>
																						    </td>
																						    <td align="right">
																							    <xsl:value-of select="itemtax" disable-output-escaping="yes"/>
																						    </td>
																						    <td align="right">
																							    <xsl:value-of select="itemtotal" disable-output-escaping="yes"/>
																						    </td>
																						    <td align="right">
																							    <xsl:value-of select="linetotal" disable-output-escaping="yes"/>
																						    </td>
																					    </tr>
																				    </xsl:for-each>
                                                                                </tbody>
																			</table>
																		</td>
																	</tr>
																	</xsl:if>
																</table>
															</td>
														</tr>
												        <tr>
												            <td width="100%" colspan="2" class="greyHzShadeBar">
												            </td>
											            </tr>	
													</table>
                                                    <br/>
													<table width="100%" cellpadding="0" cellspacing="5" border="0" >
														<xsl:if test="$vpsprotocol &lt; 2.23" >
                                                        <tr>
															<td width="190" align="left" style="padding-left: 20px;">
															<xsl:if test="transaction/deliveryaddress">
																<div class="bodytextOrange"><b>Delivery Address:</b></div>
																<div class="address">
																<xsl:variable name="input" select="transaction/deliveryaddress" />
																<xsl:variable name="exp">
																<xsl:text>&#10;</xsl:text>
																</xsl:variable>
																<xsl:variable name="replace">&#x3c;br/&#x3e;</xsl:variable>
																<xsl:variable name="output" select="replace(string($input),$exp, $replace)" />
																<xsl:value-of select="$output" disable-output-escaping="yes" />
																<br/>
																<xsl:value-of select ="transaction/deliverypostcode" />											
																</div>										
															</xsl:if>
															</td>
															<td width="190" align="left">
															<xsl:if test="transaction/billingaddress">
																<div class="bodytextOrange"><b>Billing Address:</b></div>
																<div class="address">
																<xsl:variable name="input" select="transaction/billingaddress" />
																<xsl:variable name="exp">
																<xsl:text>&#10;</xsl:text>
																</xsl:variable>
																<xsl:variable name="replace">&#x3c;br/&#x3e;</xsl:variable>
																<xsl:variable name="output" select="replace(string($input),$exp, $replace)" />
																<xsl:value-of select="$output" disable-output-escaping="yes" />
																<br/>
																<xsl:value-of select ="transaction/billingpostcode" />											
																</div>										
															</xsl:if>	
															</td>
															<td width="190" align="left">
															<xsl:if test="card/cardaddress">
																<div class="bodytextOrange"><b>Card Address:</b></div>
																<div class="address">
																<xsl:variable name="input" select="card/cardaddress" />
																<xsl:variable name="exp">
																<xsl:text>&#10;</xsl:text>
																</xsl:variable>
																<xsl:variable name="replace">&#x3c;br/&#x3e;</xsl:variable>
																<xsl:variable name="output" select="replace(string($input),$exp, $replace)" />
																<xsl:value-of select="$output" disable-output-escaping="yes" />
																<br/>
																<xsl:value-of select ="card/cardpostcode" />											
																</div>										
															</xsl:if>	
															</td>
														</tr>
                                                        </xsl:if>
                                                        <xsl:if test="$vpsprotocol &gt; 2.22" >
                                                        <tr>
                                                            <td width="200" style="padding-left: 10px;" valign="top">
                                                            <xsl:if test="transaction/deliveryaddress">                                            
                                                                <div class="bodytextOrange"><b>Delivery Address:</b></div>
                                                                <div class="address">
                                                                <xsl:value-of select="transaction/deliveryfirstnames"/><xsl:text> </xsl:text>
                                                                <xsl:value-of select="transaction/deliverysurname"/>
                                                                <br/>
                                                                <xsl:value-of select="transaction/deliveryaddress"/>
                                                                <xsl:variable name="deliveryaddress2">
                                                                    <xsl:value-of select="transaction/deliveryaddress2"/>
                                                                </xsl:variable>
                                                                <xsl:if test="string-length($deliveryaddress2)>0">
                                                                <br/>
                                                                    <xsl:value-of select="transaction/deliveryaddress2"/>
                                                                </xsl:if>
                                                                <br/>
                                                                <xsl:value-of select ="transaction/deliverycity" />	
                                                                <xsl:variable name="deliverystate">
                                                                    <xsl:value-of select="transaction/deliverystate"/>
                                                                </xsl:variable>
                                                                <xsl:if test="string-length($deliverystate)>0">
                                                                <br/>
                                                                <xsl:value-of select ="transaction/deliverystate" />
                                                                </xsl:if>
                                                                <br/>
                                                                <xsl:value-of select ="transaction/deliverypostcode" />
                                                                <br/>
                                                                <xsl:value-of select ="transaction/deliverycountry" />																
                                                                <xsl:if test="string-length(transaction/deliveryphone)>0">
                                                                <br/><br/>
                                                                Tel: <xsl:value-of select ="transaction/deliveryphone" />
                                                                </xsl:if>
                                                                </div>										
                                                            </xsl:if>
                                                            </td>
                                                            <td width="190" valign="top">
                                                            <xsl:if test="transaction/billingaddress">
                                                                
                                                                <div class="bodytextOrange"><b>Billing Address:</b></div>
                                                                <div class="address">
                                                                <xsl:value-of select="transaction/billingfirstnames"/><xsl:text> </xsl:text>
                                                                <xsl:value-of select="transaction/billingsurname"/>
                                                                <br/>
                                                                <xsl:value-of select="transaction/billingaddress"/>
                                                                <xsl:variable name="billingaddress2">
                                                                    <xsl:value-of select="transaction/billingaddress2"/>
                                                                </xsl:variable>
                                                                <xsl:if test="string-length($billingaddress2)>0">
                                                                <br/>
                                                                    <xsl:value-of select="transaction/billingaddress2"/>
                                                                </xsl:if>
                                                                <br/>
                                                                <xsl:value-of select ="transaction/billingcity" />	
                                                                <xsl:variable name="billingstate">
                                                                    <xsl:value-of select="transaction/billingstate"/>
                                                                </xsl:variable>
                                                                <xsl:if test="string-length($billingstate)>0">
                                                                <br/>
                                                                <xsl:value-of select ="transaction/billingstate" />
                                                                </xsl:if>
                                                                <br/>
                                                                <xsl:value-of select ="transaction/billingpostcode" />
                                                                <br/>
                                                                <xsl:value-of select ="transaction/billingcountry" />															
                                                                <xsl:if test="string-length(transaction/billingphone)>0">
                                                                <br/><br/>
                                                                Tel: <xsl:value-of select ="transaction/billingphone" />
                                                                </xsl:if>
                                                                </div>																	
                                                            </xsl:if>	
                                                            </td>
                                                            <td width="190" align="left" valign="top">
                                                            <xsl:if test="card/cardaddress">                                            
                                                                <div class="bodytextOrange"><b>Card Address:</b></div>
                                                                <div class="address">
                                                                <xsl:value-of select="card/cardholder"/>
                                                                <br/>
                                                                <xsl:value-of select ="card/cardaddress" />	
                                                                <xsl:variable name="input" select="card/cardaddress2" />
                                                                  <xsl:variable name="cardaddress2">
                                                                    <xsl:value-of select="card/cardaddress2"/>
                                                                </xsl:variable>
                                                                <xsl:if test="string-length($cardaddress2)>0">
                                                                <br/>
                                                                    <xsl:value-of select="card/cardaddress2"/>
                                                                </xsl:if>
                                                                <br/>
                                                                <xsl:value-of select ="card/cardcity" />	
                                                                <xsl:variable name="cardstate">
                                                                    <xsl:value-of select="card/cardstate"/>
                                                                </xsl:variable>
                                                                <xsl:if test="string-length($cardstate)>0">
                                                                <br/>
                                                                <xsl:value-of select ="card/cardstate" />
                                                                </xsl:if>
                                                                <br/>
                                                                <xsl:value-of select ="card/cardpostcode" />
                                                                <br/>
                                                                <xsl:value-of select ="card/cardcountry" />											
                                                                </div>										
                                                            </xsl:if>	
                                                            </td>
                                                        </tr>
                                                        </xsl:if>
													  <tr>
												            <td width="100%" colspan="3" class="greyHzShadeBar">
												            </td>
											            </tr>	

														<tr>
															<td width="570" align="left" colspan="3">
															<p><br/></p>
																<xsl:if test="string-length(transaction/emailmessage) > 0">
																	<p>
																		<b>Your message:</b>
																		<br/>
																		<xsl:value-of select="transaction/emailmessage" disable-output-escaping="yes"/>
																	</p>
																</xsl:if>
															</td>
														</tr>
													</table>
													<br/>

													<table width="653" cellpadding="0" cellspacing="0" border="0">
									                    <tr>
										                    <td width="653" align="center" class="copyright">Copyright Sage Pay 2010 </td>
									                    </tr>								
								                    </table>
											  </td>
											</tr>
										</table>
									</td>
									<td width="1">
										<img border="0">
											<xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='blankpixel_img_file']"/></xsl:attribute>
										</img>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
