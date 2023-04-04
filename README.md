# CVSystem
This repository explain the calibration and operation process of the CV System with the Fisheye camera and Laser emitter \
If these files were useful, consider citation: \
`I. Kholodilin, Y. Li and Q. Wang, "Omnidirectional Vision System With Laser Illumination in a Flexible Configuration and Its Calibration by One Single Snapshot," in IEEE Transactions on Instrumentation and Measurement, vol. 69, no. 11, pp. 9105-9118, Nov. 2020, doi: 10.1109/TIM.2020.2998598.`

## How to open this project with Unity
The simulation environment was built with Unity 2020.3.15f2 (Game screen resolution 1280x720), for importing project to another Unity version consider [this import asset](https://github.com/kholodilinivan/CVSystem/blob/main/sv_syst_unityasset.unitypackage) 

In order to make the laser work you need to change setting of the Unity project in the following way: File -> Build Settings -> Player Settings -> Player -> Other Settings -> Rendering -> Auto Graphics API for Windows (disable it) -> add OpenGLCore and move it up 

See videos below how to import project and change settings: \
Video explanations in English - https://youtu.be/8Lbmiy_5Bqg \
Видео пояснения на русском - https://youtu.be/cOV2bShOkYM 

## Project Motivation and Main Theory
Text explanations in English - [Omnidirectional Vision System.pdf](https://github.com/kholodilinivan/CVSystem/files/10878212/Omnidirectional.Vision.System.pdf) \
Video explanations in English - https://youtu.be/eyiFRb6uCYg \
Презентация на русском - [Всенаправленная система зрения.pdf](https://github.com/kholodilinivan/CVSystem/files/10905479/default.pdf) \
Видео пояснения на русском - https://youtu.be/xRcYKhm8VO0 

## Project Tutorials
* **How To Use** \
Unity Project: CV_Project_Unity/Assets/Scenes/CVSystem \
Text explanations in English - [How To Use.pdf](https://github.com/kholodilinivan/CVSystem/files/10792495/How.To.Use.pdf) \
Video explanations in English - https://youtu.be/8Lbmiy_5Bqg \
Презентация на русском - [Как работать с симулятором.pdf](https://github.com/kholodilinivan/CVSystem/files/10905891/default.pdf) \
Видео пояснения на русском - https://youtu.be/cOV2bShOkYM \
![image](https://user-images.githubusercontent.com/34764174/220333826-f79338d8-5386-4b8f-9197-10d2af79f899.png)

* **Intrinsic Calibration** \
Unity Project: CV_Project_Unity/Assets/Scenes/CVSystem \
Matlab Project: CV_Project_Matlab/0_Tutorial_Intrinsic_Calibration \
Text explanations in English - [Intrinsic Calibration.pdf](https://github.com/kholodilinivan/CVSystem/files/10792561/Intrinsic.Calibration.pdf) \
Video explanations in English - https://youtu.be/8Lbmiy_5Bqg \
Презентация на русском - [Внутренняя калибровка.pdf](https://github.com/kholodilinivan/CVSystem/files/10905895/default.pdf) \
Видео пояснения на русском - https://youtu.be/cOV2bShOkYM \
![image](https://user-images.githubusercontent.com/34764174/220334111-aa9a554b-f88e-4c76-a23e-1e94bbefe1f7.png)

* **Tutorial Calib Basic** \
Unity Project: CV_Project_Unity/Assets/Scenes/CVSystem \
Matlab Project: CV_Project_Matlab/1_Tutorial_Calib_Basic \
Text explanations in English - [Tutorial Calib Basic.pdf](https://github.com/kholodilinivan/CVSystem/files/10792566/Tutorial.Calib.Basic.pdf) \
Video explanations in English - https://youtu.be/8Lbmiy_5Bqg \
Презентация на русском - [Проверка результатов калибровки.pdf](https://github.com/kholodilinivan/CVSystem/files/10905896/default.pdf) \
Видео пояснения на русском - https://youtu.be/cOV2bShOkYM \
![image](https://user-images.githubusercontent.com/34764174/220335229-0731a7aa-17e8-4c1e-8a16-901374a0ac53.png)
![image](https://user-images.githubusercontent.com/34764174/220335244-ba63f8f5-dcd6-43b3-8822-d94efde74ed5.png)

* **Tutorial Basic** \
Unity Project: CV_Project_Unity/Assets/Scenes/CVSystem \
Matlab Project: CV_Project_Matlab/2_Tutorial_Basic \
Text explanations in English - [Tutorial Basic.pdf](https://github.com/kholodilinivan/CVSystem/files/10792568/Tutorial.Basic.pdf) \
Video explanations in English - https://youtu.be/8Lbmiy_5Bqg \
Презентация на русском - [Одиночная карта.pdf](https://github.com/kholodilinivan/CVSystem/files/10905900/default.pdf) \
Видео пояснения на русском - https://youtu.be/cOV2bShOkYM \
`if have error below, watch in video tutorial on 52:00 how to fix 
Processing image TestImages/image.jpg...Error using fscanf 
Invalid file identifier. Use fopen to generate a valid file identifier. 
Error in get_checkerboard_cornersUrban (line 102) 
cornerInfo = fscanf(fid, '%g %g', [1 2]); 
Error in CalibBasic (line 9) 
get_checkerboard_cornersUrban(i+1,use_corner_find,calib_data);`\
![image](https://user-images.githubusercontent.com/34764174/220335798-6d181b17-ca8e-4d5d-9520-c0052e36dbc0.png)

* **Tutorial Intermediate** \
Unity Project: CV_Project_Unity/Assets/Scenes/CVSystem \
Matlab Project: CV_Project_Matlab/3_Tutorial_Intermediate \
Text explanations in English - [Tutorial Intermediate.pdf](https://github.com/kholodilinivan/CVSystem/files/10792569/Tutorial.Intermediate.pdf) \
Video explanations in English - https://youtu.be/8Lbmiy_5Bqg \
Презентация на русском - [Глобальная карта.pdf](https://github.com/kholodilinivan/CVSystem/files/10905902/default.pdf) \
Видео пояснения на русском - https://youtu.be/cOV2bShOkYM \
![image](https://user-images.githubusercontent.com/34764174/220335983-e605ba10-3530-48ef-a749-2dea2ff76d66.png)

* **Tutorial Advance Chess** \
Unity Project: CV_Project_Unity/Assets/Scenes/CVSystem \
Matlab Project: CV_Project_Matlab/4_Tutorial_Advance_Chess \
Text explanations in English - [Tutorial Advance Chess.pdf](https://github.com/kholodilinivan/CVSystem/files/10792573/Tutorial.Advance.Chess.pdf) \
Video explanations in English - https://youtu.be/8Lbmiy_5Bqg \
Презентация на русском - [Внешняя калибровка.pdf](https://github.com/kholodilinivan/CVSystem/files/10905905/default.pdf) \
Видео пояснения на русском - https://youtu.be/cOV2bShOkYM \
`if have error below, watch in video tutorial on 52:00 how to fix 
Processing image TestImages/image.jpg...Error using fscanf 
Invalid file identifier. Use fopen to generate a valid file identifier. 
Error in get_checkerboard_cornersUrban (line 102) 
cornerInfo = fscanf(fid, '%g %g', [1 2]); 
Error in CalibBasic (line 9) 
get_checkerboard_cornersUrban(i+1,use_corner_find,calib_data);`\
![image](https://user-images.githubusercontent.com/34764174/220336797-b76674b7-3cc8-4517-a1b8-613691644272.png)
