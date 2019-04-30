Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3EBC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0825C2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfD3WBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:01:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54036 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3WBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:01:43 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EC4B0805C8; Wed,  1 May 2019 00:01:31 +0200 (CEST)
Date:   Wed, 1 May 2019 00:01:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/7] dt-bindings: mfd: LMU: Add the ramp up/down
 property
Message-ID: <20190430220140.GB20410@amd>
References: <20190430191730.19450-1-dmurphy@ti.com>
 <20190430191730.19450-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <20190430191730.19450-3-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2019-04-30 14:17:25, Dan Murphy wrote:
> Document the ramp-up and ramp-down property in the binding.
> Removing the "sec" from the property definition as seconds is
> implied.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>=20
> v3 - No changes added Reviewed-by Rob - https://lore.kernel.org/patchwork=
/patch/1058759/
>=20
> v2 - Fixed commit message as this was not just a modification but adding =
documentation
> https://lore.kernel.org/patchwork/patch/1054504/
>=20
>  .../devicetree/bindings/mfd/ti-lmu.txt        | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documenta=
tion/devicetree/bindings/mfd/ti-lmu.txt
> index 86ca786d54fc..adae96c79d39 100644
> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
> @@ -25,6 +25,12 @@ Required properties:
> =20
>  Optional property:

"properties".

>    - enable-gpios: A GPIO specifier for hardware enable pin.
> +  - ramp-up-ms: Current ramping from one brightness level to
> +		the a higher brightness level.
> +		Range from 2048 us - 117.44 s
> +  - ramp-down-ms: Current ramping from one brightness level to
> +		  the a lower brightness level.
> +		  Range from 2048 us - 117.44 s

Can you use ramp-up/down-us for consistency?
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzIxcQACgkQMOfwapXb+vLjgACeO8SZMcC4CDbleReMYezQzviv
oxMAn14WNibbphqzbhklGMSoP6xbRuJh
=+zr9
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
