1- HEADERS
===========


#H1 tittle 

or alternatively:

H1 Title 2
=======

#H2 sub-section

or alternatively:

H2 sub-section
--------------

###H3 Other subsections 
etc..



2- EMPHASIS
============

Italics are *stars* , or yet _underscore_ .  Bold text are with **double stars** or __double underscore__.  Can combine both as **_bold and italic_**.   Strikethrough are using ~~two tildes~~ (for some reason not working with LightPaper).  


3- LIST
=======

Order:
------
1. first item of an order  list
2. second item
  You can have subdsds gds 

3. third item 

The indentation does not seem to work either !!!

Un-Order:
---------
* one element
* another one
* etc.


The paragraph is simply separated by two carriage return.  One CR will create a new line.


4- BLOCKQUOTE
=============

Blockquote indents a paragraph of text like the following

> this text is meant to be a blockquote which is , ;ok pk ;lk ;lk ;
> fdois oiu osidf oi ofsdj fods fodsf ds
> of odif soifu osdiuf ds


5- TABLES
=========

Tables are formatted as like the following (outper pipe are optional)

| Field-1   | field-2  | field-3  |
|-----------|----------|----------|
| vaelue 1  | fdvdfvd  | vdssvf   |
| value 2   | fdsfd    | fdsfds   |

n.b. the nice line-up format is not needed, but nicer for the raw text file.



6- CODE
=======

Code blocks are part of Markdown but not syntax highlighting (although many rebderes support it)

Code can be put inlie by putting bacl-ticks around lile `select * from dual`
Blocks are fenced by lines with 3 back-ticks like

```python
#language is indicated so the renderer can do syntax highlighting (when possible) 
s = 'Pyhton code'
print s
```


7- LINKS
========


[I'm an inline-style link] (htttp://google.com)
 
(I can also add a title at end of address "Title").


[I'm a reference-style link][Arbitrary case-insensitive reference text]

[I'm a relative reference to a repository file](../blob/master/LICENSE)

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself]

Some text to show that the reference links can follow later.

[arbitrary case-insensitive reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: http://www.reddit.com


8- FIXED FONT
=============

To write fixed font use backtick:   `This is text with font having fixed size`


