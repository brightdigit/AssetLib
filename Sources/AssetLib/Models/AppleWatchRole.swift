public enum AppleWatchRole: String, Codable {
 /** The icon is used in the notification center. */
  case notificationCenter
  /**
  The icon is used in settings.
   */
  case companionSettings
  /** The icon is used in the app launcher. */
  case appLauncher
  /** The icon is used for a long-look notification. */
  case longLook
  /** The icon is used for a short-look notification. */
  case quickLook
}
