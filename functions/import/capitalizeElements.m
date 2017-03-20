function elements = capitalizeElements(elements)

elements = regexprep(lower(elements),'((^|[^a-zA-Z])[a-z])','${upper($1)}');
elements = regexprep(elements,'mno','MnO','ignorecase');
elements = regexprep(elements,'cao','CaO','ignorecase');
elements = regexprep(elements,'mgo','MgO','ignorecase');
elements = regexprep(elements,'feo','FeO','ignorecase');
elements = regexprep(elements,'nio','NiO','ignorecase');
elements = regexprep(elements,'coo','CoO','ignorecase');
elements = regexprep(elements,'feot','FeOT','ignorecase');
elements = regexprep(elements,'sio2','SiO2','ignorecase');
elements = regexprep(elements,'tio2','TiO2','ignorecase');
elements = regexprep(elements,'caco3','CaCO3','ignorecase');
elements = regexprep(elements,'co2','CO2','ignorecase');
elements = regexprep(elements,'so2','SO2','ignorecase');
elements = regexprep(elements,'Min_Age','Age_Min');
elements = regexprep(elements,'Max_Age','Age_Max');
elements = regexprep(elements,'Indium','In');
elements = regexprep(elements,'Sample_Id','Sample_ID');
elements = regexprep(elements,'Cruise_Id','Cruise_ID');

