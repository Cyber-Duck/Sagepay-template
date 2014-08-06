// JavaScript Document - Scripting to handle buttons on VSP3 Payment Pages

      <!--
	  	var alreadySubmitted = false;
	  
		function activate(imgName) {
		if (document.images) 
			if (imgName.indexOf('_')==-1) {
				fileName = imgName
			} else {
				fileName = imgName.substring(0,imgName.indexOf('_'))
			}
			if (alreadySubmitted==false) {document[imgName].src = eval(fileName+'_over.src');}
		}

		function inactivate(imgName) {
		if (document.images && !alreadySubmitted) 
			if (imgName.indexOf('_')==-1) {
				fileName = imgName
			} else {
				fileName = imgName.substring(0,imgName.indexOf('_'))
			}
			if (alreadySubmitted==false) {document[imgName].src = eval(fileName+'_btn.src');}
		}
		
		function inactivatecard(imgName) {
		if (document.images && !alreadySubmitted) 
			if (imgName.indexOf('_')==-1) {
				fileName = imgName
			} else {
				fileName = imgName.substring(0,imgName.indexOf('_'))
			}
			if (alreadySubmitted==false) {document[imgName].src = eval(fileName+'_logo.src');}
		}
		

		function deactivateButtons() {
			if (document['change']) {document['change'].src = eval('submittedimg.src');}
			if (document['proceed']) {document['proceed'].src = eval('submittedimg.src');}
			if (document['cancel']) {document['cancel'].src = eval('subsmallimg.src');}
			if (document['back']) {document['back'].src = eval('submittedimg.src');}
			if (document['skip3D']) {document['skip3D'].src = eval('subsmallimg.src');}
		}

		function submitTheForm(formName,clickName) {
			if (alreadySubmitted != true) {
				// Don't deactivate buttons on report screens
				if (formName.substring(0,4)!='rep_') {
					alreadySubmitted = true;
					deactivateButtons();
				}
				document[formName].clickedButton.value=clickName
				document[formName].submit()
			} else {
				sErr = "Duplicate Submission Detected\r\r"
				sErr = sErr+"Information sent to the Sage Pay gateway should only be submitted once.\r"
				sErr = sErr+"Double clicking the mouse, or pressing the <enter>\r"
				sErr = sErr+"or <return> key multiple times can result in the same\r"
				sErr = sErr+"information being sent twice.\r\r"
				sErr = sErr+"The extra submission has been cancelled. Please wait \r"
				sErr = sErr+"for the Sage Pay gateway to respond to your initial submission.\r"
				alert(sErr);
				return false;
			}			
		}
