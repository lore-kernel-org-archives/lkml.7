Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DEDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264C72077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfDXN5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:57:23 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56334 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfDXN5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:57:22 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E51CF80432; Wed, 24 Apr 2019 15:57:11 +0200 (CEST)
Date:   Wed, 24 Apr 2019 15:57:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, dtor@google.com,
        linux@roeck-us.net
Subject: Re: [PATCH v4 20/26] leds: aat1290: Use generic support for
 composing LED names
Message-ID: <20190424135719.GC14360@amd>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-21-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-21-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Switch to using generic LED support for composing LED class
> device name.
>=20
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

> @@ -257,9 +257,6 @@ static int aat1290_led_parse_dt(struct aat1290_led *l=
ed,
>  		return -EINVAL;
>  	}
> =20
> -	led_cdev->name =3D of_get_property(child_node, "label", NULL) ? :
> -						child_node->name;
> -
>  	ret =3D of_property_read_u32(child_node, "led-max-microamp",
>  				&cfg->max_mm_current);
>  	/*
> @@ -469,6 +466,7 @@ static int aat1290_led_probe(struct platform_device *=
pdev)
>  	struct aat1290_led *led;
>  	struct led_classdev *led_cdev;
>  	struct led_classdev_flash *fled_cdev;
> +	struct led_init_data init_data =3D {};

You can do directly =3D { .devicename =3D ...; }, at least for the name.

Anyway, that's a detail.

8, 10, 12, 14, 16, 18, 20: Acked-by: Pavel Machek <pavel@ucw.cz>
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzAaz8ACgkQMOfwapXb+vKriQCcDwk6UeJr46HCVI+yRgKifC9c
4SQAnjIJmctKjqadfYavYRdvrDx2Llk9
=jlY7
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--
