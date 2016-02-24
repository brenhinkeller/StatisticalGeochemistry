function out = mgnumber(MgO,Fe2O3)
% Calculates the Magnesium number of a sample with given MgO and Fe2O3(t)
% contents.

Mg=MgO/(24.305+15.999);
Fe=Fe2O3/(55.845+15.999);
out=Mg./(Mg+Fe);
end