-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {  
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,

  map_frame = "map",
  tracking_frame = "base_link",  
  published_frame = "base_link",    
  odom_frame = "odom",    
  provide_odom_frame = false, 
  publish_frame_projected_to_2d = false,
  use_odometry = false,    
  use_nav_sat = true,     
  use_landmarks = false,
  num_laser_scans = 0, 
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 1,
  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3, 
  pose_publish_period_sec = 2e-2,       
  trajectory_publish_period_sec = 2e-2,  
  rangefinder_sampling_ratio = 1., 
  odometry_sampling_ratio = 0.1, -- 1.,  
  fixed_frame_pose_sampling_ratio = 1., 
  imu_sampling_ratio = 1.,  
  landmarks_sampling_ratio = 1.,
}


MAP_BUILDER.use_trajectory_builder_3d = true 
TRAJECTORY_BUILDER.pure_localization = true


TRAJECTORY_BUILDER_3D.min_range = 1 
TRAJECTORY_BUILDER_3D.max_range = 200 



TRAJECTORY_BUILDER_3D.high_resolution_adaptive_voxel_filter.max_length = 2   
TRAJECTORY_BUILDER_3D.high_resolution_adaptive_voxel_filter.min_num_points = 150  
TRAJECTORY_BUILDER_3D.high_resolution_adaptive_voxel_filter.max_range = 15  


TRAJECTORY_BUILDER_3D.motion_filter.max_time_seconds = 0.08
TRAJECTORY_BUILDER_3D.motion_filter.max_distance_meters = 0.08  
TRAJECTORY_BUILDER_3D.motion_filter.max_angle_radians = 0.002


TRAJECTORY_BUILDER_3D.submaps.num_range_data = 60  


TRAJECTORY_BUILDER_3D.use_online_correlative_scan_matching = false 
TRAJECTORY_BUILDER_3D.real_time_correlative_scan_matcher.linear_search_window = 0.15 
TRAJECTORY_BUILDER_3D.real_time_correlative_scan_matcher.angular_search_window = math.rad(1.) 



MAP_BUILDER.num_background_threads = 8 




POSE_GRAPH.optimize_every_n_nodes = 20  

POSE_GRAPH.optimization_problem.huber_scale = 1e1  

POSE_GRAPH.optimization_problem.acceleration_weight = 1e3 
POSE_GRAPH.optimization_problem.rotation_weight = 3e5 

POSE_GRAPH.optimization_problem.local_slam_pose_rotation_weight = 1e3 
POSE_GRAPH.optimization_problem.local_slam_pose_translation_weight = 1e3   

POSE_GRAPH.optimization_problem.odometry_translation_weight = 1e5    
POSE_GRAPH.optimization_problem.odometry_rotation_weight = 1e5    

POSE_GRAPH.optimization_problem.fixed_frame_pose_translation_weight = 1e3 
POSE_GRAPH.optimization_problem.fixed_frame_pose_rotation_weight = 1e2  
POSE_GRAPH.optimization_problem.log_solver_summary = false  

POSE_GRAPH.optimization_problem.ceres_solver_options.max_num_iterations = 100  
POSE_GRAPH.optimization_problem.ceres_solver_options.num_threads = 14  




POSE_GRAPH.constraint_builder.sampling_ratio = 0.3 
POSE_GRAPH.constraint_builder.min_score = 0.55 
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.6 

return options
