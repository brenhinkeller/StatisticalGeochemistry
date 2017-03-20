
radii = importdataset('radii.tsv','\t');
radii.Notes = radii.Key{end};
radii.Key{end} = [];

radius.elements = unique(radii.Element);
for i=1:length(radius.elements)
    e = radius.elements{i};
    etest = strcmp(radii.Element,e);

    radius.(e) = struct;
    radius.(e).Ionic_Radius = radii.Ionic_Radius(etest);
    radius.(e).Crystal_Radius = radii.Crystal_Radius(etest);
    radius.(e).Charge = radii.Charge(etest);
    radius.(e).Coordination = radii.Coordination(etest);
    radius.(e).Spin = radii.Spin(etest);

    charges = unique(radii.Charge(etest));
    for j = charges'
        if j>0
            c = ['p' num2str(abs(j))];
        else
            c = ['m' num2str(abs(j))];
        end
        ectest = etest & radii.Charge==j;
        
        radius.(e).(c).Ionic_Radius = radii.Ionic_Radius(ectest);
        radius.(e).(c).Crystal_Radius = radii.Crystal_Radius(ectest);
        radius.(e).(c).Coordination = radii.Coordination(ectest);
        radius.(e).(c).Spin = radii.Spin(ectest);
        
        coordinations = unique(radii.Coordination(ectest));
        for k = coordinations'
            ecctest = ectest&strcmp(k{:},radii.Coordination);
            radius.(e).(c).(k{:}).Ionic_Radius = radii.Ionic_Radius(ecctest);
            radius.(e).(c).(k{:}).Crystal_Radius = radii.Crystal_Radius(ecctest);
            radius.(e).(c).(k{:}).Spin = radii.Spin(ecctest);
        end
    end
end

radius.Notes = radii.Notes;

save -v7.3 radius radius
save -v7.3 radii radii