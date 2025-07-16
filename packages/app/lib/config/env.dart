class Env {
  static const String baseUrl = String.fromEnvironment('BASE_URL');
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );

  static const bool isProduction = environment == 'prd';
  static const bool isDevelopment = environment == 'dev';
  static const bool isStaging = environment == 'stg';
}
