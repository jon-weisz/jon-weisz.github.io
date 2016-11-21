---
layout: post
title: "Lets not use COLLADA for simple geometry anymore."
excerpt: "Fool me once, shame on ... someone. Look, these files just suck."
tags: [Robotics, Assimp, Moveit, Collada, Fool-me-twice]
comments: false
image:
  feature: 11-19-2014/collada_post_header.png
---
# UPDATE 11-20-2016
Many of the problems noted in this post have been fixed by this [PR](https://github.com/ros-planning/geometric_shapes/pull/52)
to the geometry_shapes package. Thanks to Gijs vd. Hoorn for this fix!

In short, the Collada parser used by MoveIt! and 
much of the rest of the ROS ecosystem is now consistent with the behavior of RViz. The key note from the PR is the following:

> Assimp enforces a Y_UP convention when importing file formats that store this metadata, such as the collada format with the <up_axis> tag.

It is still probably not consistent with Gazebo - Check that the up_axis of your collada files is the Y axis to make sure that Assimp doesn't rotate your models.

WARNING: Note that this PR will be released into the binary packages soon, and may result in both your visual and collision meshes rotating mysteriously. 

I have left the rest of this post intact for historical reasons. 

# What is wrong with this bleeping robot!
We've had a Mico robot in the lab for a little while now, and in some ways it's a neat little guy. It's fast and smooth, and it has a nicely polished look. Unfortunately, the MoveIt! package that I have been using to plan smooth trajectories for it has been working... intermittently for quite some time. There are a bunch of small issues that complicate things.
 
1. Four of it's joints have huge joint ranges.
2. The angles between its successive joints are unusual.
3. The geometry of the arm links are very complex. 

I have been seeing really odd, sporadic problems with MoveIt! These problems were hard to reproduce, but eventually I found a legal seeming pose that is inexplicably problematic.  This perfectly collision free position shown in the image below is highlighted red, which means that the MoveIt! IK solver thinks it is in an illegal pose. 


![Inverse Kinematics Failure. This is bad.]({{site.url}}/images/11-19-2014/no_collision_objects_cropped.png)

## Large joint ranges can be really bad. 
Several of the Mico's joints can rotate from -10,000 to 10,000 degrees. While this might seem useful, it means that discretized searches of through it's state space are impractical. If the joint is implemented in the robot description files as a "continuous joint", some tools know how to handle this range more intelligently. 

Unfortunately, support is for them somewhat sporadic in the general ROS framework. Internally, parts of the driver for the arm also does some "normalization" that map the joint angles to some smaller range to simplify calculations, so a robot description file that limits the joint angles in some way needs to use the same representation. 

## Unusual configurations can be really bad. 
The angles between robot joints are usually some some comfortable fraction of 90 degrees. The Mico Arm's are not. This is probably why [IKFast automated inverse kinematics plugin generation fails for the Mico arm](http://openrave-users-list.185357.n3.nabble.com/ik-autogenerate-failing-for-the-6-DoF-Mico-arm-td4026861.html). The IKFast plugin is really fast and reliable, especially since it produces several prospective solutions, so it's unavailability is very unfortunate.  

## Nice, smooth lines mean huge, ugly geometry files. 
The Mico arm is very aesthetically clean and modern looking. Unfortunately, that look comes with some awfully complicated geometry files, with smooth sweeping arcs that are a major pain to generate mesh files and URDF files for. Many of the links are non-convex, which makes collision checking more expensive. The package that the manufacturer, Kinova, provides uses XML COLLADA files to represent the triangle meshes of the individual links. Collada is a full featured standard that can be used to describe full robots, and that means it requires a pretty complicated parser. It also means that relatively few open source programs handle it. The two standard tools for simplifying meshes in robotics are Meshlab and Blender. In Ubuntu 12.04 repos, neither will handle Collada files. Apparently, the standard library used in ROS to handle meshes, ASSIMP, does not handle them consistently either.

## Everything or nothing 
These are the obvious problems I considered, but I tried dozens of other random small fixes, including varying the parameters in the ompl_planning and kinematics yaml files. The main clue was this behavior -

![Inverse Kinematics Failure with no objects. This is really bad.]({{site.url}}/images/11-19-2014/no_collision_no_objects_cropped.png)

Still illegal, even though there is only one simple object! But without the table plane, the problem goes away. This indicates that it isn't a problem with the planner or kinematics configuration. That pretty much pins it down to the robot geometry files. So, I replaced them with bounding box approximations generated in Blender. 

Unfortunately, the problem persisted. Finally, I bit the bullett and worked through the moveit_ros visualization package, which has a separate IK solver from the main move_group node, and implemented a branch that [visualizes the collisions of the moveit rviz plugins interactive markers](https://github.com/jon-weisz/moveit_ros/commit/65afc306875ac2a362b8e04ccab171ef4ac759d0). Low and behold, there's definitely some phantom geometry causing collisions...

![There's the phantom geometry!]({{site.url}}/images/11-19-2014/collision_no_objects_cropped_annotated.png)

*# Well now what?
I looked at the geometry files, and realized that the problematic geometry files have an extra transform tag that ASSIMP seems to not parse correctly. I don't have time to track this down, so I replaced the COLLADA files with simple STL files, and like magic, everything is better!


# I've been here before...
Way back in the crazy days of 2013, I was interning at Willow Garage and it was awesome. I had just learned how to use GitHub, and I was making my first commit to a large project. Good ole [rviz pull request #603](https://github.com/ros-visualization/rviz/pull/603). I'll never forget that pull request. It was a tricky bug to figure out. See, I'd been given a robot description package for [a project that shall not be named](http://spectrum.ieee.org/automaton/robotics/industrial-robots/platformbot-willow-garages-secret-robot-prototype), and the robot would load into RViz just fine, but in Gazebo the robot was invisible. It turned out that the units tag in the header of the Collada files was read by Gazebo, but ignored by RViz. So, I fixed it by making RViz load the units tag, and had my pull request accepted! It was a tricky bug to track down, and I was very satisfied with myself. 
Sadly, that caused [this bug for everyone else using collada files with incorrect units tags, including the popular Turtlebot](https://github.com/ros-visualization/rviz/issues/622), and pissed off a whole lot of people. 

#No More Collada
So, the only rational response would seem to be no more collada files. In fact, I've had similar problems with other complex geometry formats like OpenInventor. Support for .tri files, .ply files, and STEP files is sporadic. robot_description packages should provide simple, well supported geometry files, and for now I'm sticking with STL. 

