<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/02/xpath-functions" xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes" xmlns:date="http://exslt.org/dates-and-times" exclude-result-prefixes="xsl fn xs xdt date">
  <xsl:variable name="countries" select="document('countries.xml')"/>
  <xsl:variable name="states" select="document('states.xml')"/>

<xsl:output method="xhtml" encoding="ISO-8859-1" indent="yes" omit-xml-declaration="yes" media-type="text/html" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
	<!-- define the languages document for use -->
    <xsl:variable name="i18n" select="document('i18n.xml')" />
    <xsl:variable name="requiredlang" select="payment-model/language" as="xs:string"/>
    <xsl:variable name="lang">
        <xsl:choose>
            <xsl:when test="string-length($i18n/multi-lingual-text/texts[lang($requiredlang)]/text[@label='threed_d_page_tittle']) &gt; 0">
                <xsl:value-of select="payment-model/language" />
            </xsl:when>
            <xsl:otherwise>en</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    <xsl:variable name="now" select="date:date-time()"/>
    <xsl:variable name="currentyear" select="date:year($now)"/>
    <xsl:variable name="currentmonth" select="date:month-in-year($now)"/>
    <xsl:variable name="imageloc" select="concat(payment-model/imagesURL,payment-model/vendor/vendortemplate,'/')" as="xs:string"/>
    
    <xsl:template match="/">
    <xsl:variable name="vpsprotocol" select="payment-model/transaction/vpsprotocol"/>
		<xsl:variable name="cardtype" select="payment-model/paymentsystem/paymentsystemname"/>
		<xsl:variable name="transactiontypeid" select="payment-model/transaction/transactiontypeid"/>
		<xsl:variable name="usingtoken">
			<xsl:value-of select="payment-model/transaction/usingtoken"/>
		</xsl:variable>
		
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='sagepay_page_title']"/></title>
    <link href="http://dlccustomer.cyberduck.net/css/main.css" media="all" type="text/css" rel="stylesheet"></link>
    <script type="text/javascript" language="javascript">
	  <!--
	  //Preload images for this page-->
	  if (document.images) {
		 var cancel_btn = new Image()
		 cancel_btn.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel_img_file']"/>"
		 var cancel_over = new Image()
		 cancel_over.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel_over_img_file']"/>"
		 var proceed_btn = new Image()
		 proceed_btn.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_img_file']"/>"
		 var proceed_over = new Image()
		 proceed_over.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_over_img_file']"/>"
		 var submittedimg = new Image()
		 submittedimg.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='submitted_img_file']"/>"
		 var subsmallimg = new Image()
		 subsmallimg.src = "<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='submitted_small_img_file']"/>"
		 }
	</script>	 
    <script type="text/javascript" language="javascript" src="{concat(payment-model/imagesURL,'sagepay/buttonscript.js')}" />    

	<script type="text/javascript"> 
	function showHide(obj){
		var curSel=obj.options[obj.selectedIndex].value
		var show=(document.all)? 'block' : 'table-row';
		if(curSel=='US'){ 
			document.getElementById('stateRow').style.display=show;
		}else{
			document.getElementById('stateRow').style.display="none";
		} 
	} 
	</script>
