Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E338CC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 10:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6D2206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 10:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLZKGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 05:06:34 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:39632 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfLZKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 05:06:33 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8E90B1C210C; Thu, 26 Dec 2019 11:06:31 +0100 (CET)
Date:   Thu, 26 Dec 2019 11:06:15 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt: bindings: lm3692x: Add ti,ovp-microvolt
 property
Message-ID: <20191226100615.GA4033@amd>
References: <cover.1577271823.git.agx@sigxcpu.org>
 <f45e30f43b7d20ac14f93309a006249fdb351ddd.1577271823.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <f45e30f43b7d20ac14f93309a006249fdb351ddd.1577271823.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-12-25 12:07:14, Guido G=FCnther wrote:
> This allows to set the overvoltage protection to 17V, 21V, 25V or 29V.
>=20
> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>

Acked-by: Pavel	 Machek <pavel@ucw.cz>

I will need Rob's Ack.

> @@ -44,6 +48,7 @@ led-controller@36 {
> =20
>  	enable-gpios =3D <&gpio1 28 GPIO_ACTIVE_HIGH>;
>  	vled-supply =3D <&vbatt>;
> +	ti,ovp-microvolt =3D <25000000>;

Wed often put the default values here.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4EhhcACgkQMOfwapXb+vJsAwCgruBMn7DOlWKbRe/PcY241dgI
jJIAoKK3ncKtpZAz/qVtM8gCbnskiJA/
=WcCT
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
