# What's *DcmDict*
**DcmDict** is a Ruby gem [(*dcm\_dict*)][12] to handle in a simple way the *Data Dictionary* defined within the DICOM<sup>®</sup> Standard <sup id='fn-dcm-trademark'>[1]</sup> such as DICOM Data Elements or DICOM Unique Identifiers.

# Why *DcmDict*
With the new releases from year 2014 DICOM documents are available in different format including one particularly interesting, the *DocBook* XML version.

As confirmed in the DICOM<sup>®</sup> Standard [web site][10] where each part is published in [multiple formats][11] and XML format is defined by:
>"... XML – good for machine readability, e.g. self-updating validators ..."

This is great news for anyone involved in the study of the standard !

Starting from this thing was born the idea of trying to automate the extraction of data from XML documents to make available the information in a simple way that simplifies the study of the DICOM standard, in the hope this idea will be useful and inspiration.

# *DcmDict* features
The library involve *String*, *Array* and *Symbol* class as *refinements* to access to DICOM information.

In this way is possible to *play* with the 'Patient's Birth Date' tag defined as (0010,0030) by:

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

as well for UIDs

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
The library involve **Ruby Refinements** so use it is simple, it is necessary to include the specific *using directive*:

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
for the Symbol object.

That's it.

**Note**: It is possible to use also the the *monkey patching* way, this is a *deprecated* utilization but possible, and, may be, useful technique in certain contexts or for some particular test. For the *monkey patching* is possible to include some specific *common modules* in the class you want to use as "keyword": there are two base modules *DcmDict::Refine::DataElementRefine* and *DcmDict::Refine::UidRefine*.

For example in the String class will have the code:

```ruby
class String
  include DcmDict::Refine::DataElementRefine
  include DcmDict::Refine::UidRefine
end
```

*The main way remains **Ruby Refinements***.

**Rubies compatibility**: at this moment the other considered rubies is only [Rubinius][4] (>= v2.2.10). In order to try to ensure a minimum compatibility there is a file under *lib/dcm_dict/rubies/* called *rb_ext.rb* able to *mask*/*simulates* the refinements by [refine gem][5] and add the required *bit_length* method to *Fixnum* class by [backports gem][6].
This sort of extension is not loaded by default but only into *spec files* for the *'rbx' Ruby Engine*. See *spec_helper.rb* and *rb_ext.rb* for details.

## Data Element data in detail
Any Data Element feature can be accessed from a *String*, *Array* or *Symbol* objects.

For these objects is possible to access to Tag (group/element), Name, Keyword, Value Representation (VR) and Value Multiplicity (VM) for any single Data Element.

The main methods supported are:

|Method  | Note| Type||
|:------|:------------:|:---:|:---:|
|**tag**     | tag as Array| Array of two Fixnum|(alias of *tag_ary*)|
|**tag_name**    | name of tag| String|
|**tag_keyword** | keyword| String|
|**tag_key** | keyword| String|
|**tag_vr**      | Value Representation| Array of Symbol|
|**tag_vm**      | Value Multiplicity| Array of Symbol|
|**tag_ps**  | tag as string (as standard doc)| String|
|**tag_ary** | tag as Array|Array of two Fixnum|
|**tag_sym** | tag as Symbol|Symbol|
|**tag_ndm** | tag as in Native DICOM Model|String|
|**tag_str** | tag as string (similar to tag_ps)|String|
|**tag_note** | tag note|String|
|**tag_multiple?** | is a multiple tag ? |boolean|(useful for 'multi tag' attribute)|

each data element is indexed by these fields:

|Field|Type|
|:----|:-----:|
|**tag_key** | String|
|**tag_ps**  | String|
|**tag_ary** | Array|
|**tag_sym** | Symbol|
|**tag_ndm** | String|
|**tag_str** | String|
|**tag_name** | String|

