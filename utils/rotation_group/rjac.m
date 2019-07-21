function j = rjac(v)
  % input should be rotate vector
  theta = norm(v);

  j = eye(3,3) - ...
      (1-cos(theta+eps))/(theta+eps)^2 * so3_hat(v) + ...
      ((theta+eps) - sin(theta+eps))/(theta+eps)^3 * so3_hat(v) * so3_hat(v);
end
