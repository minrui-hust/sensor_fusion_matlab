function delta = s3_minus(q1, q2)
  delta = s3_log(s3_multi(s3_conj(q2), q1));
end
