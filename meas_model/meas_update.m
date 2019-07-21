function [x_updated, P_updated] = meas_update(x, P, z, z_predict, H, R)
  % Kalman Gain
  K = P*H'*inv(H*P*H' + R);

  x_delta = K*(z - z_predict);
  x_updated(1:3 , 1) = x(1:3) + x_delta(1:3); 
  x_updated(4:7 , 1) = s3_multi(x(4:7), s3_exp(x_delta(4:6))); 
  x_updated(8:16, 1) = x(8:16) + x_delta(7:15); 

  P_updated = (eye(15,15)-K*H)*P;
end