</head>
<body>
	<div id="pageWrapperLow">

  		<div id="formCardDetails">
            <div style="text-align: center; padding: 5px;">
				<span class="errortext">
				<xsl:for-each select="//errormessage">
				<xsl:value-of select="value"/>
				<br/>
				</xsl:for-each>
				</span>
            </div>

            <div class="container">
            <form method="post" name="carddetails" id="carddetails">
                <xsl:attribute name="action"><xsl:value-of select="payment-model/carddetails-action-url"/></xsl:attribute>
                
                    <xsl:if test="$usingtoken != 'true'">
                    <div class="formitem row">
                        <div class="span5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardnumber']"/> <span class="required">required</span></label>
                            <input type="text" name="cardnumber" class="span5" autocomplete="off" />
                        </div>
                        <div class="span7 hidden-phone">
                        <div class="help-text">
                            <p>The long number on the front of your credit or debit card</p></div>
                        </div>
                    </div>
                    
                    <xsl:if test="$vpsprotocol &lt; 2.23">
                    <div class="formitem row">
                        <div class="span5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardholdername']"/> <span class="required">required</span></label>
                            <input name="cardholder" type="text" class="span5"><xsl:attribute name="value"><xsl:value-of select="payment-model/transaction/customername"/></xsl:attribute></input>
                        </div>
                        <div class="span7 hidden-phone">
                        <div class="help-text">
                            <p>Name exactly as it is written on your credit or debit card</p></div>
                        </div>
                    </div>
                    </xsl:if>
                    <xsl:if test="$vpsprotocol &gt; 2.22">
                    <div class="formitem row">
                        <div class="span5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardfirstnames']"/> <span class="required">required</span></label>
                            <input name="cardfirstnames" type="text" class="span5" maxlength="20" autocomplete="off">
                                <xsl:attribute name="value">
                                    <xsl:if test="$transactiontypeid != 15">
                                        <xsl:value-of select="payment-model/transaction/billingfirstnames"/>
                                    </xsl:if>   
                                </xsl:attribute>
                            </input>
                        </div>
                        <div class="span7 hidden-phone">
                        <div class="help-text">
                            <p>Name exactly as it is written on your credit or debit card</p></div>
                        </div>
                    </div>
                    <div class="formitem row">
                        <div class="span5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardsurname']"/> <span class="required">required</span></label>
                            <input name="cardsurname" type="text" class="span5" maxlength="20" autocomplete="off">
                                <xsl:attribute name="value">
                                    <xsl:if test="$transactiontypeid != 15">
                                        <xsl:value-of select="payment-model/transaction/billingsurname"/>
                                    </xsl:if>
                                </xsl:attribute>
                            </input>
                        </div>
                        <div class="span7 hidden-phone">
                        <div class="help-text">
                            <p>Name exactly as it is written on your credit or debit card</p></div>
                        </div>
                    </div>
                    </xsl:if>

                    <div class="formitem row">
                        <div class="span5">
                            <label for="dob"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='valid_from']"/> <span class="required">required</span></label>
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='month']"/>
                            <select name="startmonth" span="2" style="width: 60px; margin-left: 3px;">
                                <option value=""/>
                                <xsl:call-template name="generate_months">
                                    <xsl:with-param name="start" select="1"/>
                                    <xsl:with-param name="end" select="13"/>
                                </xsl:call-template>
                            </select>
                            <span style="padding-left: 5px;">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='year']"/>
                                <select name="startyear" span="2" style="width: 60px; margin-left: 3px;">
                                    <option value=""/>
                                    <xsl:call-template name="generate_years">
                                        <xsl:with-param name="start" select="$currentyear - 20"/>
                                        <xsl:with-param name="end" select="$currentyear + 1"/>
                                    </xsl:call-template>
                                </select>
                            </span>
                        </div>
                        <div class="span7 hidden-phone">
                        </div>
                    </div>

                    <div class="formitem row">
                        <div class="span5">
                            <label for="dob"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='expiry_date']"/> <span class="required">required</span></label>
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='month']"/>
                            <select name="expirymonth" span="2" style="width: 60px; margin-left: 3px;">
                                <option value=""/>
                                <xsl:call-template name="generate_months">
                                    <xsl:with-param name="start" select="1"/>
                                    <xsl:with-param name="end" select="13"/>
                                </xsl:call-template>
                            </select>
                            <span style="padding-left: 5px;">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='year']"/>
                                <select name="expiryyear" span="2" style="width: 60px; margin-left: 3px;">
                                    <option value=""/>
                                    <xsl:call-template name="generate_years">
                                        <xsl:with-param name="start" select="$currentyear - 20"/>
                                        <xsl:with-param name="end" select="$currentyear + 1"/>
                                    </xsl:call-template>
                                </select>
                            </span>
                        </div>
                        <div class="span7 hidden-phone">
                            <div class="help-text">
                            <p>If not present, leave blank</p></div>
                        </div>
                    </div>

                    <div class="formitem row">
                        <div class="span5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='issue_no']"/></label>
                            <input type="text" class="span2" maxlength="2" name="cardissue" style="width: 27px;" autocomplete="off"/>
                        </div>
                        <div class="span7 hidden-phone">
                        <div class="help-text">
                            <p>Switch/Solo only, if not present leave blank</p></div>
                        </div>
                    </div>

                    </xsl:if>

                    <div class="formitem row">
                        <div class="span5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='security_code']"/> <span class="required">required</span></label>
                            <input type="text" class="span2" maxlength="4" name="securitycode" style="width: 50px;" autocomplete="off"/>
                        </div>
                        <div class="span7 hidden-phone">
                        <xsl:if test="$cardtype='LASER'">
                        <div class="help-text">
                            <p><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='laser_000_CV2']"/></p>
                        </div>
                        </xsl:if>
                        </div>
                    </div>

                    <xsl:variable name="allowgiftaid">
                    <xsl:value-of select="payment-model/transaction/allowgiftaid"/>
                    </xsl:variable>
                    <xsl:variable name="vendorSupportGiftaid">
                        <xsl:value-of select="payment-model/vendor/giftaid"/>
                    </xsl:variable>
                    <xsl:if test="$vendorSupportGiftaid='true' and ($allowgiftaid='1' or $allowgiftaid='2')">
                            <div class="formitem row">
                                <div class="span5">
                                    <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='giftdetails']"/></label>
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='gift_statement_part1']"/>
                            <strong><xsl:value-of select="payment-model/vendor/vendorprovidedname"/></strong><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='gift_statement_part2']"/><br /><br />
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clickgift']"/>
                            <input name="giftaid" type="checkbox" value="yes">
                                <xsl:if test="$allowgiftaid='2'">
                                <xsl:attribute name="selected">true</xsl:attribute>
                                </xsl:if>
                            </input>
                                </div>
                                <div class="span7 hidden-phone">
                                    
                                </div>
                            </div>
                    </xsl:if>




            
                <input name="action" type="hidden" value="proceed"/>
                <input type="hidden" name="clickedButton" value=""/>
                <a id="proceedButton" href="#" onmouseover="activate('proceed')" onmouseout="inactivate('proceed')" onclick="submitTheForm('carddetails','proceed');return false">
                    <SCRIPT type="text/javascript" language="JavaScript1.2">
                        document.write('<xsl:text disable-output-escaping="yes">&lt;img border="0" name="proceed" src="</xsl:text>');
                        document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_img_file']"/>');
                        document.write('<xsl:text disable-output-escaping="yes">" alt="</xsl:text>');
                        document.write('<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed']"/>');
                        document.write('<xsl:text disable-output-escaping="yes">"/&gt;</xsl:text>');
                    </SCRIPT>
                </a>
                <NOSCRIPT>
                    <input id="proceedButton" name="proceed" type="image">
                    <xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed_img_file']"/></xsl:attribute>
                    <xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='proceed']"/></xsl:attribute>
                    </input>
                </NOSCRIPT>
                
            </form>

            <form method="post" name="cancelpayment" id="cancelpayment">
            <xsl:attribute name="action"><xsl:value-of select="payment-model/cancelation-action-url"/></xsl:attribute>
                <input type="hidden" name="clickedButton" value=""/>
                <a style="float:left;" href="#" onmouseover="activate('cancel')" onmouseout="inactivate('cancel')" onclick="submitTheForm('cancelpayment','cancel');return false">
                    <SCRIPT type="text/javascript" language="JavaScript">
                        document.write('<xsl:text disable-output-escaping="yes">&lt;img border="0" name="cancel" src="</xsl:text>');
                        document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel_img_file']"/>');
                        document.write('<xsl:text disable-output-escaping="yes">" alt="</xsl:text>');
                        document.write('<xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel']"/>');
                        document.write('<xsl:text disable-output-escaping="yes">"/&gt;</xsl:text>');
                    </SCRIPT>
                </a>
                <NOSCRIPT>
                <input name="cancel" type="image">
                <xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel_img_file']"/></xsl:attribute>
                <xsl:attribute name="alt"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cancel']"/></xsl:attribute>
                </input>
                </NOSCRIPT>
            </form>       
            </div>                     
        </div>
    </div>
