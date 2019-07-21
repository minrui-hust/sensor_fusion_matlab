function q = s3_exp(v)
  % q:4xN, v:3xN
  theta = sqrt(diag(v'*v))';

  unit = (v+eps)./repmat(theta+eps, 3, 1);

  q = [cos(theta/2); unit .* repmat(sin(theta/2), 3, 1)];
end
