# NIS3D
A Completely Annotated Benchmark for Dense 3D Nuclei Image Segmentation

## Introduction
NIS3D collects 6 large volume 3D embryonic nuclei images from the three most widely used species in the field with over 22,000+ manually annotated cells.

![Examples of NIS3D benchmark. Each row represents a specific data, with columns from left to right displaying raw data, the annotated ground truth, and the corresponding confidence score map, respectively. Confidence scores are assigned on a four-level scale to indicate the reliability of each annotation, from low to high: ``undefined masks'', ``1/3'', ``2/3'', and ``3/3''. These levels are labeled by the colors deep blue, light blue, yellow, and red, respectively. It's worth noting that ``undefined mask'' indicates regions with a group of very blurry cells that annotators can't decide their boundaries. The detection whose majority of pixels are within the undefined masks will be ignored, neither considered as true positive nor false positive.](./figures/NIS3Dexample4.png)