By these fields is possible to access to data element informations.
Consider the case of the tag (0010,1005) (*Patient's Birth Name*), the primary fields are:
**'(0010,1005)'**, **"Patient's Birth Name"**, **'PatientBirthName'**, **:patient_birth_name**, **'00101005'** and **[0x0010,0x1005]**

- As String key you may use the standard tag format **'(0010,1005)'**, the tag name **'Patient's Birth Name'**, the tag keyword **'PatientBirthName'** or the Native DICOM Format tag **'00101005'**
- As Array key you may use the numeric array **[0x0010,0x1005]**
- As Symbol key you may use **:patient_birth_name**

### example:
Consider the previous case of tag (0010,1005), the code:

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

### Multiple Tag
The library also manage 'multiple tags' such as *(0020,31XX)* (*Source Image IDs*).
As an example for this data element the default tag in array form is [0x0020,0x3122] and all fields are expressed as:

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

[0x0020,0x3122] is the default value for group/element pair (*[32, 12578]*), but any valid pair of numbers for this tag will be refers that information:

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
For these objects is possible to access to value, name and type values for any single uid.
Main methods supported are:

|Method  | Note| Type||
|:------|:------------:|:---:|:---:|
|**uid**     | value of uid| String|(alias of *uid_value*)|
|**uid_value**     | value of uid| String|
|**uid_name**    | name of uid| String|
|**uid_type** | type of uid| Symbol|

each uid is indexed by:

|Field|Type|
|:----|:-----|
|**uid_value** | String|
|**uid_name**  | String|

From these fields is possible to access to all uid informations.
Consider the case of the uid *1.2.840.10008.1.1* (*Verification SOP Class*), the primary fields are the strings **'1.2.840.10008.1.1'** and **"Verification SOP Class"**.
- As String key you may use the standard value **'1.2.840.10008.1.1'** and the uid name **"Verification SOP Class"**

For this uid all fields are expressed as:

|Method/field  | Value|
|:------|:------------:|
|**uid** | '1.2.840.10008.1.1'|
|**uid_value** | '1.2.840.10008.1.1'|
|**uid_name**  | "Verification SOP Class"|
|**uid_type**  | :sop_class|

### example:

```ruby
> "Verification SOP Class".uid_value
 => "1.2.840.10008.1.1"
> "1.2.840.10008.1.1".uid_type
 => :sop_class
> "1.2.840.10008.1.1".uid_name
 => "Verification SOP Class"
> "Verification SOP Class".uid
 => "1.2.840.10008.1.1"
```

## How data is extracted
The library also contains a script (*dcm_dict_converter.rb* in the *bin* folder) able to download the xml documents and extracts the source data in a *Ruby compatible format*.
The script produces the conversion in the *stdout* so for example is possible to extract the Tag Values by:

```ruby
dcm_dict_converter.rb tag > /tmp/tag-dict.rb
```

Note: the script use the [Nokogiri][3] as XML parser if installed as gem, otherwise the standard *REXML*.

Check the file for other details.

## Note
Current library version is aligned to *DICOM Base Standard* **2020a**

## Install

    $ gem install dcm_dict

*Note for Windows users*: may be that it is installed a previous version of Ruby 2.1, if [RubyInstaller][7] does not provide the official release for the supported version it's still possible to make it manually by clone/download the ['git' version of RubyInstaller][8] and execute the rake command ```rake ruby21``` or equivalent (see RubyInstaller doc for details).

## What's next
The main idea is that *dictionary* should include only fixed data defined in the DICOM standard to encode and then make it available in easy way.
There are many possible *candidates* for inclusion in the *dictionary*, here are some *"ideas"*:

- Directory Record type data
- Well-known Frames of Reference UID Values
- Context Group UID Values
- Standard Color Palettes UID Values
- IOD definition data
- ...

## Contributing
TBD

## License
Copyright (C) 2014-2020  Enrico Rivarola.
See the `LICENSE` and `COPYING` files for license details.

## Ruby Gem
Ruby gem **dcm\_dict** on [RubyGems][9] at [rubygems.org/gems/dcm_dict](https://rubygems.org/gems/dcm_dict)

## Source Code
Main source code repository on github at [henrythebuilder/dcm_dict](https://github.com/henrythebuilder/dcm_dict)

<div class="footnotes">
<hr />
<ol>
<li id="fn1-dcm-trademark">
<p><a href="http://www.dicomstandard.org/" title="DICOM Standard">DICOM<sup>®</sup></a> is the registered trademark of the National Electrical Manufacturers Association for its standards publications relating to digital communications of medical information.
<a href="#fn-dcm-trademark"  class='footnoteBackLink'  title="Jump back to footnote 1 in the text.">&#x21A9;&#xFE0E;</a></p>
</li>
</ol>
</div>

[1]: #fn1-dcm-trademark

[dcm1]: http://medical.nema.org/dicom/ "DICOM Homepage"
[2]: http://www.dclunie.com/dicom-status/status.html "DICOM Standard Status"
[3]: http://nokogiri.org/ "Nokogiri"
[4]: http://rubini.us/ "Rubinius"
[5]: https://rubygems.org/gems/refine "Refine gem at RubyGems.org"
[6]: https://rubygems.org/gems/backports "Backports gem at RubyGems.org"
[7]: http://rubyinstaller.org/ "The easy way to install Ruby on Windows"
[8]: https://github.com/oneclick/rubyinstaller "RubyInstaller for Windows"
[9]: https://rubygems.org/
[10]: http://www.dicomstandard.org/
[11]: http://www.dicomstandard.org/current/
[12]: https://rubygems.org/gems/dcm_dict
