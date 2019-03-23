Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED7BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51EB620880
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 16:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfCWQqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 12:46:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36798 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfCWQqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 12:46:52 -0400
Received: from c-73-130-187-69.hsd1.pa.comcast.net ([73.130.187.69] helo=[172.25.50.30])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <mike.salvatore@canonical.com>)
        id 1h7jnE-0002wn-Cq; Sat, 23 Mar 2019 16:46:48 +0000
From:   Mike Salvatore <mike.salvatore@canonical.com>
Subject: [PATCH] xpad.c: Send necessary control transfer to certain Xbox
 controllers
Openpgp: preference=signencrypt
Autocrypt: addr=mike.salvatore@canonical.com; keydata=
 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
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc:     ramzeto@gmail.com, marcus.folkesson@gmail.com,
        flibitijibibo@gmail.com, aicommander@gmail.com,
        leosperling97@gmail.com, gottox@voidlinux.eu, frtherien@gmail.com,
        linux-kernel@vger.kernel.org
Message-ID: <eff45453-f105-d713-1e77-a8fa9850c8fa@canonical.com>
Date:   Sat, 23 Mar 2019 12:46:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rYteyFdsY6vMC1PGbGITvEJgshPJ1niYl"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rYteyFdsY6vMC1PGbGITvEJgshPJ1niYl
Content-Type: multipart/mixed; boundary="06aaZUYQ70Bok69xtlnJ5I91mu9k25xx3";
 protected-headers="v1"
From: Mike Salvatore <mike.salvatore@canonical.com>
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: ramzeto@gmail.com, marcus.folkesson@gmail.com, flibitijibibo@gmail.com,
 aicommander@gmail.com, leosperling97@gmail.com, gottox@voidlinux.eu,
 frtherien@gmail.com, linux-kernel@vger.kernel.org
Message-ID: <eff45453-f105-d713-1e77-a8fa9850c8fa@canonical.com>
Subject: [PATCH] xpad.c: Send necessary control transfer to certain Xbox
 controllers

--06aaZUYQ70Bok69xtlnJ5I91mu9k25xx3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I recently purchased an Xbox controller with USB ID 045e:028e. When I plu=
gged
the device in, it was recognized as a joystick but button presses were no=
t
recognized. Using evtest, I confirmed that the device was not sending any=

information to the host when I pressed its buttons.

After doing some research, I found that this particular device requires t=
hat the
host send a control transfer before the device will begin sending any dat=
a to
the host. Below is a patch that introduces a mechanism into xpad.c for se=
nding
control transfers to specific Xbox controllers at initialization.

After applying this patch to the xpad module, the Xbox controller is prop=
erly
initialized when plugged in and functions as expected. Other Xbox control=
lers
may also require control transfers at initialization, but I don't know wh=
ich (if
any).

Regards,
Mike Salvatore


=46rom 3051524e62d68b920019bcb50a713e736fcf4234 Mon Sep 17 00:00:00 2001
From: Mike Salvatore <mike.salvatore@canonical.com>
Date: Wed, 13 Mar 2019 22:11:37 -0400
Subject: [PATCH] Input: xpad - send control init message to certain Xbox
 controllers

The Xbox controller with idVendor =3D=3D 0x045e and idProduct =3D=3D 0x02=
8e
requires that a specific control transfer be sent from the host to the
device before the device will send data to the host.

This patch introduces an xboxone_control_packet struct and a mechanism
for sending control packets to devices that require them at
initialization.

Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>
---
 drivers/input/joystick/xpad.c | 56 +++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.=
c
index cfc8b94527b9..f45522b9ff1f 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -460,6 +460,25 @@ struct xboxone_init_packet {
 		.len		=3D ARRAY_SIZE(_data),	\
 	}
