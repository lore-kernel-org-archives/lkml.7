Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA6DC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AE22063F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfFQNMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:12:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46150 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfFQNMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:12:23 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id DEE2880264; Mon, 17 Jun 2019 15:12:10 +0200 (CEST)
Date:   Mon, 17 Jun 2019 15:12:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt: leds-lm36274.txt: fix a broken reference to
 ti-lmu.txt
Message-ID: <20190617131220.GD21113@amd>
References: <79b9bf3388eb231da77c6a804862d21339262d0a.1560421387.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <79b9bf3388eb231da77c6a804862d21339262d0a.1560421387.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-06-13 07:23:15, Mauro Carvalho Chehab wrote:
> There's a typo there:
> 	ti_lmu.txt -> ti-lmu.txt
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>


> @@ -6,7 +6,7 @@ up to 29V total output voltage. The 11-bit LED current is=
 programmable via
>  the I2C bus and/or controlled via a logic level PWM input from 60 uA to =
30 mA.
> =20
>  Parent device properties are documented in
> -Documentation/devicetree/bindings/mfd/ti_lmu.txt
> +Documentation/devicetree/bindings/mfd/ti-lmu.txt
> =20
>  Regulator properties are documented in
>  Documentation/devicetree/bindings/regulator/lm363x-regulator.txt

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0HkbQACgkQMOfwapXb+vIH5QCeKqYE0VNO+USbEO+mn6G8rRvD
4oYAoKoX8mQcIqKy3vs9fYFn8oXLd3Kh
=pLB1
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
