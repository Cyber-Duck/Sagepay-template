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
    <style>
body{color:#666;font-family:"Georgia",serif;margin:0;padding:0;font-size:15px}img{max-width:100%;height:auto}a img{border:0}#formCardDetails{padding:20px 0}#cancelpayment{padding:20px 0}#cancelpayment img{margin:0 0 10px 0}h1{font-size:48px;font-weight:normal;color:#d43c6f;line-height:48px;margin:0;padding:10px 0}h2{font-size:32px;font-weight:normal;margin:0;padding:0 0 10px 0;line-height:32px}h3{font-size:24px;font-weight:normal;margin:0;padding:0 0 10px 0;line-height:24px}p{font-size:14px;line-height:24px;margin:0;padding:10px 0}a{color:#d43c6f;text-decoration:none}a:hover{text-decoration:underline}fieldset{border:0;padding:0;margin:0}.field,.formitem{clear:both;padding:10px 0}.field:after,.formitem:after{content:"";display:block;clear:both}label{display:block;padding:5px 0;font-size:16px;font-weight:bold}input[type="text"],input[type="email"],input[type="tel"],input[type="number"],input[type="url"],input[type="date"],input[type="time"],input[type="password"]{line-height:20px;padding:5px;border:1px solid #ccc;padding:10px;height:40px;width:100%;border:1px solid #ccc;display:block;box-sizing:border-box;-ms-box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;-o-box-sizing:border-box;border-radius:0;-ms-border-radius:0}input[type="text"]:focus,input[type="email"]:focus,input[type="tel"]:focus,input[type="number"]:focus,input[type="url"]:focus,input[type="date"]:focus,input[type="time"]:focus,input[type="password"]:focus{border-color:#666;outline:0}select{padding:5px}textarea{line-height:20px;padding:5px;border:1px solid #ccc;border-radius:0;-ms-border-radius:0}textarea:focus{border-color:#666;outline:0}.required{display:inline-block;padding:2px 5px;font-size:13px;background:#f2f2f2;color:#b3b3b3;margin:0 0 0 20px;font-weight:normal;border-radius:3px}.help-text{font-size:13px;color:#999;padding:20px 0 0 0}.field-error input[type="text"],.field-error input[type="email"],.field-error input[type="tel"],.field-error input[type="number"],.field-error input[type="url"],.field-error input[type="date"],.field-error input[type="time"],.field-error input[type="password"],.field-error select,.field-error textarea{border-color:red}.error{font-size:13px;clear:both;color:red;padding:0}.date{width:50px;margin-left:3px}@media (max-width: 599px){.wrap{overflow:hidden;width:100%}.container{width:100%}.container:after{content:" ";clear:both}.col12,.col11,.col10,.col9,.col8,.col7,.col6,.col5,.col4,.col3{width:92%;margin:0 4%}.col12 .col12,.col12 .col11,.col12 .col10,.col12 .col9,.col12 .col8,.col12 .col7,.col12 .col6,.col12 .col5,.col12 .col4,.col12 .col3,.col11 .col12,.col11 .col11,.col11 .col10,.col11 .col9,.col11 .col8,.col11 .col7,.col11 .col6,.col11 .col5,.col11 .col4,.col11 .col3,.col10 .col12,.col10 .col11,.col10 .col10,.col10 .col9,.col10 .col8,.col10 .col7,.col10 .col6,.col10 .col5,.col10 .col4,.col10 .col3,.col9 .col12,.col9 .col11,.col9 .col10,.col9 .col9,.col9 .col8,.col9 .col7,.col9 .col6,.col9 .col5,.col9 .col4,.col9 .col3,.col8 .col12,.col8 .col11,.col8 .col10,.col8 .col9,.col8 .col8,.col8 .col7,.col8 .col6,.col8 .col5,.col8 .col4,.col8 .col3,.col7 .col12,.col7 .col11,.col7 .col10,.col7 .col9,.col7 .col8,.col7 .col7,.col7 .col6,.col7 .col5,.col7 .col4,.col7 .col3,.col6 .col12,.col6 .col11,.col6 .col10,.col6 .col9,.col6 .col8,.col6 .col7,.col6 .col6,.col6 .col5,.col6 .col4,.col6 .col3,.col5 .col12,.col5 .col11,.col5 .col10,.col5 .col9,.col5 .col8,.col5 .col7,.col5 .col6,.col5 .col5,.col5 .col4,.col5 .col3,.col4 .col12,.col4 .col11,.col4 .col10,.col4 .col9,.col4 .col8,.col4 .col7,.col4 .col6,.col4 .col5,.col4 .col4,.col4 .col3,.col3 .col12,.col3 .col11,.col3 .col10,.col3 .col9,.col3 .col8,.col3 .col7,.col3 .col6,.col3 .col5,.col3 .col4,.col3 .col3{width:100%;margin:0}.col2{width:42%;float:left;margin:0 4%}.full-pho{width:92%;margin:0 4%}.half-pho{width:42%;float:left;margin:0 4%}.colr{float:right;margin:0 10px}.alpha{margin-left:0}.omega{margin-right:0}.clear{clear:both}.help-text{padding-top:0}#cancelpayment{margin:0 4%}#proceedButton{margin:0 0 10px 4%}}@media (min-width: 600px) and (max-width: 1023px){.wrap{overflow:hidden;width:100%}.container{width:100%}.container::after{content:" ";clear:both}.col12,.col11,.col10,.col9,.col8,.col7{width:100%;margin:0;padding:0 10px;box-sizing:border-box;-ms-box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;-o-box-sizing:border-box}.col12 .col12,.col12 .col11,.col12 .col10,.col12 .col9,.col12 .col8,.col12 .col7,.col11 .col12,.col11 .col11,.col11 .col10,.col11 .col9,.col11 .col8,.col11 .col7,.col10 .col12,.col10 .col11,.col10 .col10,.col10 .col9,.col10 .col8,.col10 .col7,.col9 .col12,.col9 .col11,.col9 .col10,.col9 .col9,.col9 .col8,.col9 .col7,.col8 .col12,.col8 .col11,.col8 .col10,.col8 .col9,.col8 .col8,.col8 .col7,.col7 .col12,.col7 .col11,.col7 .col10,.col7 .col9,.col7 .col8,.col7 .col7{width:100%;margin:0}.col6,.col5,.col4,.col3{width:50%;float:left;margin:0;padding:0 10px;box-sizing:border-box;-ms-box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;-o-box-sizing:border-box}.col2{width:33.33%;float:left;margin:0;padding:0 10px;box-sizing:border-box;-ms-box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;-o-box-sizing:border-box}.full-tab{width:100%;margin:0;padding:0 10px;box-sizing:border-box;-ms-box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;-o-box-sizing:border-box}.half-tab{width:50%;float:left;margin:0;padding:0 10px;box-sizing:border-box;-ms-box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;-o-box-sizing:border-box}.one-third-tab{width:33.33%;float:left;margin:0;padding:0 10px;box-sizing:border-box;-ms-box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;-o-box-sizing:border-box}.two-third-tab{width:66.66%;float:left;margin:0;padding:0 10px;box-sizing:border-box;-ms-box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;-o-box-sizing:border-box}.colr{float:right;margin:0 10px}.colr.full-tab{margin:0}.alpha{margin-left:0}.omega{margin-right:0}.clear{clear:both}#cancelpayment{margin:0 1%}#proceedButton{margin:0 0 10px 1%}}@media (min-width: 1024px){.container{width:960px;margin:0 auto}.container:after{content:" ";clear:both}.col1{width:60px;float:left;margin:0 10px}.col2{width:140px;float:left;margin:0 10px}.col3{width:220px;float:left;margin:0 10px}.col4{width:300px;float:left;margin:0 10px}.col5{width:380px;float:left;margin:0 10px}.col6{width:460px;float:left;margin:0 10px}.col7{width:540px;float:left;margin:0 10px}.col8{width:620px;float:left;margin:0 10px}.col9{width:700px;float:left;margin:0 10px}.col10{width:780px;float:left;margin:0 10px}.col11{width:860px;float:left;margin:0 10px}.col12{width:940px;float:left;margin:0 10px}.pre1{padding-left:80px}.pre2{padding-left:160px}.pre3{padding-left:240px}.pre4{padding-left:320px}.pre5{padding-left:400px}.pre6{padding-left:480px}.pre7{padding-left:560px}.pre8{padding-left:640px}.pre9{padding-left:720px}.pre10{padding-left:800px}.suf1{padding-right:80px}.suf2{padding-right:160px}.suf3{padding-right:240px}.suf4{padding-right:320px}.suf5{padding-right:400px}.suf6{padding-right:480px}.suf7{padding-right:560px}.suf8{padding-right:640px}.suf9{padding-right:720px}.suf10{padding-right:800px}.colr{float:right;margin:0 10px}.alpha{margin-left:0}.omega{margin-right:0}.clear{clear:both}.col5 .col5{margin:0}.help-text{padding-top:30px}}
        
    </style>
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
                        <div class="col5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardnumber']"/> <span class="required">required</span></label>
                            <input type="text" name="cardnumber" class="col5" autocomplete="off" />
                        </div>
                        <div class="col7 hidden-phone">
                        <div class="help-text">
                            <p>The long number on the front of your credit or debit card</p></div>
                        </div>
                    </div>
                    
                    <xsl:if test="$vpsprotocol &lt; 2.23">
                    <div class="formitem row">
                        <div class="col5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardholdername']"/> <span class="required">required</span></label>
                            <input name="cardholder" type="text" class="col5"><xsl:attribute name="value"><xsl:value-of select="payment-model/transaction/customername"/></xsl:attribute></input>
                        </div>
                        <div class="col7 hidden-phone">
                        <div class="help-text">
                            <p>Name exactly as it is written on your credit or debit card</p></div>
                        </div>
                    </div>
                    </xsl:if>
                    <xsl:if test="$vpsprotocol &gt; 2.22">
                    <div class="formitem row">
                        <div class="col5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardfirstnames']"/> <span class="required">required</span></label>
                            <input name="cardfirstnames" type="text" class="col5" maxlength="20" autocomplete="off">
                                <xsl:attribute name="value">
                                    <xsl:if test="$transactiontypeid != 15">
                                        <xsl:value-of select="payment-model/transaction/billingfirstnames"/>
                                    </xsl:if>   
                                </xsl:attribute>
                            </input>
                        </div>
                        <div class="col7 hidden-phone">
                        <div class="help-text">
                            <p>Name exactly as it is written on your credit or debit card</p></div>
                        </div>
                    </div>
                    <div class="formitem row">
                        <div class="col5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='cardsurname']"/> <span class="required">required</span></label>
                            <input name="cardsurname" type="text" class="col5" maxlength="20" autocomplete="off">
                                <xsl:attribute name="value">
                                    <xsl:if test="$transactiontypeid != 15">
                                        <xsl:value-of select="payment-model/transaction/billingsurname"/>
                                    </xsl:if>
                                </xsl:attribute>
                            </input>
                        </div>
                        <div class="col7 hidden-phone">
                        <div class="help-text">
                            <p>Name exactly as it is written on your credit or debit card</p></div>
                        </div>
                    </div>
                    </xsl:if>

                    <div class="formitem row">
                        <div class="col5">
                            <label for="dob"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='valid_from']"/> <span class="required">required</span></label>
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='month']"/>
                            <select name="startmonth" span="2" class="date" style="width:50px;margin-left:10px">
                                <option value=""/>
                                <xsl:call-template name="generate_months">
                                    <xsl:with-param name="start" select="1"/>
                                    <xsl:with-param name="end" select="13"/>
                                </xsl:call-template>
                            </select>
                            <span style="padding-left: 5px;">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='year']"/> 
                                <select name="startyear" span="2" class="date" style="width:80px;margin-left:10px">
                                    <option value=""/>
                                    <xsl:call-template name="generate_years">
                                        <xsl:with-param name="start" select="$currentyear - 20"/>
                                        <xsl:with-param name="end" select="$currentyear + 1"/>
                                    </xsl:call-template>
                                </select>
                            </span>
                        </div>
                        <div class="col7 hidden-phone">
                        </div>
                    </div>

                    <div class="formitem row">
                        <div class="col5">
                            <label for="dob"><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='expiry_date']"/> <span class="required">required</span></label>
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='month']"/> 
                            <select name="expirymonth" span="2" class="date" style="width:50px;margin-left:10px">
                                <option value=""/>
                                <xsl:call-template name="generate_months">
                                    <xsl:with-param name="start" select="1"/>
                                    <xsl:with-param name="end" select="13"/>
                                </xsl:call-template>
                            </select>
                            <span style="padding-left: 5px;">
                                <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='year']"/> 
                                <select name="expiryyear" span="2" class="date" style="width:80px;margin-left:10px">
                                    <option value=""/>
                                    <xsl:call-template name="generate_years">
                                        <xsl:with-param name="start" select="$currentyear"/>
                                        <xsl:with-param name="end" select="$currentyear + 20"/>
                                    </xsl:call-template>
                                </select>
                            </span>
                        </div>
                        <div class="col7 hidden-phone">
                            <div class="help-text">
                            <p>If not present, leave blank</p></div>
                        </div>
                    </div>

                    <div class="formitem row">
                        <div class="col5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='issue_no']"/></label>
                            <input type="text" class="span2" maxlength="2" name="cardissue" style="width: 50px;" autocomplete="off"/>
                        </div>
                        <div class="col7 hidden-phone">
                        <div class="help-text">
                            <p>Switch/Solo only, if not present leave blank</p></div>
                        </div>
                    </div>

                    </xsl:if>

                    <div class="formitem row">
                        <div class="col5">
                            <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='security_code']"/> <span class="required">required</span></label>
                            <input type="text" class="span2" maxlength="4" name="securitycode" style="width: 50px;" autocomplete="off"/>
                        </div>
                        <div class="col7 hidden-phone">
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
                    <xsl:if test="$vendorSupportGiftaid='false' and ($allowgiftaid='1' or $allowgiftaid='2')">
                            <div class="formitem row">
                                <div class="col5">
                                    <label><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='giftdetails']"/></label>
                                    <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='gift_statement_part1']"/>
                            <strong><xsl:value-of select="payment-model/vendor/vendorprovidedname"/></strong><xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='gift_statement_part2']"/><br /><br />
                            <xsl:value-of select="$i18n/multi-lingual-text/texts[lang($lang)]/text[@label='clickgift']"/>
                            <input name="giftaid" type="checkbox" value="yes">
                                <xsl:if test="$allowgiftaid='2'">
                                <xsl:attribute name="selected">false</xsl:attribute>
                                </xsl:if>
                            </input>
                                </div>
                                <div class="col7 hidden-phone">
                                    
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