</body>
</html>
</xsl:template>
<xsl:template name="generate_years">
<xsl:param name="start" select="2007"/>
<xsl:param name="end" select="2020"/>
<xsl:if test="$start &lt; $end">
    <option>
        <xsl:attribute name="value"><xsl:value-of select="substring( string($start),3,2)"/></xsl:attribute>
        <xsl:value-of select="$start"/>
    </option>
    <xsl:call-template name="generate_years">
        <xsl:with-param name="start" select="$start + 1"/>
        <xsl:with-param name="end" select="$end"/>
    </xsl:call-template>
</xsl:if>
</xsl:template>

<xsl:template name="generate_months">
<xsl:param name="start" select="1"/>
<xsl:param name="end" select="13"/>
<xsl:param name="current" select="0"/>
<xsl:if test="$start &lt; $end">
    <option>
        <xsl:choose>
            <xsl:when test="$start  &lt; 10">
                <xsl:attribute name="value"><xsl:value-of select="concat('0',string($start))"/></xsl:attribute>
                <xsl:if test="$start = $current">
                    <xsl:attribute name="selected"><xsl:value-of select="true"/></xsl:attribute>
                </xsl:if>
                <xsl:value-of select="concat('0',string($start))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="value"><xsl:value-of select="string($start)"/></xsl:attribute>
                <xsl:if test="$start = $current">
                    <xsl:attribute name="selected"><xsl:value-of select="true"/></xsl:attribute>
                </xsl:if>
                <xsl:value-of select="$start"/>
            </xsl:otherwise>
        </xsl:choose>
    </option>
    <xsl:call-template name="generate_months">
        <xsl:with-param name="start" select="$start + 1"/>
        <xsl:with-param name="end" select="$end"/>
        <xsl:with-param name="current" select="$current"/>
    </xsl:call-template>
