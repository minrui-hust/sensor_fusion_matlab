function q = so3Ts3(dcm)
  q = quatconj(dcm2quat(dcm))';
end
