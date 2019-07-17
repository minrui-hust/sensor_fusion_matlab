function rot = quat2rot(quat)
%QUAT2ROT Summary of this function goes here
%   Detailed explanation goes here

 rod = quat2rod(quat);
 
 tan_half_phi = sqrt(rod*rod');
 
 phi = atan(tan_half_phi)*2;
 
 rot = rod .* (phi ./ tan_half_phi);
end

