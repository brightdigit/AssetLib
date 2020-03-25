/**
 Specific scaling supported by the ImageSet.
 */
public enum TemplateScaling: String, Codable {
  /**
   Single vector PDF image file.
   */
  case single
  /**
   Raster image files for each scale.
   */
  case individual
}
