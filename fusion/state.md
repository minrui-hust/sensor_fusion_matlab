# State define

待估计状态:$x = \begin{bmatrix}p\\q\\v\\b^{\omega}\\b^a\end{bmatrix}$
- $p$: 位置  
- $q$: 姿态四元数
- $v$: global坐标系下速度
- $b^w$: 陀螺仪零偏
- $b^a$: 加速度计零偏

输入： $u=\begin{bmatrix} \omega \\ a \end{bmatrix}$
- $\omega$: local frame角速度
- $a$: local frame 加速度

# State transition
## 连续模型
$$
\begin{bmatrix}
\dot{p} \\
\dot{q} \\
\dot{v} \\
\dot{b}^{\omega} \\
\dot{b}^a \\
\end{bmatrix}
=
\begin{bmatrix}
v \\
q \otimes \omega^{\land} \\
q \circ a \\
\eta^{\omega} \\
\eta^{\omega}
\end{bmatrix}
=
\begin{bmatrix}
q \circ v \\
q \otimes (\overline{\omega} - b^{\omega} - n^{\omega})^{\land} \\
q \circ (\overline{a} - b^a - n^{\omega}) - g \\
\eta^{\omega} \\
\eta^{\omega}
\end{bmatrix}
$$
其中$\otimes$表示四元数相乘，$\circ$表示四元数对向量的旋转, 其他变量参看 sensor_model/sensor_model.md

## 离散模型
$$
\begin{bmatrix}
p_k \\
q_k \\
v_k \\
b^{\omega}_k \\
b^a_k \\
\end{bmatrix}
=
\begin{bmatrix}
p_{k-1} + v_{k-1}\Delta t_k \\
q_{k-1} \oplus ( (\overline{\omega}_k - b^{\omega}_{k-1} - n^{\omega}_k )\Delta t_k ) \\
v_{k-1} + (q_{k-1} \circ (\overline{a}_{k} - b^a_{k-1} - n^a_k) - g) \Delta t_{k}\\
b^{\omega}_{k-1} + \eta^{\omega}_k \Delta t_k \\
b^{a}_{k-1} + \eta^{a}_k \Delta t_k \\
\end{bmatrix}
$$
其中$\oplus$表示李群S(3)上的加法，并且有:
$$
n^{\omega}_k = \frac{1}{\sqrt{\Delta t_k}}n^{\omega} \\
n^{a}_k = \frac{1}{\sqrt{\Delta t_k}}n^a \\
\eta^{\omega}_k = \frac{1}{\sqrt{\Delta t_k}} \eta^{\omega} \\
\eta^{a}_k = \frac{1}{\sqrt{\Delta t_k}} \eta^{a}
$$

雅各比：


# Measurment
