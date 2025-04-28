**1. 3개 모델 최종결과 비교**
![image](https://github.com/user-attachments/assets/b3c79462-af6d-4bb4-bef9-a911633a9cb6)
<br>
<br>

**2. 손실(loss) 측면 분석**
- VGG16-UNet:
  → 압도적으로 낮은 loss!
  → 학습/검증 손실 모두 0.2 이하로 매우 안정적.
- Encoder-Decoder:
  → UNet보다는 낮지만 여전히 손실이 높음.
- UNet:
  → train/val 모두 손실이 상대적으로 높음.
![image](https://github.com/user-attachments/assets/3ba62608-9d0b-4016-8761-2df340c4d50b)
<br>
<br>

**3. mean IoU(Intersection over Union) 분석**
- UNet:
  → mean IoU 0.93 으로 가장 높음 (예측 품질 최고)
- VGG16-UNet:
  → mean IoU 0.85 정도로 매우 우수하지만 UNet보다 약간 낮음.
- Encoder-Decoder:
  → mean IoU 0.65 로 비교적 낮음.
<br>
<br>

**4. 종합분석**
- VGG16-UNet
  → 손실이 가장 낮아 훈련 안정성, generalization 모두 가장 뛰어남
  → 다만 mean IoU가 UNet보다 살짝 낮음
  → 실용성과 훈련 효율성을 모두 잡은 모델
- UNet
  → mean IoU가 가장 높음 (0.93)
  → 예측 성능은 매우 뛰어남 (다만 손실이 조금 크고, overfitting 경향?)
- Encoder-Decoder
  → 3개 모델 중 가장 낮은 성능
  → 초보적인 구조라 복잡한 문제에는 한계
<br>
<br>

**5. 최종요약**

![image](https://github.com/user-attachments/assets/b51f6bf8-e769-4436-adde-3a3469226f2d)
- VGG16-UNet
  → 실용성과 안정성 측면에서 가장 추천
- UNet
  → 순수 segmentation 성능(IoU)만 보면 최고
<br>
<br>

**6. segmentation 결과 시각화**
- Test Dataset 내에 데이터들을 얼만큼 잘 맞추었는지 직접 확인결과, 3개 모델 모두 segmentation 결과가 내가 보기에는 나쁘지 않았음
<br>
<br>

**7. 회고**
- 메모리 이슈로 배치크기를 8>4>2로 줄이고, VGG16-UNet에서는 이미지 사이즈를 256 > 128로 줄였더니, 아슬아슬하게 학습을 완료할 수 있었다.
- 구글 코랩에서 먼저 시도하다가 학습 속도가 너무 느려서 다시 LMS에서 학습을 진행하였는데, 메모리 이슈/버전 충돌 등 여러모로 애물단지 LMS가 오늘 막판에 훈련을 휘리릭 끝내줘서 고마웠다.
- 프로젝트 전 마지막 학습 main quest를 마치며, 모르는 게 한참 많아 걱정되지만 공부한다는 마음으로 아이펠톤 시작해야 겠다 다짐해 본다.
