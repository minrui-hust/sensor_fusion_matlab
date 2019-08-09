function [x_updated, P_updated] = meas_update(x, P, res, H, R, state_dem, cov_dem, win)
  % Kalman Gain
  K = P*H'*inv(H*P*H' + R);

  x_delta = K*res;

  for i=1:win
    x_updated(1+(i-1)*state_dem :3 +(i-1)*state_dem, 1) = x(1+(i-1)*state_dem:3+(i-1)*state_dem) + x_delta(1+(i-1)*cov_dem:3+(i-1)*cov_dem); 
    x_updated(4+(i-1)*state_dem :7 +(i-1)*state_dem, 1) = s3_multi(x(4+(i-1)*state_dem:7+(i-1)*state_dem), s3_exp(x_delta(4+(i-1)*cov_dem:6+(i-1)*cov_dem))); 
    x_updated(8+(i-1)*state_dem :22+(i-1)*state_dem, 1) = x(8+(i-1)*state_dem:22+(i-1)*state_dem) + x_delta(7+(i-1)*cov_dem:21+(i-1)*cov_dem); 
  end

  P_updated = (eye(size(P,1),size(P,2))-K*H)*P;
end
