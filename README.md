# What's *DcmDict*
**DcmDict** is a Ruby gem (*dcm\_dict*) to handle in a simple way the Data defined within the [DICOM(r)][1] Standard such as DICOM Data Elements or DICOM Unique Identifiers.

# Why *DcmDict*
With the 2014 realease DICOM documents are available in different format including one particularly interesting, the *DocBook* XML version.
As written by D. Clunie on [its web site][2]:
> "... other formats (such as DocBook, HTML, Word and ODT) are also made available for the convenience of implementors who may need to extract machine-readable content, ..."

This is great news for anyone involved in the study of the standard !

Starting from this thing was born the idea of trying to automate the extraction of data from XML documents to make available the information in a simple way that simplifies the study of the DICOM standard, in the hope this idea will be useful and inspiration.

# *DcmDict* features
The library involve *String*, *Array* and *Symbol* class as *refinement* to access to DICOM information. In this way is possible to *play* with the 'Patient's Birth Date' tag defined as (0010,0030) by:
```ruby
> "(0010,0030)".tag_name
 => "Patient's Birth Date"
> 'PatientBirthDate'.tag_vr
 => [:DA]
> "Patient's Birth Date".tag_vm
 => ["1"]
> :patient_birth_date.tag
 => [16, 48]
> [16,48].tag_key
 => "PatientBirthDate"
> [16, 48].tag_group
 => 16
> '00100030'.tag_element
 => 48
> :patient_birth_date.tag_group
 => 16
> "Patient's Birth Date".tag_element
 => 48
```
as weel for UIDs
```ruby
> '1.2.840.10008.1.2'.uid_name
 => "Implicit VR Little Endian: Default Transfer Syntax for DICOM"
> '1.2.840.10008.1.2'.uid_type
 => :transfer_syntax
> "Implicit VR Little Endian: Default Transfer Syntax for DICOM".uid_value
 => "1.2.840.10008.1.2"
```

let see all features in detail:

## Library usage
Thre are two method to using library *extension*: the **refinement** way and the **monkey patching** way.

### Using as *refinement*
For the refinement way is necessary to include the using directive with:
```ruby
using DcmDict::Refine::StringRefine
```
for the String object,
```ruby
using DcmDict::Refine::ArrayRefine
```
for the Array object and

```ruby
using DcmDict::Refine::SymbolRefine
```
for the Symbol object

### Using by *monkey patching*
This is a **deprecated** implementation, anyway for the *monkey patching* is possible to include specific *module* into the class you want to use. There are two base module *DcmDict::Refine::DataElementRefine* and *DcmDict::Refine::UidRefine*.
For example in the String class will have the code:
```ruby
class String
  include DcmDict::Refine::DataElementRefine
  include DcmDict::Refine::UidRefine
end
```
same way for Array and Symbol class

## Data Element data in detail
Any Data Element features can be accessed from a *String*, *Array* or *Symbol* object.

For this object you can access to tag, name, keyword, VR and VM for any single Data Element

The main methods supported are:

|Method  | Note| Type|
|:------|:------------:|:---:|
|**tag**     | tag as Array| Array of two Fixnum|
|**tag_name**    | name of tag| String|
|**tag_keyword** | keyword| String|
|**tag_key** | keyword| String|
|**tag_vr**      | Value Representation| Array of Symbol|
|**tag_vm**      | Value Multeplicity| Array of Symbol|
|**tag_ps**  | tag as string (as standard doc)| String|
|**tag_ary** | tag as Array|Array of two Fixnum|
|**tag_sym** | tag as Symbol|Symbol|
|**tag_ndm** | tag as in Native DICOM Model|String
|**tag_str** | tag as string (symilar to tag_ps)|String|
|**tag_note** | tag note|String|
|**tag_multiple?** | is a multiple tag ? |boolean|
||useful for 'multi tag' attribute||

each data element is indexed by:

|Field|Type|
|:----|:-----|
|**tag_key** | String|
|**tag_ps**  | String|
|**tag_ary** | Array|
|**tag_sym** | Symbol|
|**tag_ndm** | String|
|**tag_str** | String|
|**tag_name** | String|

