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
				<xsl:when test="string-length($i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='clientemail_title']) > 0">
					<xsl:value-of select="language"/>
				</xsl:when>
				<xsl:otherwise>en</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="state" select="transactionstate/txstateid"/>
        <xsl:variable name="vpsprotocol" select="transaction/vpsprotocol"/>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_title']"/>
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="string-length(payment-model/transaction/test) != 0">
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_test_message1']"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_test_message2']"/>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:text/>
		<xsl:choose>
			<xsl:when test="$state='16' or $state='15' or $state='14' or $state='21'">
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_order_from_part1']"/>													
				<xsl:value-of select ="vendor/vendorprovidedname" />
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_order_from_part2']"/>	
				<xsl:text>&#13;&#10;</xsl:text>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_unique_reference']"/>
				<xsl:value-of select="transaction/vendortxcode"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_cancel_notification']"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="string-length(transaction/customername) != 0">
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_greeting']"/>
			<xsl:value-of select="transaction/customername"/>
			<xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:text/>
		<xsl:choose>
			<xsl:when test="$state='16' and transaction/transactiontypeid='1' ">
			    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_msg']"/>	
			</xsl:when>
			<xsl:when test="$state='14' and transaction/transactiontypeid='3' ">
				<xsl:text>Thank you for your order.  Your card was authorised successfully but NO money has been debited from your account.  Your card will only be debited when </xsl:text>
				<xsl:value-of select="vendor/vendorprovidedname"/>
				<xsl:text> review the order and release the payment.</xsl:text>
				
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_but']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_msg_no_money']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_deffered_success_msg_line3']"/>
				<xsl:value-of select ="vendor/vendorprovidedname" /> 
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_deffered_success_msg_line4']"/>				
			</xsl:when>
			<xsl:when test="$state='16' and transaction/transactiontypeid='4' ">
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_but']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_msg_no_money']"/>			
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line3']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line4']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line5']"/>
			</xsl:when>
			<xsl:when test="($state='15' or $state='21') and (transaction/transactiontypeid='5')">
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_authenticate_success_msg_line1']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_success_msg_no_money']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line3']"/>					
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line4']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_preauth_success_msg_line5']"/>		
			</xsl:when>
			<xsl:otherwise>		
				
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part1']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part2']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part3']"/>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part4']"/>
				<xsl:text>&#13;&#10;</xsl:text>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part5']"/>
				<xsl:text>&#13;&#10;</xsl:text>
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_abort_part6']"/>
																
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="($state='16' or $state='15' or $state='14' or $state='21') and string-length(transaction/emailmessage) != 0">
			<xsl:text/>
			<xsl:value-of select="transaction/emailmessage" disable-output-escaping="yes"/>
			<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		</xsl:if>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_quote_orderno_part1']"/>	
		<xsl:value-of select="transaction/vendortxcode"/>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_quote_orderno_part2']"/>
		<xsl:value-of select="vendor/vendorprovidedname"/>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_quote_orderno_part3']"/>	
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_ordertottal']"/>
		<xsl:value-of select ="transaction/formatedamount" /><xsl:text> </xsl:text><xsl:value-of select ="transaction/currency" />
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_cardused']"/>
 		<xsl:value-of select ="card/cardissuer" />
		<xsl:text> - </xsl:text>
 		<xsl:value-of select="paymentsystem/paymentsystemname"/>
		<xsl:text> - </xsl:text>
		<xsl:value-of select="card/cardnumber"/>
		<xsl:text> - </xsl:text><xsl:value-of select ="card/cardnumber" /><xsl:text> - </xsl:text><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_attempt']"/>
		<xsl:value-of select="authorisationstate/authorisationattempt"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_you_bought']"/>
		<xsl:value-of select="transaction/description"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="showbasket = 'true'">
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:text>--------------------------------------------------------------------------------------------------------------------------</xsl:text>
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
			<xsl:text>--------------------------------------------------------------------------------------------------------------------------</xsl:text>
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
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_deliveryaddress']"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="transaction/deliveryaddress"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="transaction/deliverypostcode"/>
		</xsl:if>
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="transaction/billingaddress">
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_billingaddress']"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="transaction/billingaddress"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="transaction/billingpostcode"/>
		</xsl:if>
		<xsl:text>&#13;&#10;</xsl:text><xsl:text>&#13;&#10;</xsl:text>
		<xsl:if test="card/cardaddress">
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_cardaddress']"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="card/cardaddress"/>
			<xsl:text>&#13;&#10;</xsl:text>
			<xsl:value-of select="card/cardpostcode"/>
		</xsl:if>
        </xsl:if>
        <xsl:if test="$vpsprotocol &gt; 2.22" >
		<xsl:if test="transaction/deliveryaddress">
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_deliveryaddress']"/>
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
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_deliveryaddress']"/>
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
			<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_cardaddress']"/>
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
		<xsl:choose>
			<xsl:when test="FromEMail='support@sagepay.com'">
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_anyquestion_part1']"/> 
				<xsl:value-of select ="vendor/vendorprovidedname" /> 
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_anyquestion_part2_via']"/>
				<xsl:value-of select="FromEMail"/>
			</xsl:when>
			<xsl:otherwise>			
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_anyquestion_part1']"/> 
				<xsl:value-of select ="vendor/vendorprovidedname" /> 
				<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_anyquestion_part2_via']"/>
				<xsl:text>.</xsl:text>																		
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_sagepay_part1']"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_sagepay_part2']"/><a href="mailto:support@sagepay.com">support@sagepay.com</a>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_sagepay_part3']"/>
		<xsl:text>&#13;&#10;</xsl:text>
		<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clientemail_sagepay_part4']"/>
		<xsl:value-of select="vendor/vendorprovidedname"/>
		<xsl:text> directly.</xsl:text>
		<xsl:text>&#13;&#10;</xsl:text>
	</xsl:template>
</xsl:stylesheet>
