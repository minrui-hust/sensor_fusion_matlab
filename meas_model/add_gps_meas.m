function [x_updated, P_updated] = add_gps_meas(x, P, z, R)

  % construct the predict measurement
  p_pred = x(1:3);
  v_pred = x(8:10);
  z_pred = [p_pred;v_pred];

  % construct measurement matrix
  H = zeros(6,15);
  H(1:3,1:3 ) = eye(3,3);
  H(4:6,7:9) = eye(3,3);

  % construct the measurement noise cov
  N = eye(6,6);
  R = N*R*N';

  % measurement update
  [x_updated, P_updated] = meas_update(x, P, z, z_pred, H, R);
end
