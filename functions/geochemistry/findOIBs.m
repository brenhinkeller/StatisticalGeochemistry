function in=findOIBs(in)
% Finds samples corresponding to known ocean island hot-spots

oibs=(in.Latitude >18&in.Latitude<30&in.Longitude<-154&in.Longitude>-179.5)|... % Hawaii
    (in.Latitude >36&in.Latitude<41&in.Longitude<-22&in.Longitude>-29)|... % Azores
    (in.Latitude >-69&in.Latitude<-65&in.Longitude<170&in.Longitude>160)|... % Balleny
    (in.Latitude >53&in.Latitude<57&in.Longitude<-135&in.Longitude>-147)|... % Bowie
    (in.Latitude >27&in.Latitude<29&in.Longitude<-15&in.Longitude>-18.5)|... % Canary
    (in.Latitude >14&in.Latitude<18&in.Longitude<-22&in.Longitude>-26)|... % Cape Verde
    (in.Latitude >46&in.Latitude<50&in.Longitude<-130&in.Longitude>-135)|... % Cobb
    (in.Latitude >-44&in.Latitude<-41&in.Longitude<3&in.Longitude>-5)|... % Discovery
    (in.Latitude >-30&in.Latitude<-20&in.Longitude<-80&in.Longitude>-110)|... % Easter
    (in.Latitude >-3&in.Latitude<1&in.Longitude<-82&in.Longitude>-92)|... % Galapagos
    (in.Latitude >62&in.Latitude<67&in.Longitude<-13&in.Longitude>-26)|... % Iceland
    (in.Latitude >68.5&in.Latitude<71.5&in.Longitude<-7&in.Longitude>-10)|... % Jan Mayen
    (in.Latitude >-34.3&in.Latitude<-33&in.Longitude<-76&in.Longitude>-82)|... % Juan Fernandez
    (in.Latitude >-63&in.Latitude<-45&in.Longitude<85&in.Longitude>63)|... % Kerguelen
    (in.Latitude >-50&in.Latitude<-25&in.Longitude<-145&in.Longitude>-175)|... % Louisville
    (in.Latitude >-25&in.Latitude<-20&in.Longitude<-125&in.Longitude>-140)|... % Pitcairn
    (in.Latitude >-22&in.Latitude<-3&in.Longitude<63&in.Longitude>55)|... % Reunion
    (in.Latitude >-6&in.Latitude<-5.5&in.Longitude<-15.75&in.Longitude>-16.25)|... % Saint Helena
    (in.Latitude >0&in.Latitude<4&in.Longitude<9&in.Longitude>6)|... % Sao Tome
    (in.Latitude >-40&in.Latitude<-38&in.Longitude<-9&in.Longitude>-13)|... % Tristan & Gough
    (in.Latitude >-35&in.Latitude<-19&in.Longitude<11&in.Longitude>-5);

in.oibs=oibs;