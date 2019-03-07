Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A10C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67132064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sUE6Yy7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCGRkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:40:45 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54658 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGRkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:40:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Mime-Version:Content-Type:References:
        In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hhvrBaiObdMzKQJ2IrqL1xw22go9BfiSTioWnfsLBqU=; b=sUE6Yy7+Y5SpFye7hC46dQap+
        cERVTsDgYwJQAgM58YuP+PU+rAfVUa/akQngh1/pvBr/FhtZkeHx3buyf3c361uKg/ZvvH9M6ukYG
        Iq5xd7AvhYNC8m08pp5/lq3BxXS6lt+PfPmCoJORFRpc+OkQzdBTkuBo4YB4vpHzhftbOkWmWfAg2
        BPCkMenduqGDdOqQ18FIXkhH6Us0cgdC4SQ4t0TkuHVybY4j3IsMyF/e6pLgAGIpKYgRkfFB2E7Dq
        uaOLIDgk4q5Y0WgEUL5fJewcj7V9LraLHeJ0HM23Onz4t3557JM+ujoMaC6aSBfNEIjAT1z0z0xvu
        oSLOtYxbw==;
Received: from 54-240-197-239.amazon.com ([54.240.197.239] helo=s3-prod-r2d2-p7412.iad7.amazon.com)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1x0E-0008NR-Nm; Thu, 07 Mar 2019 17:40:19 +0000
Message-ID: <a655aeea9c499623a458f79fba396ed8d088f2e1.camel@infradead.org>
Subject: Re: [PATCH v1 1/1] mtd: devices: add ACPI support for non-jedec
 m25p80
From:   David Woodhouse <dwmw2@infradead.org>
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 07 Mar 2019 17:40:16 +0000
In-Reply-To: <1551178088-6615-2-git-send-email-f.suligoi@asem.it>
References: <1551178088-6615-1-git-send-email-f.suligoi@asem.it>
         <1551178088-6615-2-git-send-email-f.suligoi@asem.it>
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-zCZvwULtmQ3uhlcwvXWx"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zCZvwULtmQ3uhlcwvXWx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-02-26 at 11:48 +0100, Flavio Suligoi wrote:
> For the x86 machines a m25p80-compatible device have to be declared using
> an ACPI table (which can be directly a part of the BIOS ACPI tables).
>=20
> In this case it is necessary to add the device in the "of_device_id" stru=
cture
> list, to permit the device name matching by the ACPI kernel functions.
>=20
> This is an example of a SSDT table for the Everspin mr25h40:
>=20
> DefinitionBlock ("mr25h40.aml", "SSDT", 5, "ASEMsp", "MR25H40", 1)
> {
> 	External (_SB.SPI1, DeviceObj)
>=20
> 	Scope (\_SB.SPI1)
> 	{
> 		Device (NVR0)
> 		{
> 			Name (_HID, "PRP0001")
> 			Name (_DDN, "Everspin MR25H40 MRAM")
> 			Name (_CRS, ResourceTemplate () {
> 				SpiSerialBus (
> 				1,                      // Chip select
> 				PolarityLow,            // Chip select is active low
> 				FourWireMode,           // Full duplex
> 				8,                      // Bits per word is 8 (byte)
> 				ControllerInitiated,    // Don't care
> 				10000000,               // 10 MHz
> 				ClockPolarityLow,       // SPI mode 0 ClockPolarityLow
> 				ClockPhaseFirst,        // SPI mode 0 ClockPhaseFirst
> 				"\\_SB.SPI1",      	// SPI host controller
> 				0,			// Must be 0
> 				ResourceConsumer,
> 				,
> 				)
> 			})
>=20
> 			Name (_DSD, Package () {
> 				ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> 				Package () {
> 					Package () {"compatible", "mr25h40"},
> 				}
> 			})
> 		}
> 	}
> }
>=20
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Why use the specific chip name in the "compatible" property? Why isn't
it using "jedec,spi-nor"?=20

Does this still actually get passed through to spi_nor_scan()... and is
it *necessary*? Can't the chips be probed?



