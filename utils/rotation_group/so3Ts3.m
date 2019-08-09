function q = so3Ts3(dcm)
  q = quatconj(dcm2quat(dcm))';

  % this is ugly for dcm to quat may jump
  if(size(q,2)>1)
    last_q = q(:,1);
    s = 1;
    for i=2:size(q,2)
      curr_q = q(:,i);
      if norm(curr_q(2:4,1) - last_q(2:4,1)) > 0.5 && norm(curr_q(2:4,1)+last_q(2:4,1))<0.1
        s = -s;
      end
      q(:,i) = s*curr_q;
      last_q = curr_q;
    end
  end
end
