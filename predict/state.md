# State define

待估计状态:$x = \begin{bmatrix}p\\q\\v\\ \omega \\ a \\b^{\omega}\\b^a\end{bmatrix}$
- $p$: 位置  
- $q$: 姿态四元数
- $v$: global坐标系下速度
- $\omega$: angular velocity in body frame
- $a$: linear accelaration in global frame
- $b^w$: 陀螺仪零偏
- $b^a$: 加速度计零偏

输入： $u=\begin{bmatrix} \overline{\omega} \\ \overline{a} \end{bmatrix}$
- $\overline{\omega}$: local frame角速度
- $\overline{a}$: local frame 加速度(gravity included)

# State transition
## 连续模型
$$
\begin{bmatrix}
\dot{p} \\
\dot{q} \\
\dot{v} \\
\dot{\omega} \\
\dot{a} \\
\dot{b}^{\omega} \\
\dot{b}^a \\
\end{bmatrix}
=
\begin{bmatrix}
v \\
q \otimes \omega^{\land} \\
a \\
null \\
null \\
\eta^{\omega} \\
\eta^{\omega}
\end{bmatrix}
$$

$$
\begin{bmatrix}
w\\
a\\
\end{bmatrix}
=
\begin{bmatrix}
\overline{w} - b^w - n^w \\
q \circ (\overline{a} - b^a - n^a) - g
\end{bmatrix}
$$
其中$\otimes$表示四元数相乘，$\circ$表示四元数对向量的旋转, 其他变量参看 sensor_model/sensor_model.md

## 离散模型
$$
x_k =
\begin{bmatrix}
p_k \\
q_k \\
v_k \\
w_k\\
a_k\\
b^w_k \\
b^a_k \\
\end{bmatrix}
=
\begin{bmatrix}
p_{k-1} + v_{k-1}\Delta t_k \\
q_{k-1} \oplus \left( \frac{w_{k-1}+w_k}{2} \Delta t_k \right) \\
v_{k-1} + a_{k-1} \Delta t_{k}\\
\overline{w}_k - b^w_{k} - n^w_k \\
q_{k} \circ (\overline{a} - b^a_{k} - n^a_k) - g  \\
b^{\omega}_{k-1} + \eta^{\omega}_k \Delta t_k \\
b^{a}_{k-1} + \eta^{a}_k \Delta t_k \\
\end{bmatrix}
=
\begin{bmatrix}
p_{k-1} + v_{k-1}\Delta t_k \\
q_{k-1} \oplus ( \frac{w_{k-1} + \overline{w}_k - b^w_{k-1} - \eta^w_{k} \Delta t_k - n^w_k}{2} \Delta t_k ) \\
v_{k-1} + a_{k-1} \Delta t_{k}\\
\overline{w}_k - b^w_{k-1} - \eta^w_{k} \Delta t_k - n^w_k \\
(q_{k-1} \oplus (\frac{w_{k-1} + \overline{w}_k - b^w_{k-1} - \eta^w_{k} \Delta t_k - n^w_k}{2} \Delta t_k)) \circ (\overline{a}_k - b^a_{k-1} - \eta^a_{k} \Delta t_k - n^a_k) - g  \\
b^{\omega}_{k-1} + \eta^{\omega}_k \Delta t_k \\
b^{a}_{k-1} + \eta^{a}_k \Delta t_k \\
\end{bmatrix}
\\
\\
Q_k = 
\begin{bmatrix}
n^w_k\\
n^a_k\\
\eta^w_k\\
\eta^a_k\\
\end{bmatrix}
$$
其中$\oplus$表示李群S(3)上的加法，并且有:
$$
n^{\omega}_k = n^{\omega} \\
n^{a}_k = n^a \\
\eta^{\omega}_k = \frac{1}{\sqrt{\Delta t_k}} \eta^{\omega} \\
\eta^{a}_k = \frac{1}{\sqrt{\Delta t_k}} \eta^{a}
$$

