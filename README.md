Sagepay-template
================

A responsive template sample for SagePay.

### Rendering a Template

To render a template, follow these simple steps:

- Double click the Kernow.bat batch file in the CustomTemplates folder (if you are using windows, otherwise copy the contents of that file onto your command line and execute them).
- Select the "Single File" tab.
- Check the "Send Output to File" checkbox
- Click the ... button next to the XML file edit box and browse to CustomTemplates/XML/card_confirmation.xml
- Click the ... button next to the Stylesheet file edit box and browse to CustomTemplates/XSLT/card_confirmation.xslt
- Click the ... button next to the OutputFile edit box and browse to CustomTemplates/HTML and create a new file called card_confirmation.html (NB: when creating the text e-mails, you'd set the file extension to .txt instead of .html)
- Click Run.
- A bar should appear whilst the system is working, then a message saying "Done in xx milliseconds" should appear.
- Now open your web browser and browse directly to CustomTemplates/HTML/card_confirmation.html file.
- This will display the order confirmation page. (NOTE: On some browsers you will need to click to allow Active Content to run if you wish to see the JavaScript mousovers etc. working)

It's a simple as that. When you are changing the XSLT pages, any mistakes you make in the XSLT or XHTML code will be reported in the bottom window of the Kernow page when you click Run. The line number and position are displayed with each error, so it's very easy to debug your code.