> ---
>=20
> v1: - first patch version
>=20
>  drivers/mtd/devices/m25p80.c | 57 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index c4a1d04..b5c7db8 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -312,9 +312,64 @@ MODULE_DEVICE_TABLE(spi, m25p_ids);
>  static const struct of_device_id m25p_of_table[] =3D {
>  	/*
>  	 * Generic compatibility for SPI NOR that can be identified by the
> -	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
> +	 * JEDEC READ ID opcode (0x9F). Use this (jedec,spi-nor), if possible.
> +	 *
> +	 * The list of all flash devices is instead necessary in x86 machines,
> +	 * to use a "non-jedec device" inside the ACPI BIOS tables.
>  	 */
>  	{ .compatible =3D "jedec,spi-nor" },
> +	{ .compatible =3D "s25sl064a" },
> +	{ .compatible =3D "w25x16" },
> +	{ .compatible =3D "m25p10" },
> +	{ .compatible =3D "m25px64" },
> +	{ .compatible =3D "at25df321a" },
> +	{ .compatible =3D "at25df641" },
> +	{ .compatible =3D "at26df081a" },
> +	{ .compatible =3D "mx25l4005a" },
> +	{ .compatible =3D "mx25l1606e" },
> +	{ .compatible =3D "mx25l6405d" },
> +	{ .compatible =3D "mx25l12805d" },
> +	{ .compatible =3D "mx25l25635e" },
> +	{ .compatible =3D "mx66l51235l" },
> +	{ .compatible =3D "n25q064" },
> +	{ .compatible =3D "n25q128a11" },
> +	{ .compatible =3D "n25q128a13" },
> +	{ .compatible =3D "n25q512a" },
> +	{ .compatible =3D "s25fl256s1" },
> +	{ .compatible =3D "s25fl512s" },
> +	{ .compatible =3D "s25sl12801" },
> +	{ .compatible =3D "s25fl008k" },
> +	{ .compatible =3D "s25fl064k" },
> +	{ .compatible =3D "sst25vf040b" },
> +	{ .compatible =3D "sst25vf016b" },
> +	{ .compatible =3D "sst25vf032b" },
> +	{ .compatible =3D "sst25wf040" },
> +	{ .compatible =3D "m25p40" },
> +	{ .compatible =3D "m25p80" },
> +	{ .compatible =3D "m25p16" },
> +	{ .compatible =3D "m25p32" },
> +	{ .compatible =3D "m25p64" },
> +	{ .compatible =3D "m25p128" },
> +	{ .compatible =3D "w25x80" },
> +	{ .compatible =3D "w25x32" },
> +	{ .compatible =3D "w25q32" },
> +	{ .compatible =3D "w25q32dw" },
> +	{ .compatible =3D "w25q80bl" },
> +	{ .compatible =3D "w25q128" },
> +	{ .compatible =3D "w25q256" },
> +	{ .compatible =3D "m25p05-nonjedec" },
> +	{ .compatible =3D "m25p10-nonjedec" },
> +	{ .compatible =3D "m25p20-nonjedec" },
> +	{ .compatible =3D "m25p40-nonjedec" },
> +	{ .compatible =3D "m25p80-nonjedec" },
> +	{ .compatible =3D "m25p16-nonjedec" },
> +	{ .compatible =3D "m25p32-nonjedec" },
> +	{ .compatible =3D "m25p64-nonjedec" },
> +	{ .compatible =3D "m25p128-nonjedec" },
> +	{ .compatible =3D "mr25h128" },
> +	{ .compatible =3D "mr25h256" },
> +	{ .compatible =3D "mr25h10" },
> +	{ .compatible =3D "mr25h40" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, m25p_of_table);
> --=20
> 2.7.4
>=20
>=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/


--=-zCZvwULtmQ3uhlcwvXWx
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkw
MzA3MTc0MDE2WjAvBgkqhkiG9w0BCQQxIgQgFKRWjdVmsz8eqlnsAzFwGUwl88vUdRoGzWDATGs+
v5Ewgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAKUKshlUumrCLmTDeqwpjbYsnFv/TPy/P9BQjhInZ0cqyNrQwMB4Hx/mmE7qJ0Ih
O2k2c7CgQMQLEIqeD/a6oivtAPxCbSd71YA8C+Bu7AKDlCFvyUIJlzYdq5UvZfT+ABG3NMjd58+P
dDpOqMNh4hu3gJolLFVH2EC56UVoyUDGscN2JWroLEpq7D6tfJpN3RBDfJdStYr31ykZigFpeB3/
9jiPr6mB4EwF6XzkWDGVDCIo89UcHNyz9BQr4SW1Na30QUI6S8qIz0lc33z0s1PcosXS3H1qK9Yc
AEn1/RBMr2yn/GJ/yRIvhXEJQE9Le5SZX+sa8cgoTUwkAbN4FAUAAAAAAAA=


--=-zCZvwULtmQ3uhlcwvXWx--

