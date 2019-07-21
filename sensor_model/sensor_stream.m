function [stream,imu_sample,imu_true,gps_sample,gps_true,lidar_sample,lidar_true] = sensor_stream(gt, sensor_config)
  %% generate sensor data stream

  % imu
  imu_gt = timeseries([gt.wx gt.wy gt.wz gt.ax gt.ay gt.az gt.qw gt.qx gt.qy gt.qz], gt.time);
  [imu_sample,imu_true] = sensor_imu(imu_gt, sensor_config.imu);

  % gps
  gps_gt = timeseries([gt.px gt.py gt.pz gt.vx gt.vy gt.vz], gt.time);
  [gps_sample, gps_true] = sensor_gps(gps_gt, sensor_config.gps);

  % lidar (6dof)
  lidar_gt = timeseries([gt.px gt.py gt.pz gt.qw gt.qx gt.qy gt.qz], gt.time);
  [lidar_sample, lidar_true] = sensor_lidar(lidar_gt, sensor_config.lidar);

  % generate the stream according to timestamp
  imu_id = 1;
  gps_id = 1;
  lidar_id = 1;
  stream_id = 1;
  while (imu_id<=imu_sample.Length) || (gps_id<=gps_sample.Length) || (lidar_id<=lidar_sample.Length)
    if imu_id <= imu_sample.Length
      imu_time = imu_sample.Time(imu_id);
    else
      imu_time = +inf;
    end

    if gps_id <= gps_sample.Length
      gps_time = gps_sample.Time(gps_id);
    else
      gps_time = +inf;
    end

    if lidar_id <= lidar_sample.Length
      lidar_time = lidar_sample.Time(lidar_id);
    else
      lidar_time = +inf;
    end

    if(imu_time<=gps_time && imu_time<=lidar_time)
      imu_st.type = 'imu';
      imu_st.time = imu_time;
      imu_st.data = imu_sample.Data(imu_id,:)';
      stream{stream_id} = imu_st;
      imu_id = imu_id+1;
    elseif(gps_time<=imu_time && gps_time<=lidar_time)
      gps_st.type = 'gps';
      gps_st.time = gps_time;
      gps_st.data = gps_sample.Data(gps_id,:)';
      stream{stream_id} = gps_st;
      gps_id = gps_id+1;
    elseif(lidar_time<=imu_time && lidar_time<=gps_time)
      lidar_st.type = 'lidar';
      lidar_st.time = lidar_time;
      lidar_st.data = lidar_sample.Data(lidar_id,:)';
      stream{stream_id} = lidar_st;
      lidar_id = lidar_id+1;
    else
      error('Data empty');
    end

    stream_id=stream_id+1;
  end
end
