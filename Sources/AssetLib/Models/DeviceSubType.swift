/// The type of Apple Watch when there is more than one icon size for a role.
public enum DeviceSubType: String, Codable {
  /** The icon is for a 38mm Apple Watch. */
  case size38 = "38mm"
  /** The icon is for a 40mm Apple Watch. */
  case size40 = "40mm"
  /** The icon is for a 41mm Apple Watch. */
  case size41 = "41mm"
  /** The icon is for a 42mm Apple Watch. */
  case size42 = "42mm"
  /** The icon is for a 44mm Apple Watch. */
  case size44 = "44mm"
  /** The icon is for a 45mm Apple Watch. */
  case size45 = "45mm"
  /** For ImageSets which will be used in mac Catalyst apps.  */
  case macCatalyst = "mac-catalyst"
}
