# Softgames-Challenge

Task: WebView to Swift communication
Start a new mobile app project in Xcode.
(Name the app and project Softgames Test, use any app name space)
Set up a WebView pointing to a folder which should have an HTML document linking to a JavaScript file.
Please note CSS styling is not important, you are more than welcome to make this document look pretty but it is not a requirement.
Have three form fields in the HTML document:
● First name
● Last name
● Date of Birth.
Have two buttons:
1. “Sync” - The first button should send the first and last name to Swift to concatenate
together. The returned result should be displayed on the HTML document. This should
happen synchronously.
2. “Async” - The second button should send the Date of Birth to Swift to check the users
age. The returned result should be displayed on the HTML document. This should happen asynchronously,
in Swift set a 5 second delay before returning the result. This is to mimic a request to a server or 
any long running compute that would need to happen in Swift before the result could be turned.
