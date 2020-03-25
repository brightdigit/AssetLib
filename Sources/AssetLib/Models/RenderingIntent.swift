/**
 Specifies if the image is a template for use with visual effects such as replacing colors.
 */
public enum RenderingIntent: String, Codable {
  /**
   Render as the original image.
   */
  case original
  /**
   Use the image as a template for visual effects such as replacing colors.
   */
  case template
}
