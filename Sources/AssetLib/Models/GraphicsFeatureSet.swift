public enum GraphicsFeatureSet: String, Codable {
  /**
   The item requires features in MTLFeatureSet_iOS_GPUFamily1_v2.
   */
  case metal1v2

  /**
   The item features in MTLFeatureSet_iOS_GPUFamily1_v3.
   */
  case metal1v3

  /**
   The item requires features in MTLFeatureSet_iOS_GPUFamily2_v2 and MTLFeatureSet_tvOS_GPUFamily1_v1.
   */
  case metal2v2

  /**
   The item requires features in MTLFeatureSet_iOS_GPUFamily2_v3 and MTLFeatureSet_tvOS_GPUFamily1_v2.
   */
  case metal2v3

  /**
   The item requires features in MTLFeatureSet_iOS_GPUFamily3_v1.
   */
  case metal3v1

  /**
   The item requires features in MTLFeatureSet_iOS_GPUFamily3_v2.
   */
  case metal3v2

  /**
   The item requires features in iOS_GPUFamily4_v1.
   */
  case metal4v1

  case apple6
}
