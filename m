Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3A0C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D871420883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfDHKKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:10:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33790 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDHKKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:10:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F406C8018C; Mon,  8 Apr 2019 12:10:28 +0200 (CEST)
Date:   Mon, 8 Apr 2019 12:10:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, jacek.anaszewski@gmail.com,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: leds: Add LED bindings for the LM36274
Message-ID: <20190408101039.GC30958@amd>
References: <20190405145540.27703-1-dmurphy@ti.com>
 <20190405145540.27703-6-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Content-Disposition: inline
In-Reply-To: <20190405145540.27703-6-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fig2xvG2VGoz8o/s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-04-05 09:55:39, Dan Murphy wrote:
> Add the LM36274 LED specific bindings.
>=20
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/leds/leds-lm36274.txt | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm36274.t=
xt
>=20
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm36274.txt b/Do=
cumentation/devicetree/bindings/leds/leds-lm36274.txt
> new file mode 100644
> index 000000000000..359990d85b28
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-lm36274.txt
> @@ -0,0 +1,82 @@
> +* Texas Instruments LM36274 4-Channel LCD Backlight Driver w/Integrated =
Bias
> +
> +The LM36274 is an integrated four-channel WLED driver and LCD bias suppl=
y.
> +The backlight boost provides the power to bias four parallel LED strings=
 with
> +up to 29-V total output voltage. The 11-bit LED current is rogrammable v=
ia

29V

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyrHh8ACgkQMOfwapXb+vItWQCbBx2RPdPw60W1yLJxHH47DSW5
W1sAniGLQF1mjllOFEkUE/rvSou1fL5A
=pXGZ
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--