=20
+struct xboxone_control_packet {
+	u16 idVendor;
+	u16 idProduct;
+	struct usb_ctrlrequest ctrlrequest;
+};
+
+#define XBOXONE_CONTROL_PKT(_vid, _pid, _reqtype, _req, _value, _index, =
_len)  \
+	{						\
+		.idVendor	=3D (_vid),		\
+		.idProduct	=3D (_pid),		\
+		.ctrlrequest    =3D {			\
+			.bRequestType	=3D (_reqtype),	\
+			.bRequest	=3D (_req),	\
+			.wValue		=3D (_value),	\
+			.wIndex		=3D (_index),	\
+			.wLength	=3D (_len),	\
+		},					\
+	}
+
=20
 /*
  * This packet is required for all Xbox One pads with 2015
@@ -537,6 +556,13 @@ static const struct xboxone_init_packet xboxone_init=
_packets[] =3D {
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumbleend_init),
 };
=20
+static const struct xboxone_control_packet xboxone_control_packets[] =3D=
 {
+	XBOXONE_CONTROL_PKT(0x045e, 0x028e,
+			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_INTERFACE,
+			USB_REQ_CLEAR_FEATURE,
+			USB_DEVICE_REMOTE_WAKEUP, 0, 0),
+};
+
 struct xpad_output_packet {
 	u8 data[XPAD_PKT_LEN];
 	u8 len;
@@ -1119,6 +1145,31 @@ static int xpad_init_output(struct usb_interface *=
intf, struct usb_xpad *xpad,
 	return error;
 }
=20
+static int xpad_init_control_msg(struct usb_xpad *xpad)
+{
+	struct usb_device *udev =3D xpad->udev;
+	size_t i;
+
+	for (i =3D 0; i < ARRAY_SIZE(xboxone_control_packets); i++) {
+		u16 idVendor =3D xboxone_control_packets[i].idVendor;
+		u16 idProduct =3D xboxone_control_packets[i].idProduct;
+
+		if (le16_to_cpu(udev->descriptor.idVendor) =3D=3D idVendor
+		    && le16_to_cpu(udev->descriptor.idProduct) =3D=3D idProduct) {
+			const struct usb_ctrlrequest *ctrlrequest =3D
+				&(xboxone_control_packets[i].ctrlrequest);
+
+			return usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
+				ctrlrequest->bRequest,
+				ctrlrequest->bRequestType, ctrlrequest->wValue,
+				ctrlrequest->wIndex, NULL, ctrlrequest->wLength,
+				2 * HZ);
+		}
+	}
+
+	return 0;
+}
+
 static void xpad_stop_output(struct usb_xpad *xpad)
 {
 	if (xpad->xtype !=3D XTYPE_UNKNOWN) {
@@ -1839,6 +1890,11 @@ static int xpad_probe(struct usb_interface *intf, =
const struct usb_device_id *id
 		if (error)
 			goto err_deinit_output;
 	}
+
+	error =3D xpad_init_control_msg(xpad);
+	if (error)
+		goto err_deinit_output;
+
 	return 0;
=20
 err_deinit_output:
--=20
2.17.1



--06aaZUYQ70Bok69xtlnJ5I91mu9k25xx3--

--rYteyFdsY6vMC1PGbGITvEJgshPJ1niYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEwZbe96kJeWh2OITRdyg1Qz0oXX0FAlyWYvUACgkQdyg1Qz0o
XX3mPw//UMR3Te0qEjP/PkyWowSYuM09YSgnsIN54mQ4/tkMH7I5tG9xSjYczZu7
CPGBbwHYm7CbrTq0mFGuPURzwAx7lYG9ImAPS8GZstwL6jJ+Xkptws+ZRtQwStYr
aAzh7X4u0s9YXKAYMKuIsiZmipAr9hUz5eUW6fImE0Gf5UZ5AhoaJXVmWoj+Es5r
ULQ2PlrouTtrL75DGAKgJsOZKlqOCPmWq6mCsLXG3ZzXEnlh0vQV6q+E24aMXEWl
fBUXp/Kvv+WiNIGiJqBWQVRxdLKaDjWQ3i/wVtch3r6mBWLl5uLc2+JsLJWVXbfU
Lt93e8CtFwv2cpOtHoTDUG2j+XXn58uKrX3UQ+ZlzyC/AUccjkU7Vf3QOOvK5mdS
XiIAIK+EWVcwLK3DOu4+X6H9lmcdgjexgV1qiwhfO9A/c/+VuuSbsiebOHfV0zS8
Hmxm7Cdm9VP01xyM+9rqnb5uRlDGiBvfiiBE6DVXmIp9ROk5XU7dBM5XqSZAYSc5
PUt1N2VqzL7LixYcs2UlMOr2ruE3JfLctHJ7QJPGsbQDzKngRaw7GWLPc6Q2PRza
kSnAUp3WwsJMUO6BgzqOOmuXICm+dFqd1OO/LWBgPH4UENvQ7Dov9/d86nJGt7vB
uasxrVBre5d7uKLNE5WAhd6WFBZVv1Yt98fgLZQdgBLKMUbehEU=
=9403
-----END PGP SIGNATURE-----

--rYteyFdsY6vMC1PGbGITvEJgshPJ1niYl--
