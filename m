Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05713C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58CC2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391518AbfGRURQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:17:16 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42108 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfGRURQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 16:17:16 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 2B2CC802B6; Thu, 18 Jul 2019 22:17:03 +0200 (CEST)
Date:   Thu, 18 Jul 2019 22:17:13 +0200
From:   Pavel Machek <pavel@denx.de>
To:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org,
        johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Subject: USB Modem support for Droid 4
Message-ID: <20190718201713.GA25103@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Tony Lindgren <tony@atomide.com>

Droid starts to have useful support in linux-next. Modem is tricky to
play with, but this is enough to get basic support.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 613f91a..3ca9439 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -181,6 +181,9 @@ static const struct usb_device_id id_table[] =3D {
 	/* Huawei devices */
 	{DEVICE_HWI(0x03f0, 0x581d)},	/* HP lt4112 LTE/HSPA+ Gobi 4G Modem (Huawe=
i me906e) */
=20
+	/* Motorola devices */
+	{DEVICE_HWI(0x22b8, 0x2a70)},	/* Droid 4 mdm6600 */
+
 	{ }				/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, id_table);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0w08kACgkQMOfwapXb+vJpwQCfTiUS2K4a1CVoJwFu6/B1FtTc
z+kAnRGFucsG+uLBUmYmxdZiQpeyBTXZ
=SQkN
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
