function r = so3_exp(v)
  theta = norm(v);
  unit = (v+eps) / (theta+eps);

  r = eye(3,3) +...
      sin(theta)* so3_hat(unit) + ...
      (1-cos(theta)) * so3_hat(unit) *so3_hat(unit);
end
