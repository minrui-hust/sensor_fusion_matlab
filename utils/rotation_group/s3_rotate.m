function vout = s3_rotate(q, vin)
  % quat:4xN, r_in:3xN, r_out:3xN
  tmp = s3_multi(s3_multi(q, [zeros(1,size(vin,2));vin]), s3_conj(q));
  vout = tmp(2:4,:);
end