For this fields is possible to access to data element information.
Consider the case of the tag (0010,1005) (*Patient's Birth Name*), the primary field are:
**'(0010,1005)'**, **"Patient's Birth Name"**, **'PatientBirthName'**, **:patient_birth_name**, **'00101005'** and **[0x0010,0x1005]**

- As string key you may use the standard tag format **'(0010,1005)'**, the tag name **'Patient's Birth Name'**, the tag keyword **'PatientBirthName'** or the Native DICOM Format tag **'00101005'**
- As array key you may use the numeric array **[0x0010,0x1005]**
- As symbol key you may use the **:patient_birth_name** symbol

### example
Consider the previous case of the tag (0010,1005) the code:

```ruby
puts "Patient's Birth Name".tag_ps.inspect
puts [0x0010,0x1005].tag_name.inspect
puts '(0010,1005)'.tag_key.inspect
puts :patient_birth_name.tag_vr.inspect
puts 'PatientBirthName'.tag_vm.inspect
puts '00101005'.tag.inspect
puts '(0010,1005)'.tag_ary.inspect
puts '00101005'.tag_sym.inspect
puts 'PatientBirthName'.tag_ndm.inspect
puts "Patient's Birth Name".tag_str.inspect
puts [0x0010,0x1005].tag_note.inspect
puts [0x0010,0x1005].tag_group.inspect
puts :patient_birth_name.tag_element.inspect
```

will produce


```ruby
"(0010,1005)"
"Patient's Birth Name"
"PatientBirthName"
[:PN]
["1"]
[16, 4101]
[16, 4101]
:patient_birth_name
"00101005"
"(0010,1005)"
""
16
4101
```

### note
The library manage also the 'multiple tag' as *(0020,31XX)* (*Source Image IDs*). For this data element the default tag in array form is [0x0020,0x3122].
All field are expressed as:

|Method/field  | Value|
|:------|:------------:|
|**tag**     | [0x0020,0x3122]|
|**tag_name**    | "Source Image IDs"|
|**tag_keyword** | 'SourceImageIDs'|
|**tag_key** | 'SourceImageIDs'|
|**tag_vr**      |  [:CS]|
|**tag_vm**      |  ["1-n"]|
|**tag_ps**  | '(0020,31XX)'|
|**tag_ary** | [0x0020,0x3122]|
|**tag_sym** | :source_image_ids|
|**tag_ndm** | '00203122'
|**tag_str** | '(0020,3122)'|
|**tag_note** |  'RET'|
|**tag_multiple?** | true|

[0x0020,0x3122] is the default value for group/element pair (*[32, 12578]*), but any valid key will be refers that information:

```ruby
> '(0020,31XX)'.tag_name
 => "Source Image IDs"
> '(0020,31XX)'.tag_ndm
 => "00203122"
> "SourceImageIDs".tag_ary
 => [32, 12578]
> '(0020,3178)'.tag_name
 => "Source Image IDs"
[0x0020,0x3146].tag_sym
 => :source_image_ids
> '00203120'.tag_key
 => "SourceImageIDs"
 > [0x0020,0x3138].tag_vr
 => [:CS]
 > '(0020,3144)'.tag_note
 => "RET"
```
and so on.

## UID data in detail
Any UID features can be accessed from a *String* object.

### UID Values
For this object you can access to value, name and type value any single uid.
Main methods supported are:

|Method  | Note| Type|
|:------|:------------:|:---:|
|**uid_value**     | value of uid| String|
|**uid_name**    | name of uid| String|
|**uid_type** | type of uid| Symbol|

each uid is indexed by:

|Field|Type|
|:----|:-----|
|**uid_value** | String|
|**uid_name**  | String|

For this fields is possible to access to all uid information.
Consider the case of the uid *1.2.840.10008.1.1* (*Verification SOP Class*), the primary field are:
**'1.2.840.10008.1.1'** and **"Verification SOP Class"**
For this uid all field are expressed as:

|Method/field  | Value|
|:------|:------------:|
|**uid_value** | '1.2.840.10008.1.1'|
|**uid_name**  | "Verification SOP Class"|
|**uid_type**  | :sop_class|

#### example
```ruby
> "Verification SOP Class".uid_value
 => "1.2.840.10008.1.1"
> "1.2.840.10008.1.1".uid_type
 => :sop_class
> "1.2.840.10008.1.1".uid_name
 => "Verification SOP Class"
```
### TODO
- Directory Record type
- Well-known Frames of Reference UID Values
- Context Group UID Values
- Standard Color Palettes UID Values
- IOD definition

## How data is extracted
The library also contains a script (*dcm_dict_converter.rb* into *bin* folder) able to download the xml documents and extracts the data in a *Ruby compatible format*.
See the file for details.

## Install

    $ gem install dcm_dict

## Contributing
TBD

## License
Copyright (C) 2014  Enrico Rivarola. See the `LICENSE` and `COPYING` files for license details.

## Source Code
Main source code repository on github at [henrythebuilder/dcm_dict](https://github.com/henrythebuilder/dcm_dict)


[1]: http://medical.nema.org/dicom/        "DICOM Homepage"
[2]: http://www.dclunie.com/dicom-status/status.html "DICOM Standard Status"
