###A list of different input and form tags and their purpose:

**form** - this tag encloses a form, which can have multiple fieldsets.  The form has, at least, **name** and **action method** properties.
**fieldset** - this tag encloses a number of fields wihtina form - it is not clear whether this is necessary if there is only one field... experiments!
**div** - these tags identify each field within a field set

within each div we seem to have:

**label** these tags occur with in each **div** surround a text node, which labels the field
**input** - rather than opening and closing, the input element is simply declared with its properties: for example:
    <input type="text" name="fullname">
which shows that the user inputs text, I suspect that the string so entered will be passed back as "fullname": "users text", like we saw in the httbin example.
some other input types appear to be:

* text
* email
* password
* date
* checkbox (see below)
* presumably their are other types to validate input, such as number

**placeholder** - this property of the input element puts text (in this case greyed out) within the input field, decribing what it is for
**select** - instead of an input box, select gives us a list to choose from.  options are placed between the open and close of the select element
**option** options are elements which occur within a **select** element.  Each has a value, and a text which is displayed in the list.
**checkbox** - this type of input looks like it might need to have a value attribute as well as a name and a type - "agree" is the example given. also, rather than having a label, it has "  text  " appearing after the element. This may simply be a way of putting the text inline after the checkbox, or may be a different property of checkboxes:  we will find out once we start buiding forms!
**Button** button tags create a button, and have a type attribute - in this case "submit", though I can imagin that "clear" and a number of other possible types exist to perform common actions.  The button text is inculeded in the button element, between the open and close tags - as would be a picture or other identifier of the buttons function.