</xsl:if>
</xsl:template>

<xsl:template name="popup_info">		
<xsl:param name="filename" select="test"/>
<xsl:param name="i18n" select="document('i18n.xml')"/>
<xsl:param name="imageloc" select="none"/>		
<xsl:param name="lang" select="en"/>				
<SCRIPT>
    document.write('<xsl:text disable-output-escaping="yes">&lt;a class="bodybold" href="javascript:popUp(\'</xsl:text>');
    document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$filename"/>');
    document.write('<xsl:text disable-output-escaping="yes">\');"&gt;&lt;img border="0" src="</xsl:text>');
    document.write('<xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='whattodo_img']"/>');
    document.write('<xsl:text disable-output-escaping="yes">"/&gt;&lt;/a&gt;</xsl:text>');
</SCRIPT>
<NOSCRIPT>
    <a class="bodybold">
        <xsl:attribute name="href"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$filename"/></xsl:attribute>
        <xsl:attribute name="target">_blank</xsl:attribute>
        <img border="0">
            <xsl:attribute name="src"><xsl:copy-of select="$imageloc"/><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='whattodo_img']"/></xsl:attribute>
        </img>
    </a>
</NOSCRIPT>		
</xsl:template>

<xsl:template name="liststates">
    <xsl:param name="states" select="document('states.xml')"/>
    <xsl:param name="selection" select="AL"/>				
<xsl:for-each select="$states/states/state">		
    <option>
        <xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute>
        <xsl:if test='$selection=code'>
            <xsl:attribute name="selected">yes</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="name"/>
    </option>
</xsl:for-each>				
</xsl:template>	

<xsl:template name="listcountries">		
<xsl:param name="countries" select="document('countries.xml')"/>
<xsl:param name="selection" select="GB"/>

<xsl:for-each select="$countries/countries/country">		
    <option>
        <xsl:attribute name="value"><xsl:value-of select="code"/></xsl:attribute>
        <xsl:if test='$selection=code'>
            <xsl:attribute name="selected">yes</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="name"/>
    </option>
</xsl:for-each>		
</xsl:template>
</xsl:stylesheet>
