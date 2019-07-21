function [x_updated, P_updated] = add_gps_meas(x, P, z, R)

  %p_pred = x(1:3);

  %p_meas = z(1:3);

  %Hp = zeros(3,15);
  %Hp(1:3,1:3 ) = eye(3,3);

  %Rp = R(1:3,1:3);

  %[x, P] = meas_update(x, P, p_meas, p_pred, Hp, Rp);



  v_pred = x(8:10);

  v_meas = z(4:6);

  Hv = zeros(3,15);
  Hv(1:3,7:9) = eye(3,3);

  Rv = R(4:6,4:6);

  [x_updated, P_updated] = meas_update(x, P, v_meas, v_pred, Hv, Rv);
end
