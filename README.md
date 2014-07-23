# What's *DcmDict*
**DcmDict** is a Ruby gem (*dcm\_dict*) to handle in a simple way the Data defined within the [DICOM(r)][1] Standard such as DICOM Data Elements or DICOM Unique Identifiers.

## Features
### Data Element
Any Data Element features can be accessed from a string, array or symbol.

For this object you can access to tag, name, keyword, VR and VM for any single Data Element

The main methods supported are:

|Method  | Note| Type|
|:------|:------------:|:---:|
|**tag**     | tag as Array| Array of two Fixnum|
|**name**    | name of tag| String|
|**keyword** | keyword| String|
|**vr**      | Value Representation| Array of Symbol|
|**vm**      | Value Multeplicity| Array of Symbol|
|**tag_ps**  | tag as string (as standard doc)| String|
|**tag_ary** | tag as Array|Array of two Fixnum|
|**tag_sym** | tag as Symbol|Symbol|
|**tag_ndm** | tag as in Native DICOM Model|String
|**tag_str** | tag as string (symilar to tag_ps)|String|
||useful for 'multi tag' attribute||

Consider the case of the tag (0010,1005) (*Patient's Birth Name*)

#### String Key:

As example the code:

```
require 'dcm_dict'
using DcmDict::Refine::StringRefine
puts '(0010,1005)'.tag_ps.inspect
puts '(0010,1005)'.name.inspect
puts '(0010,1005)'.keyword.inspect
puts '(0010,1005)'.vr.inspect
puts '(0010,1005)'.vm.inspect
puts '(0010,1005)'.tag.inspect
puts '(0010,1005)'.tag_ary.inspect
puts '(0010,1005)'.tag_sym.inspect
puts '(0010,1005)'.tag_ndm.inspect
puts '(0010,1005)'.tag_str.inspect
puts '(0010,1005)'.note.inspect
```

will produce


```
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
```

As string key you may use the standard tag format *'(0010,1005)'* as above but also the name *'Patient's Birth Name'*, the keyword *'PatientBirthName'* or the Native DICOm Format tag *'00101005'*


## Install

    $ gem install dcm_dict

## Usage
TBD

## Contributing
TBD

## License
Copyright (C) 2014  Enrico Rivarola. See the `LICENSE` file for license details.

## Source
Main source code repository on github at [henrythebuilder/dcm_dict](https://github.com/henrythebuilder/dcm_dict)


[1]: http://medical.nema.org/dicom/        "DICOM Homepage"
