<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'user' );

/** MySQL database password */
define( 'DB_PASSWORD', 'user' );

/** MySQL hostname */
define( 'DB_HOST', 'mysql' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

define('FS_METHOD', 'direct');

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'li?EcOcAfev2}M-E-LCxgEv_UoTgH(');
define('SECURE_AUTH_KEY',  '<XmeiU]se#<UuIi;:;4?j;|Fkc6"%N');
define('LOGGED_IN_KEY',    'nJMBWSJ7uaC1VpddkUWafb3kGVorEN2D');
define('NONCE_KEY',        'mMy1rpqosaKvus9OGlc7gup9D5mQWUiu');
define('AUTH_SALT',        '@yS/o%9`?/{c]9vBk95y{WfDDtxTH`0mkIfowQ52"sV>%B_k-B]*+Iaw^F[{H]t');
define('SECURE_AUTH_SALT', '`3U[<hm/P<~1;E9:}ua$h-GKeE2b71huWsHI))Q>u#Ic5aTzhC&%*_q3w:Nz~8');
define('LOGGED_IN_SALT',   'R{TM-tni=* N_is+X #e2NLR!>Obj6WTR% c~.b1sC/Uo/K/}%O$mMO5BL%.}j-h');
define('NONCE_SALT',       'p-,c%|pS%=po;Zm|S}gP>RS|N!)Y=!C+:-Y)}&=i>`GF0P{o$icY+kh ZvdxEh%-');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) )
	define( 'ABSPATH', __DIR__ . '/var/www/wordpress' );

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
