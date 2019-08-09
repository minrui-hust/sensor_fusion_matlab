function v = s3_log(q)

  u = q(2:4,:);
  u_norm = sqrt(diag(u'*u))';
  
  v = 2*u*atan2(u_norm+eps, q(1,:))/(u_norm + eps);
end
