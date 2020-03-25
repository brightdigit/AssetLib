/**
 The minimum device memory configuration required by the data item.
 */
public enum Memory: String, Codable {
  /**
   The device needs at least a 1GB memory configuration.
   */
  case requires1GB = "1GB"
  /**
   The device needs at least a 2GB memory configuration.
   */
  case requires2GB = "2GB"
  /**
   The device needs at least a 3GB memory configuration.
   */
  case requires3GB = "3GB"
  /**
   The device needs at least a 4GB memory configuration.
   */
  case requires4GB = "4GB"
  /**
   The device needs at least a 6GB memory configuration.
   */
  case requires6GB = "6GB"
}
