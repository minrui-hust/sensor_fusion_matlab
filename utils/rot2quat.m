function quat = rot2quat(rot)
%ROT2QUAT Summary of this function goes here
%   Detailed explanation goes here

 phi = sqrt(rot*rot');

 tan_half_phi = tan(phi/2);

 rod = rot .* (tan_half_phi ./ phi);

 quat = rod2quat(rod);
end
