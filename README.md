# K Street Bike Lanes Difference in Difference Analysis
# [Tableau Dashboard](https://public.tableau.com/app/profile/josiah.blackwell.lipkind/viz/KStreetBikeLaneProjectAnalysisFinal/Version2) 


## Background
Many urban areas across the US, including the DC region, have been implementing Complete Streets road designs, introducing traffic calming, bike lanes, and other measures to accommodate safe travel for all transportation modes and users. 
These strategies promise to improve safety and encourage non-vehicle travel. There have been some studies demonstrating these effects, using street design changes as natural experiments.

However, more research is needed, especially comprehensive analyses of safety and traffic impacts, not just on the treatment corridor itself but on the surrounding network. Research is also needed to better understand suppressed demand, or the [disappearing traffic effect](https://www.icevirtuallibrary.com/doi/10.1680/muen.2002.151.1.13), as well as the impact of Complete Street strategies on economic activity. </p>
  

## Approach
My research here aims to contribute to existing research on the safety, traffic, and economic impacts of Complete Streets design. [Buehler and Pucher (2012)](https://link.springer.com/article/10.1007/s11116-011-9355-8) perform a cross-sectional analysis to correlate bike infrastructure with commute bike trips. Consistent with other research, including a study by [Dill and Carr (2003)](https://journals.sagepub.com/doi/10.3141/1828-14), they find that the extent of bike infrastructure is a good predictor of cycling levels. More recently, [Kraus and Koch (2022)](https://www.sciencedirect.com/science/article/pii/S2590198222001373?via%3Dihub) use the introduction of cycling infrastructure during the COVID-19 pandemic as a natural experiment. They generate a panel regression of bicycle traffic in 106 European cities before and after the pandemic-induced “treatment" and find robust evidence that the introduction of more bicycle infrastructure induced greater ridership. Moreover, [Marshall and Ferenchak (2019)](https://www.sciencedirect.com/science/article/abs/pii/S2214140518301488?via%3Dihub) find that the more bike infrastructure is associated with improved safety for all road users. And Liu and Shi (2020) find that street improvements like bike lanes have either positive or non-significant impacts on surrounding economic activity. 

I build on this research by focusing on the [K Street Protected Bike Lanes project](https://www.mountvernontriangle.org/wp-content/uploads/2020/04/K-Street-NW-NE-Revised-Preliminary-Design-Plans-v2.pdf) implemented by DC DOT in Spring 2021. The project reallocated street space on the 0.9 miles of K Street in DC between 7th St NW and 1st St NE. The road's four vehicle travel lanes (some of which were used as full-time, AM rush, and PM rush on-street parking) were reduced to two travel lanes: one lane for on-street parking or a turn lane and two protected bike lanes, one in each direction. In effect, one vehicle travel lane and some on-street parking space was replaced with dedicated bicycle infrastructure.
This street design change provides a unique natural experiment to assess the impacts of Complete Streets on safety, traffic, and economic activity. 
<p> In order to distinguish between direct and indirect/spillover effects of the treatment, I distinguish between a direct and indirect treatment group. The term "study corridor" refers to the 0.9 miles of K Street that directly received the treatment, and "study area" refers to the surrounding streets which might have been indirectly impacted by the treatment.
<p> In particular, I am interested in the key questions listed below.


### Key Questions
* **Traffic:** How did the K Street project change the number and share of trips made by vehicle, bicycle, and pedestrians in the study corridor and study area? 
* **Safety:** How did the K Street project impact safety? How did the number of pedestrian, bicycle, and vehicle-involved crashes change on the study corridor and in the study area?
* **Economic Vitality:** How did the K Street project impact business sales in the region around the study corridor?

### Data Sources

Replica is the primary source of data. It scales up real-world cellphone and GPS data and joins it to ground truth demographics and travel behavior from federal data to create a synthetic population that can be used to model travel behavior across the country. Travel behavior data is released twice a year (Spring and Fall) for a typical Thursday and Saturday. Replica data is relatively new and this research aims to demonstrate how this data can be used for interesting retrospective travel behavior analyses. 

* **Safety:** Safety data is collected from [DC Open Data](https://opendata.dc.gov/datasets/crashes-in-dc/explore) for 2019 and 2022.  
* **Traffic:** Vehicle, bicycle, and pedestrian trips are collected using Replica data [(the Network Volumes Puller)](https://app.hex.tech/replica/app/86501078-643c-4cb6-8208-df8180a64c58/latest). To estimate the number of vehicle trips, we add trips for "private auto," "on demand," and "carpool." Because the K Street road design occurred in 2021, we use Fall 2019 Replica data for the before period and Fall 2022 Replica data for the after period, focusing on Thursdays.
* **Traffic Share:** Using the traffic data above, traffic share is calculated as the share of each of the three modes out of the total of these three modes. I drop commercial, public transit, and other modes for simplicity.
* **Business Sales:** Economic activity data is based on credit card transactions sourced from Replica. Data is only available through Replica at the Census block level. I use Census Tracts 47.01 and 47.02 as a proxy for economic activity surrounding the K Street Corridor. I compare summed spending data on Restaurants & Bars, Grocery Stores, Retail and Entertainment & Recreation between these treatment Tracts and DC as a whole before and after treatment. It is important to note that this spend data includes e-commerce, as well as in-person transactions.<p>


### Methodology
As noted above, the study corridor is the 0.9 mile stretch of K Street between 7th St NW and 1st St NE.
The study area is defined as all streets within one half mile of the study corridor.
<p> The period of study during which our natural experiment took place spans 2019 to 2022. This overlaps with the Covid pandemic, which had dramatic effects on travel patterns which must be controlled to isolate the impacts of just the K Street project. More broadly, our methodology must control for any changes between 2019 and 2022 that may have impacted travel behavior.
To accomplish this, we make use of a difference-in-difference approach to compare data before and after the treatment between treatment groups and controls. This allows us to narrow in on the effect of the treatment alone and make causal claims.
  
<p> A crucial first step to carry out a difference in difference approach is to identify a group of appropriate control corridors. We need this control group to meet the Parallel Trends Assumption, meaning that in the absence of the treatment, we would expect the control and the treatments to experience the same trends. We are limited by data availability to a single datapoint in the before period, which prevents us from carefully checking for parallel trends. At best, we must select control roads that we are reasonably confident in assuming experienced similar trends to the treatment in the before period. We do this using two strategies to select control segments:
  
1. All segments within 2 miles of the study corridor (1.5 miles of the study area), filtered for just named roads (no alleys, driveways, or other small roads)

![Screenshot 2023-11-26 133146](https://github.com/josiahbl/K-Street-Bike-Lane-Project-Analysis/assets/144189314/72a1394b-6a83-4320-9007-5b30bc09dbab)

2. Manual filtering of the segments within 2 miles of the study corridor for just those that are qualitatively similar to K Street, based on my understanding the city. These are: 7th St NW, 9th St NW, 14th St NW, 15th St NW, Columbia Rd NW, E St NE, E St NW, Florida Ave NW, G St NE, G St NW, Georgia Ave NW, K St NE, K St NW, M St NE, M St NW, New Jersey Ave NW, Q St NE, Q St NW, R St NE, R St NW, S St NE, S St NW, V St NE, V St NW, W St NE, and W St NW.

![Screenshot 2023-11-26 133119](https://github.com/josiahbl/K-Street-Bike-Lane-Project-Analysis/assets/144189314/0231c9d6-773d-4cee-9089-c38809b08b26)


These two strategies generate similar results, which provides additional confidence in our conclusions.

Replica trip data is split between roads and sidewalks and is split based on traffic directionally (see below).
![Screenshot 2023-12-02 142006](https://github.com/josiahbl/K-Street-Bike-Lane-Project-Analysis/assets/144189314/2c292cc0-5ecd-427f-b4c4-5e693457bfaf)


I use an R script to consolidate Replica data into single line features for each road. In effect, we assign sidewalk segments to the nearest road coded in the same direction, and then I aggregate the trip data. This methodology is not perfect, but it gets us very close to a perfect consolidation. 

For crash data, I use a similar script to assign each crash to the nearest road in the consolidated dataset. Then I aggregate this data to get the number of crashes on each road segment.

Finally, the data is coded as either a direct treatment (study corridor), indirect treatment (study area), or control, as well as before (2019) or after (2022) treatment.


Below is a high-level sample methodology:

1. **Before values**: Determine the share of bicycle trips before the intervention (Fall 2019) for the treatments and control.
2. **After values**: Determine the share of bicycle trips after the intervention (Fall 2022) for treatments and control.
3. **Difference**: Find the difference between the before and after bicycle values for treatments and control.
4. **Difference in difference**: Compare the difference in bicycle share between the study corridor and the control and the study area and the control. That is, take the difference of these two values. This estimates the change in bicycle share in the study corridor that cannot be explained exogenously (covid, other environmental trends). This is the causal effect of the intervention.

### Conclusions
Note: The numbers included below are based on strategy #2 (selected controls).  
<p>
  
</p>
The study corridor saw a substantial increase in bike trips and share (+350%). The increase in biking appears to have spilled over into the study area (+43%). <p>
<p>
  
</p>
Relative to controls, walk share declined slightly in both the study corridor (-26%) and study area (-28%). Biking may have replaced some trips that were previously made on foot. <p>
<p>
  
</p>Vehicle trip share fell very slightly in the study corridor (-10%) despite seeing marginal increases in the study area (+33%). Ultimately, this suggests that the street design change had a limited effect on vehicle movements, though some traffic may have rerouted to surrounding streets. <p>
<p>
  
</p>The rate of crashes per trip fell for all modes: bike (-32%), auto (-53%), and walking (-19%). However, I would caution against reading into these results due to limited data and methodological limitations. <p>
<p>
  
</p>Business sales in the two Census Tracts used as proxies for the study corridor saw significant growth, particularly after the street design intervention. This growth outpaced the average in the District by about 200%. <p>
<p>
  
</p>Overall, the intervention had significant benefits for travel by bicycle and economic activity. It appears to have had a positive effect on safety. And it did not dramatically affect travel by other modes; indeed, vehicle travel, at least in terms of trips and trip share, was not seriously affected. 

### Limitations and Future Research
There are several limitations in this research, which offer opportunities for future research. I group these into four categories:
* **Data Limitations:** The analysis is limited to just three modes (walking, biking, and driving). It does not incorporate public transit. Future research should expand the analysis to all modes. Another concern is that Replica data may not be entirely accurate at small scale sued for this analysis; it is an approximation at best. The consolidation methodology was not entirely accurate. There is room for improvement here based on this first pass. I assigned sidewalk data to the nearest road segment in the same direction, but sidewalk segments were not always coded in the same direction as the nearest road. Some sidewalk segments were particularly long, curving around corners. The result is that some sidewalk data (perhaps 10% or so), particularly walking and biking trips, was either dropped or assigned to the wrong road.
* **DID Analysis Limitations:** Data limitations preclude a complete Parallel Trends Assumption test in the before period. As Replica data continues to evolve, more precise checks of parallel trends will be possible.
* **Crash Analysis Limitations:** The crash analysis is imperfect. Crash analyses in general are extremely complicated and prone to error. Safety is impacted by many confounding factors. Most impactful was the limited area of analysis and the short timeframe after the treatment for data collection; the result is a limited sample size that affects explanatory power.
* **Economic Analysis Limitations:** Two Census tracts, which extend beyond the study corridor and do not cover its Eastern portion were used as a proxy to estimate economic activity. Future research might use more precise data. This spending data also includes e-commerce spending, which might be a source of error.

In general, the methodology tested here should be replicated for other corridors that received similar treatments. This would increase sample size, which would address some of the above concerns. For example, the 9th St bikeway in DC would be another appropriate corridor of study. <p>


