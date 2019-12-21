Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8723AC2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 19:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4AB206D3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 19:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfLUTPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:15:18 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:42042 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfLUTPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 14:15:18 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5C9751C24DF; Sat, 21 Dec 2019 20:15:16 +0100 (CET)
Date:   Sat, 21 Dec 2019 20:15:15 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt: bindings: lm3692x: Document new properties
Message-ID: <20191221191515.GF32732@amd>
References: <cover.1576499103.git.agx@sigxcpu.org>
 <35a23315938909c80e7772838e1de0d2d46302f2.1576499103.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
In-Reply-To: <35a23315938909c80e7772838e1de0d2d46302f2.1576499103.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-12-16 13:28:05, Guido G=FCnther wrote:
> We allow configuration of brightness mode and over voltage
> protection.
>=20
> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> @@ -18,6 +18,10 @@ Required properties:
>  Optional properties:
>  	- enable-gpios : gpio pin to enable/disable the device.
>  	- vled-supply : LED supply
> +	- ti,brightness-mapping-exponential: Whether to use exponential
> +	    brightness mapping
> +	- ti,overvoltage-volts: Overvoltage protection in Volts, can
> +	    be 0 (unprotected), 21, 25 or 29V
> =20

We usually use microvolts in various device tree properties...

Exponential mapping s not really property of the hardware, is it? Does
it belong here or somewhere in the backlight binding?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3+b0MACgkQMOfwapXb+vKP5gCfW7lmZrPM2RwqiUQvlaxI8MeP
0NkAoLH84rBzrjKgFcLJK9HmlR9F1R0e
=EmGh
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
