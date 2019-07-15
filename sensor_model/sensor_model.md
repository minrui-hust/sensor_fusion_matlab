# 传感器模型

## IMU
### IMU测量模型
陀螺仪:
$$
\overline{\omega} = \omega + b^{\omega} + n^{\omega} \\
    \dot{b}^{\omega} = \eta^{\omega} \\
    n^{\omega} \backsim N(0, \Sigma^{\omega,n}) \\
    \eta^{\omega} \backsim N(0, \Sigma^{\omega, \eta})
    
$$
其中:
- $\overline{\omega}$:角速度测量值
- $\omega$:角速度真值
- $b^{\omega}$:角速度测量偏置
- $\dot{b}^{\omega}$:角速度测量偏置随时间的导数，是一个随机变量$\eta^{\omega}$
- $n^{\omega}$:角速度测量噪声

加速度计:
$$
\overline{a} = R^T(a^g + g) + b^a + n^a \\
    \dot{b}^a = \eta^a \\
    n^a \backsim N(0, \Sigma^{a,n}) \\
    \eta^a \backsim N(0, \Sigma^{a,\eta})
$$
其中:
- $\overline{a}$:local 加速度测量值
- $a^g$:global 加速度真值
- $g$:global 重力加速度
- $R$:local 相对于global的姿态(旋转矩阵)
- $b^a$:加速度测量偏置
- $\dot{b}^a$:加速度测量偏置随时间的导数，是一个随机变量$\eta^a$
- $n^a$:加速度测量噪声


### IMU离散模型
离散时间序列$t_0,t_1,t_2,\cdots,t_N$,他们之间的间隔:$\Delta t_1, \Delta t2,\cdots,\Delta t_N$,
现在$t_k$时刻的测量值，记作$\overline{\omega}_k, \overline{a}_k$, 有：
陀螺仪:
$$
\overline{\omega}_k = \omega_k + b^{\omega}_k + n^{\omega}_k \\
b^w_k = b^w_{k-1} + \eta^{\omega}_k \\
  \eta^{\omega}_k = \sqrt{\Delta t_k} \cdot \eta^{\omega}
$$
式中$\eta^w_k$为离散的偏置增量,为一个随机变量，它与偏置的导数$\eta^w$的关系相差$\sqrt{\Delta t_k}$, 
参看['On-Manifold Preintegration for Real-TimeVisual-Inertial Odometry'. Page 6, last paragraph](https://1drv.ms/b/s!AhdeoYkNLfTBkS29FXZuWap-oOPg)

### IMU模型参数
$$
\Sigma^{\omega,n} = \begin{bmatrix} \sigma_{\omega,n}^2 &0&0 \\ 0& \sigma_{\omega,n}^2 &0 \\ 0&0& \sigma_{\omega,n}^2 \end{bmatrix}
$$

$$
\Sigma^{\omega,\eta} = \begin{bmatrix} \sigma_{\omega,\eta}^2 &0&0 \\ 0& \sigma_{\omega,\eta}^2 &0 \\ 0&0& \sigma_{\omega,\eta}^2 \end{bmatrix}
$$

$$
\Sigma^{a,n} = \begin{bmatrix} \sigma_{a,n}^2 &0&0 \\ 0& \sigma_{a,n}^2 &0 \\ 0&0& \sigma_{a,n}^2 \end{bmatrix}
$$

$$
\Sigma^{a,\eta} = \begin{bmatrix} \sigma_{a,\eta}^2 &0&0 \\ 0& \sigma_{a,\eta}^2 &0 \\ 0&0& \sigma_{a,\eta}^2 \end{bmatrix}
$$

$\sigma_{\omega,n}$    : imu_config.gyro_noise_std    
$\sigma_{\omega,\eta}$ : imu_config.gyro_bias_drift_std  
$\sigma_{a,n}$         : imu_config.acc_noise_std       
$\sigma_{a,\eta}$      : imu_config.acc_bias_drift_std  

