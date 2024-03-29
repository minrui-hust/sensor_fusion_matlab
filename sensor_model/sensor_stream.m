function [stream,imu_sample,imu_true,gps_sample,gps_true,lidar_sample,lidar_true] = sensor_stream(gt, sensor_config)
  %% generate sensor data stream

  % imu
  [imu_sample,imu_true] = sensor_imu(gt, sensor_config.imu);

  % gps
  [gps_sample, gps_true] = sensor_gps(gt, sensor_config.gps);

  % lidar
  [lidar_sample, lidar_true] = sensor_lidar(gt, sensor_config.lidar);

  % generate the stream according to timestamp
  imu_id = 1;
  gps_id = 1;
  lidar_id = 1;
  stream_id = 1;
  while (imu_id<=imu_sample.Length) || (gps_id<=gps_sample.Length) || (lidar_id<=lidar_sample.Length)
    if imu_id <= imu_sample.Length
      imu_time = imu_sample.Time(imu_id);
      imu_arrive_time = imu_time;
    else
      imu_time = +inf;
      imu_arrive_time = +inf;
    end

    if gps_id <= gps_sample.Length
      gps_time = gps_sample.Time(gps_id);
      gps_arrive_time = gps_time + sensor_config.gps.delay;
    else
      gps_time = +inf;
      gps_arrive_time = +inf;
    end

    if lidar_id <= lidar_sample.Length
      lidar_time = lidar_sample.Time(lidar_id);
      lidar_arrive_time = lidar_time + sensor_config.lidar.delay;
    else
      lidar_time = +inf;
      lidar_arrive_time = +inf;
    end

    if(imu_arrive_time<=gps_arrive_time && imu_arrive_time<=lidar_arrive_time)
      imu_st.type = 'imu';
      imu_st.time = imu_time;
      imu_st.data = imu_sample.Data(imu_id,:)';
      stream{stream_id} = imu_st;
      imu_id = imu_id+1;
    elseif(gps_arrive_time<=imu_arrive_time && gps_arrive_time<=lidar_arrive_time)
      gps_st.type = 'gps';
      gps_st.time = gps_time;
      gps_st.data = gps_sample.Data(gps_id,:)';
      stream{stream_id} = gps_st;
      gps_id = gps_id+1;
    elseif(lidar_arrive_time<=imu_arrive_time && lidar_arrive_time<=gps_arrive_time)
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
