Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B683C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2210C21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 20:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfGEUYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:24:35 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37503 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfGEUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 16:24:35 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 977D980594; Fri,  5 Jul 2019 22:24:22 +0200 (CEST)
Date:   Fri, 5 Jul 2019 22:24:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc:     jacek.anaszewski@gmail.com, dmurphy@ti.com,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        tomi.valkeinen@ti.com
Subject: Re: [PATCH 2/2] leds: tlc591xx: Use the OF version of the LED
 registration function
Message-ID: <20190705202433.GB5445@amd>
References: <20190701152602.31716-1-jjhiblot@ti.com>
 <20190701152602.31716-3-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20190701152602.31716-3-jjhiblot@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-07-01 17:26:02, Jean-Jacques Hiblot wrote:
> The driver parses the device-tree to identify which LED should be handled.
> Since the information about the device node is known at this time, we can
> provide the LED core with it. It may be useful later.
>=20
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -207,7 +207,7 @@ tlc591xx_probe(struct i2c_client *client,
>  		led->led_no =3D idx++;
>  		led->ldev.brightness_set_blocking =3D tlc591xx_brightness_set;
>  		led->ldev.max_brightness =3D LED_FULL;
> -		err =3D devm_led_classdev_register(dev, &led->ldev);
> +		err =3D devm_of_led_classdev_register(dev, child, &led->ldev);
>  		if (err < 0) {
>  			dev_err(dev, "couldn't register LED %s\n",
>  				led->ldev.name);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0fsgEACgkQMOfwapXb+vKPnQCfUiBHIn7co+XTi2pYp86P5jQJ
Q34AoKL08ZM/9tjJFzZAXpHW0GjTfrB5
=URtF
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
