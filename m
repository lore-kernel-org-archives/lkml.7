Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7622C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850BD20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCHVGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:06:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50309 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCHVGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:06:51 -0500
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id A3360801B9; Fri,  8 Mar 2019 22:06:42 +0100 (CET)
Date:   Fri, 8 Mar 2019 22:06:49 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com, tony@atomide.com,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: dts: omap4-droid4: Update backlight dt
 properties
Message-ID: <20190308210649.GC17626@amd>
References: <20190307220947.20057-1-dmurphy@ti.com>
 <20190307220947.20057-2-dmurphy@ti.com>
 <20190308151422.GA10378@amd>
 <6d9a5821-a634-8ea2-4fe3-0603af757668@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="i7F3eY7HS/tUJxUd"
Content-Disposition: inline
In-Reply-To: <6d9a5821-a634-8ea2-4fe3-0603af757668@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i7F3eY7HS/tUJxUd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> +		led@1 {
> >> +			reg =3D <1>;
> >> +			led-sources =3D <1>;
> >> +			ti,led-mode =3D <LM3532_BL_MODE_MANUAL>;
> >> +			label =3D "keypad";
> >=20
> > I guess best variant would be inputX::backlight here, but that might
> > be tricky to implement.
> >=20
>=20
> Yeah because we don't know what input the keyboard would be on.
> Unless there are APIs to retrieve that info.  I have not looked at the in=
put
> framework in a while.

Lets just make it "platform::kbd_backlight". *:kbd_backlight is
already used by quite a few drivers.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--i7F3eY7HS/tUJxUd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyC2WkACgkQMOfwapXb+vJx0ACfZz5PHKgNv4bvOLr/u/p353w6
FxQAoIVoAFfzvlfc9ajebJ+3+YA2gzz6
=hkmh
-----END PGP SIGNATURE-----

--i7F3eY7HS/tUJxUd--