状态雅各比$J^{x_k}_{x_{k-1}}$：
$$
\begin{bmatrix} 
J^{p_k}_{p_{k-1}} & 0 & J^{p_k}_{v_{k-1}} & 0 & 0 & 0 & 0 \\
0 & J^{q_k}_{q_{k-1}} & 0 & J^{q_k}_{w_{k-1}} & 0 & J^{q_k}_{b^w_{k-1}} & 0 \\
0 & 0 & J^{v_k}_{v_{k-1}} & 0 & J^{v_k}_{a_{k-1}} & 0 & 0\\
0 & 0 & 0 & 0 & 0 & J^{w_k}_{b^w_{k-1}} & 0\\
0 & J^{a_k}_{q_{k-1}} & 0 & J^{a_k}_{w_{k-1}} & 0 & J^{a_k}_{b^w_{k-1}} & J^{a_k}_{b^a_{k-1}}\\
0 & 0 & 0 & 0 & 0 & J^{b^w_k}_{b^w_{k-1}} & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & J^{b^a_k}_{b^a_{k-1}} \\
\end{bmatrix}
=\\
\begin{bmatrix} 
I & 0 & \Delta t \cdot I & 0 & 0 & 0 & 0 \\
0 & R(\frac{w_{k-1}+w_k}{2} \Delta t)^T & 0 & \frac{1}{2}J_r(\frac{w_{k-1}+w_k}{2}\Delta t) \Delta t & 0 & -\frac{1}{2}J_r(\frac{w_{k-1}+w_k}{2}\Delta t) \Delta t & 0 \\
0 & 0 & I & 0 & \Delta t \cdot I & 0 & 0 \\
0 & 0 & 0 & 0 & 0 & -I & 0 \\
0 & -R(q_k) \cdot [\overline{a}_k - b^a_{k-1}]_{\times} \cdot J^{q_k}_{q_{k-1}} & 0 & -R(q_k) \cdot [\overline{a}_k - b^a_{k-1}]_{\times} \cdot J^{q_k}_{w_{k-1}} & 0 & -R(q_k)\cdot [\overline{a}_k - b^a_{k-1}]_\times \cdot J^{q_k}_{b^w_{k-1}} & -R(q_k) \\
0 & 0 & 0 & 0 & 0 & I & 0 \\
0 & 0 & 0 & 0 & 0 & 0 & I \\
\end{bmatrix}
$$

噪声雅各比$J^{x_k}_{Q_k}$：
$$
\begin{bmatrix} 
0&0&0&0\\
J^{q_k}_{n^w_k}&0&J^{q_k}_{\eta^w_k}&0\\
0&0&0&0\\
J^{w_k}_{n^w_k} &0& J^{w_k}_{\eta^w_k}  &0\\
J^{a_k}_{n^w_k}&J^{a_k}_{n^a_k}&J^{a_k}_{\eta^w_k}&J^{a_k}_{\eta^a_k}\\
0&0&J^{b^w_k}_{\eta^w_k}&0\\
0&0&0&J^{b^a_k}_{\eta^a_k}\\
\end{bmatrix}
= \\
\begin{bmatrix}
0&0&0&0\\
-\frac{1}{2}J_r(\frac{w_{k-1}+w_k}{2}\Delta t) \Delta t&0&-\frac{1}{2}J_r(\frac{w_{k-1}+w_k}{2}\Delta t) \Delta t^2&0\\
0&0&0&0\\
-I&0&-\Delta t \cdot I&0\\
-R(q_k)\cdot [\overline{a}_k - b^a_{k-1}]_\times \cdot J^{q_k}_{b^w_{k-1}}&-R(q_k)&-\Delta t \cdot R(q_k)\cdot [\overline{a}_k - b^a_{k-1}]_\times \cdot J^{q_k}_{b^w_{k-1}}&-\Delta t \cdot R(q_k)\\
0&0&\Delta t \cdot I &0\\
0&0&0&\Delta t \cdot I\\
\end{bmatrix}
$$
上式中$R(*)$表示$*$对应的旋转矩阵，如果$*$是四元数，那么就是四元数对应的旋转矩阵，如果$*$是旋转向量, 就是旋转向量对应的旋转矩阵.


