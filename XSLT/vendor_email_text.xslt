<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:jstr="http://www.jclark.com/xt/java/java.lang.String">
	<xsl:template name="extraline">
		<xsl:param name="value">1</xsl:param>
		<xsl:param name="startpos">1</xsl:param>
		<xsl:param name="len">50</xsl:param>
		<xsl:value-of select="substring($value,$startpos,$len)"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="string-length($value) > ($startpos + $len) ">
			<xsl:call-template name="extraline">
				<xsl:with-param name="value" select="$value"/>
				<xsl:with-param name="startpos" select="$startpos + $len"/>
				<xsl:with-param name="len" select="50"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:output method="text"/>
	<xsl:template match="/payment-model">
		<!-- select the languages to use default is english-->
		<xsl:variable name="i18n" select="document('i18n.xml')"/>
		<xsl:variable name="requiredlang">
			<xsl:value-of select="language"/>
		</xsl:variable>
		<xsl:variable name="lang">
			<xsl:choose>
				<xsl:when test="string-length($i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='threed_d_page_tittle']) > 0">
					<xsl:value-of select="language"/>
				</xsl:when>
				<xsl:otherwise>en</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
        <xsl:variable name="vpsprotocol" select="transaction/vpsprotocol"/>
		<xsl:variable name="state" select="transactionstate/txstateid"/>
		<xsl:variable name="txtypename">
			<xsl:choose>
				<xsl:when test="transaction/transactiontypeid='1'">PAYMENT</xsl:when>
				<xsl:when test="transaction/transactiontypeid='2'">REFUND</xsl:when>
				<xsl:when test="transaction/transactiontypeid='3'">DEFERRED</xsl:when>
				<xsl:when test="transaction/transactiontypeid='4'">PREAUTH</xsl:when>
				<xsl:when test="transaction/transactiontypeid='5'">AUTHENTICATE</xsl:when>
				<xsl:when test="transaction/transactiontypeid='6'">REPEAT</xsl:when>
				<xsl:when test="transaction/transactiontypeid='7'">REPEATDEFERRED</xsl:when>
				<xsl:when test="transaction/transactiontypeid='10'">AUTHORISE</xsl:when>
				<xsl:when test="transaction/transactiontypeid='11'">MANUAL</xsl:when>
				<xsl:otherwise>UNKNOWN</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="string-length(transaction/test) != 0">
			<xsl:text>** This is a TEST Order placed on the Sage Pay Test Environment **</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text>** NO MONEY WILL BE TAKEN FROM THE CUSTOMER **</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="$state='16' or $state='15' or $state='14' or $state='21'">
				<xsl:text>Sage Pay SUCCESS notification</xsl:text>
				<xsl:text>&#13;&#10;</xsl:text>
				<xsl:text>The unique reference for this transaction is:</xsl:text>
				<xsl:value-of select="transaction/vendortxcode"/>				
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>** Sage Pay FAILURE notification **</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:choose>
			<xsl:when test="$state='16' or $state='14' or $state='15' or $state='21'">
				<xsl:text>A customer performed a successful </xsl:text> <xsl:value-of select="$txtypename"/><xsl:text> transaction with the following order details:</xsl:text>
			</xsl:when>
			<xsl:when test="$state='12'">
				<xsl:text>The following transaction FAILED... The Bank did NOT AUTHORISE the customer's card.</xsl:text>
			</xsl:when>
			<xsl:when test="$state='11'">
				<xsl:text>The following transaction FAILED... The Customer Aborted the payment process.</xsl:text>
			</xsl:when>
			<xsl:when test="$state='8'">
				<xsl:text>The following transaction FAILED... The Sage Pay System TIMED-OUT the payment process.</xsl:text>
			</xsl:when>
			<xsl:when test="$state='10'">
				<xsl:text>The following transaction was REJECTED... By Vendor Rules.</xsl:text>
			</xsl:when>
			<xsl:when test="$state='15'">	
				<xsl:text>The following transaction was AUTHENTICATED successful.</xsl:text>
	     	</xsl:when>							        			
			<xsl:otherwise>
				<xsl:text>The following transaction FAILED... An error occurred at Sage Pay.  Please contact us with the details shown below.</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Transaction type: </xsl:text>
		<xsl:value-of select="$txtypename"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>VendorTxCode: </xsl:text>
		<xsl:value-of select="transaction/vendortxcode"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>VPSTxId: </xsl:text>
		<xsl:value-of select="transaction/transactionid"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="$state='16' or $state='14'">
			<xsl:text>VPS Auth Code: </xsl:text>
			<xsl:value-of select="authorisationstate/vpsauthcode"/>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:text>Amount: </xsl:text>
		<xsl:value-of select ="transaction/formatedamount" /><xsl:text> </xsl:text><xsl:value-of select ="transaction/currency" />
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:choose>
			<xsl:when test="transaction/allowgiftaid='2'">
				<xsl:text>Gift Aid: Yes - The customer checked the Gift Aid box on the payment pages.</xsl:text>
			</xsl:when>
			<xsl:when test="transaction/allowgiftaid='1'">
				<xsl:text>Gift Aid: No - The Gift Aid option was present by the customer did not check it.</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Gift Aid: No - Not a Gift Aid transaction.</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>AVS/CV2 Response: </xsl:text>
		<xsl:value-of select="authorisationstate/avscv2response"/>
		<xsl:text> - CV2:</xsl:text>
		<xsl:value-of select ="authorisationstate/cv2resultvalue" />
		<xsl:text>, Address:</xsl:text>
		<xsl:value-of select ="authorisationstate/addressresultvalue" />
		<xsl:text>, Post Code:</xsl:text>
		<xsl:value-of select ="authorisationstate/postcoderesultvalue" />
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>3D Secure Result: </xsl:text>
		<xsl:value-of select="authorisationstate/threedsatatus"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Customer Name: </xsl:text>
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
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Customer e-mail: </xsl:text>
		<xsl:value-of select="transaction/customeremail"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Contact Number: </xsl:text>
		<xsl:value-of select="transaction/contactnumber"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Contact Fax: </xsl:text>
		<xsl:value-of select="transaction/contactfax"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Customer IP Address: </xsl:text>
		<xsl:value-of select="transaction/clientip"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>IP Address Location: </xsl:text>
		<xsl:value-of select="iplocation"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Card used: </xsl:text>
 		<xsl:value-of select ="card/cardissuer" />
		<xsl:text> - </xsl:text>
 		<xsl:value-of select="paymentsystem/paymentsystemname"/>
		<xsl:text> - </xsl:text>
		<xsl:value-of select="card/cardnumber"/>
		<xsl:text>- Attempt: </xsl:text>
		<xsl:value-of select="authorisationstate/authorisationattempt"/>
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>Your customer bought: </xsl:text>
		<xsl:value-of select="transaction/description"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="showbasket = 'true'">
			<xsl:text>------------------------------------------------------------------------------------------------------------------------------------</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text/>
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_description']"/>
			<xsl:text>                                              </xsl:text>
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_quantity']"/>
			<xsl:text>     </xsl:text>
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_value']"/>
			<xsl:text>      </xsl:text>
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_tax']"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_total']"/>
			<xsl:text>  </xsl:text>
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='item_linetotal']"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text>------------------------------------------------------------------------------------------------------------------------------------</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<!--Description                                              Quantity      Item value      Item Tax Item Total  Line Total-->
			<xsl:variable name="spaces">
				<xsl:text>                                                                  </xsl:text>
			</xsl:variable>
			<xsl:for-each select="//lineitem">
				<xsl:variable name="descr">
					<xsl:choose>
						<xsl:when test="string-length(normalize-space(description)) > 50">
							<xsl:value-of select="substring(normalize-space(description),1,50)"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="normalize-space(description)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:text/>
				<xsl:value-of select="$descr" disable-output-escaping="yes"/>
				<xsl:variable name="paddingrequired1" select="(57-string-length($descr))"/>
				<xsl:value-of select="substring($spaces,1,$paddingrequired1)"/>
				<xsl:value-of select="quantity" disable-output-escaping="yes"/>
				<xsl:variable name="paddingrequired2" select="13-string-length(quantity)"/>
				<xsl:value-of select="substring($spaces,1,$paddingrequired2)"/>
				<xsl:value-of select="itemvalue" disable-output-escaping="yes"/>
				<xsl:variable name="paddingrequired3" select="16-string-length(itemvalue)"/>
				<xsl:value-of select="substring($spaces,1,$paddingrequired3)"/>
				<xsl:value-of select="itemtax" disable-output-escaping="yes"/>
				<xsl:variable name="paddingrequired4" select="9-string-length(itemtax)"/>
				<xsl:value-of select="substring($spaces,1,$paddingrequired4)"/>
				<xsl:value-of select="itemtotal" disable-output-escaping="yes"/>
				<xsl:variable name="paddingrequired5" select="12-string-length(itemtotal)"/>
				<xsl:value-of select="substring($spaces,1,$paddingrequired5)"/>
				<xsl:value-of select="linetotal" disable-output-escaping="yes"/>
				<xsl:text>&#13;&#10;</xsl:text>
				<xsl:if test="string-length(normalize-space(description)) > 50">
					<xsl:call-template name="extraline">
						<xsl:with-param name="value" select="substring(normalize-space(description),51)"/>
						<xsl:with-param name="startpos" select="1"/>
						<xsl:with-param name="len" select="50"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
        <xsl:if test="$vpsprotocol &lt; 2.23" >
		<xsl:if test="transaction/deliveryaddress">
			<xsl:text>Delivery Address:</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="transaction/deliveryaddress"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="transaction/deliverypostcode"/>
		</xsl:if>
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="transaction/billingaddress">
			<xsl:text>Billing Address:</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="transaction/billingaddress"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="transaction/billingpostcode"/>
		</xsl:if>
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="card/cardaddress">
			<xsl:text>Card Address:</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="card/cardaddress"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="card/cardpostcode"/>
		</xsl:if>
        </xsl:if>
        <xsl:if test="$vpsprotocol &gt; 2.22" >
		<xsl:if test="transaction/deliveryaddress">
			<xsl:text>Delivery Address:</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select="transaction/deliveryfirstnames"/><xsl:text> </xsl:text>
            <xsl:value-of select="transaction/deliverysurname"/>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select="transaction/deliveryaddress"/>
            <xsl:variable name="deliveryaddress2">
                <xsl:value-of select="transaction/deliveryaddress2"/>
            </xsl:variable>
            <xsl:if test="string-length($deliveryaddress2)>0">
				<xsl:text>&#13;&#10;</xsl:text>
                <xsl:value-of select="transaction/deliveryaddress2"/>
            </xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select ="transaction/deliverycity" />	
                 <xsl:variable name="deliverystate">
            <xsl:value-of select="transaction/deliverystate"/>
            </xsl:variable>
            <xsl:if test="string-length($deliverystate)>0">
				<xsl:text>&#13;&#10;</xsl:text>
                 <xsl:value-of select ="transaction/deliverystate" />
            </xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select ="transaction/deliverypostcode" />
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select ="transaction/deliverycountry" />															
            <xsl:if test="string-length(transaction/deliveryphone)>0">
                <xsl:text>&#13;&#10;</xsl:text>Tel: <xsl:value-of select ="transaction/deliveryphone" />
            </xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="transaction/billingaddress">
			<xsl:text>Billing Address:</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select="transaction/billingfirstnames"/><xsl:text> </xsl:text>
            <xsl:value-of select="transaction/billingsurname"/>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select="transaction/billingaddress"/>
            <xsl:variable name="billingaddress2">
                <xsl:value-of select="transaction/billingaddress2"/>
            </xsl:variable>
            <xsl:if test="string-length($billingaddress2)>0">
				<xsl:text>&#13;&#10;</xsl:text>
                <xsl:value-of select="transaction/billingaddress2"/>
            </xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select ="transaction/billingcity" />	
                 <xsl:variable name="billingstate">
            <xsl:value-of select="transaction/billingstate"/>
            </xsl:variable>
            <xsl:if test="string-length($billingstate)>0">
				<xsl:text>&#13;&#10;</xsl:text>
                 <xsl:value-of select ="transaction/billingstate" />
            </xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select ="transaction/billingpostcode" />
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select ="transaction/billingcountry" />															
            <xsl:if test="string-length(transaction/billingphone)>0">
                <xsl:text>&#13;&#10;</xsl:text>Tel: <xsl:value-of select ="transaction/billingphone" />
            </xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="card/cardaddress">
			<xsl:text>Card Address:</xsl:text>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select="card/cardholder"/>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select="card/cardaddress"/>
            <xsl:variable name="cardaddress2">
                <xsl:value-of select="card/cardaddress2"/>
            </xsl:variable>
            <xsl:if test="string-length($cardaddress2)>0">
				<xsl:text>&#13;&#10;</xsl:text>
                <xsl:value-of select="card/cardaddress2"/>
            </xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select ="card/cardcity" />	
                 <xsl:variable name="cardstate">
            <xsl:value-of select="card/cardstate"/>
            </xsl:variable>
            <xsl:if test="string-length($cardstate)>0">
				<xsl:text>&#13;&#10;</xsl:text>
                 <xsl:value-of select ="card/cardstate" />
            </xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select ="card/cardpostcode" />
			<xsl:text>&#13;&#10;</xsl:text>
            <xsl:value-of select ="card/cardcountry" />															
            <xsl:if test="string-length(card/cardphone)>0">
                <xsl:text>&#13;&#10;</xsl:text>Tel: <xsl:value-of select ="card/cardphone" />
            </xsl:if>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
        </xsl:if>	
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
	</xsl:template>
</xsl:stylesheet>
