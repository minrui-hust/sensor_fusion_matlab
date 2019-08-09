  % Kalman Gain
  
  P = [...
      1    0.5;...
      0.5  0.25;...
      ];
  
  H = [1 0];
  
  R = 0.5;
  
  K = P*H'*inv(H*P*H' + R);

  K*H*P

  P_updated = (eye(2,2)-K*H)*P