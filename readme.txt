===========
Description
-----------
This is a tool that helps generate the scripts that will be used to make tutorials that can be found on my personal website:

http://derrickho.co.nf/

The app offers a GUI with three text fields.  These fields are analogous to a powerpoint or keynote editor in that the three fields represent a title section and two body sections.  And similarily to a powerpoint editor, new slides may be added or removed.  The end result is a "slide show" of slides.

===========
User manual
-----------

[Slide creation]

If comments text field is selected and "tab" is pressed:
	1) New slide will be created
	2) New slide will become currently selected slide
	3) Copies previous slide's "code" text field

If the "+" button is pressed: 
	1) New slide will be created
	2) New slide will become currently selected slide
	3) All three text fields are blank
	
[Slide destruction]
If the "-" button is pressed:
	1) Deletes currently selected slide

[Opening and Saving]

If you choose to save, a .txt file will we exported to the location of your choosing.  The file contains a script using a protocol that will be read by my personal website to generate a slide show via JavaScript.  The slide show is currently being used as a way to teach things such as programming languages.

You may also open the generated .txt file using this tool.  It will recreate the slide show. This tool expects a specific protocol of which I will refer to as "SSG protocol" (short for Slideshow Script Generator protocol).  SSG protocol should help you recreate the slide show.  If the text file you choose to open does not conform to SSG protocol the result is undefined.

If the .txt file follos SSG protocol correctly, the current slide show will be deleted and filled with the slide show specified by the script in the .txt file.

[Special Characters]
~ and ` are reserved characters in the "code" text field.
If ~ is the first character of a line it will indicate that this line is to be highlighted by a SSG protocol compliant interpreter.

Each ` in the begining of each line will indicate indentation.

[SSG protocol template]

@code
<!doctype>
<html>
`<head>
``<meta charset="utf-8">
``<script>
~`window.onload = function() {
~``document.write("hello World" + "<br>");
~`}
``</script>
`<head>
`<body>
`</body>
</html>
@header
This is a header
@comment
This is the comments section
@addSlide
@code
This as a place holder for more code

The above space means that there should be a space appearing too
//The double slashes mean a comment and a span should be made for this
@header
more heading
@comment
Add more comments
@addSlide
@questions
should there be anymore code here?
@answer
no, there should me no more code after the questions macro is written
Every new line character should be translated into a line break in html.

@question
how do we know when the file is done?
@answer
There are two ways.  I can end it with an "AT" end. or I can keep going until i reach
the end of the file.  In javaScript I am unceratin how it will handle that so To be
safe I am going to just end it with the AT end
@end
