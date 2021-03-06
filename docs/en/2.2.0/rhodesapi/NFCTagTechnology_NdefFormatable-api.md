# NFCTagTechnology_NdefFormatable API

Subclass of NFCTagTechnology.

**NOTE: As of Rhodes version 3.3.3, the [Barcode](barcode-api), [NFC](../rhodes/device-caps#nfc), and [Signature Capture](../rhodes/device-caps#signature-capture) APIs, as well as [Rhom data encryption](../rhodes/rhom#database-encryption) are removed from Rhodes. These features are only supported in Zebra RhoMobile Suite. If you wish to use these features, you will need to [upgrade to RhoMobile Suite](../rhomobile-install). Your application's build.yml will also need to be modified to [indicate the application type is 'Rhoelements'](../rhoelements/rhoelements2-native#enabling-motorola-device-capabilities). Additionally, a [RhoElements license](../rhoelements/licensing) is required.**

## Enabling NFC

To use the NFC methods, you need to enable NFC on the Android device and ensure that the version is 2.3.3 or later. Do this by adding that capability to the build.yml file:

	:::yaml
	android: 
	  version 2.3.3
	  extensions:
	  - nfc

## format

Formats a tag as NDEF, and writes an NdefMessage. The card is left in a read-write state after this operation. This is an I/O operation and will block until complete.

	:::ruby
	Rho::NFCTagTechnology_NdefFormatable.format(msg)

<table border="1">
<tr>
	<td><code>msg</code></td>
	<td>an NdefMessage.</td>
</tr>
</table>

## format_read_only

Formats a tag as NDEF, write a NdefMessage, and makes it read-only. The card is left in a read-only state if this method returns successfully.

	:::ruby
	Rho::NFCTagTechnology_NdefFormatable.format_read_only(msg)

<table border="1">
<tr>
	<td><code>msg</code></td>
	<td>an NdefMessage.</td>
</tr>
</table>