# NIS3D
A Completely Annotated Benchmark for Dense 3D Nuclei Image Segmentation.

## Introduction
NIS3D collects 6 large volume 3D embryonic nuclei images from the three most widely used species in the field with over 22,000+ manually annotated cells.

Here are examples of NIS3D. Each row represents a specific data, with columns from left to right displaying raw data, the annotated ground truth, and the corresponding confidence score map, respectively. Confidence scores are assigned on a four-level scale to indicate the reliability of each annotation, from low to high: ''undefined masks'', ''1/3'', ''2/3'', and ''3/3''. These levels are labeled by the colors deep blue, light blue, yellow, and red, respectively. It's worth noting that ''undefined mask'' indicates regions with a group of very blurry cells that annotators can't decide their boundaries. The detection whose majority of pixels are within the undefined masks will be ignored, neither considered as true positive nor false positive.

<p align="center">
 <img src="./figures/NIS3Dexample4.png" width="70%">
</p>

## Advantage

- A good representation: NIS3D provides large-volume images of high cell densities, with nuclei whose signal-to-noise ratio, shape, and brightness vary with position. These properties make this benchmark challenging but well representative of data from real research.

- 3D complete annotation: All cells are annotated, and all labels are 3D. Compared with sparse annotation or 2D annotation, NIS3D can provide a more comprehensive evaluation, including the evaluation of false positives.

- Confidence score: A confidence score is computed for each cell, allowing more nuanced testing and performance comparison.

- Multiple species: NIS3D contains the three most commonly used species in this field (zebrafish, drosophila, and Mus Musculus) to provide enough diversity.

- Annotation tools: We designed a semi-automatic annotation tool, PrinCut, which significantly speeds up the workflow and reduces human bias when the boundary is weak.

## Evaluation metrics

**Preprocessing and truth positive criteria**  To initiate the process, we exclude detections where more than 50% of
their pixels fall within the undefined mask. Then for a given detection
*D*<sub>*i*</sub>, we determine it matches with ground truth
*G*<sub>*j*</sub> if and only if both of the two following condition
holds:
*D*<sub>*i*</sub> = arg max<sub>*D*<sub>*k*</sub></sub>IoU(*D*<sub>*k*</sub>,*G*<sub>*j*</sub>)   *G*<sub>*j*</sub> = arg max<sub>*G*<sub>*k*</sub></sub>IoU(*D*<sub>*i*</sub>,*G*<sub>*k*</sub>),
where *D*<sub>*k*</sub> and *G*<sub>*k*</sub> are all possible choices
from detections and ground truth, and IoU(*A*,*B*) is the intersection
over the union between *A* and *B*.

#### Weighted precision(W-Precision), recall(W-Recall), and F1(W-F1)

The weighted scores are based on the confidence score.

The weighted true positive (W-TP) and false negative (W-FN) are
calculated as follows:

$$\begin{aligned}
    \text{W-TP} &= \sum C_i T_i \qquad
    \text{W-FN} &= \sum C_i (1-T_i),
\end{aligned}$$

where *C*<sub>*i*</sub> is the confidence score of ground truth
*G*<sub>*i*</sub> and *T*<sub>*i*</sub> is the detection flag of
*G*<sub>*i*</sub>. *T*<sub>*i*</sub> = 1 indicates if *G*<sub>*i*</sub>
is detected, otherwise *T*<sub>*i*</sub> = 0.

The weighted precision (W-Precision), recall (W-Recall), and F1 (W-F1)
are calculated as follows:
$$\begin{aligned}
    \text{W-Precision} = \frac{\text{W-TP}}{\text{W-TP} + \text{FP}}  \quad
    \text{W-Recall} = \frac{\text{W-TP}}{\text{W-TP} + \text{W-FN}} \quad
    \text{W-F1} = \frac{2\text{W-TP}}{2\text{W-TP} + \text{FP} + \text{W-FN}}
\end{aligned}$$

#### Weighted IoU

Weighted IoU (W-IoU) is used to show the accuracy of foreground of
detection.
$$\text{W-IoU} =\frac{\sum\_{i\in A\cap B} f(i)}{\sum\_{i\in A} f(i) + \sum\_{i\in  B/A} 1}$$

where *A* is the pixel belong to ground truth, *B* is the pixel belong
to detection, and *f*(*i*) is the confidence score of *i*-th pixel.

#### Weighted SEG

Weighted SEG (W-SEG) score is used to show the average IoU score of all
cells.
$$\text{W-SEG} =\frac{\sum C_i G_i}{\text{W-TP}+\text{W-FN}+\text{FP}},$$
where *G*<sub>*i*</sub> is the IoU score of the *i*-th ground truth.

## Resource

**The paper can be found here:** *TBA*

**The dataset can be found here:** [*NIS3D*](https://drive.google.com/drive/folders/1LLI2-kW1Py90373WUO5FX7w7b0vIrKLE?usp=sharing).

The organization of NIS3D is shown in the figure below. Each folder contains 5 files, "Data.tif", "GroundTruth.tif", "ConfidenceScore.tif", "Visulize.tif", and "Info.txt". The "Data.tif" is the raw data. The "GroundTruth.tif" give the labels of ground truth. Different numbers in "GroundTruth.tif" represent different labels and 0 represents the background. "ConfidenceScore.tif" shows the confidence score map. The pixels belonging to the same label have the same confidence score. The value of "ConfidenceScore.tif" range from 0 to 4. 0 means background, 1 means undefined mask, 2 means 1/3 confidence score, 3 means 2/3 confidence score, and 4 means 3/3 confidence score. "Visulize.tif" shows the raw data, the ground truth labels, and the confidence score at the same time, which is the same as Figure 1 of the main paper. The "Info.txt" gives a brief description of the data and the link to the original paper of the data for more detail information. The tif file is a widely used format in the field. The software Fiji is one popular option to open and view tif files. 

<p align="center">
 <img src="./figures/DataStructure2.jpg" width="50%">
</p>

**The annotation tool can be found here:** [*PrinCut*](https://drive.google.com/drive/folders/1iKrQtGZO3NGYLe-UPaejNIy6mL8UFrTi?usp=sharing).
