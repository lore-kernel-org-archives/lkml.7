Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFCCC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550C6217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfDEPIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:08:49 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56095 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:08:49 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A4C071C001C;
        Fri,  5 Apr 2019 15:08:46 +0000 (UTC)
Date:   Fri, 5 Apr 2019 17:08:46 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 1/5] arm64: allwinner: h6: orangepi: Add PIO regulators
Message-ID: <20190405150846.nurg6h4ykwtiib2v@flea>
References: <20190405122446.2101-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24vqx5wgiqrte236"
Content-Disposition: inline
In-Reply-To: <20190405122446.2101-1-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24vqx5wgiqrte236
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 02:24:42PM +0200, Cl=E9ment P=E9ron wrote:
> OrangePi One Plus and OrangePi Lite2 use the same PIO regulators.
>
> Add this in the common device tree.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> index b2526dac2fcf..fd2af5095425 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> @@ -72,6 +72,12 @@
>  	status =3D "okay";
>  };
>
> +&pio {
> +        vcc-pc-supply =3D <&reg_bldo2>;
> +        vcc-pd-supply =3D <&reg_cldo1>;
> +        vcc-pg-supply =3D <&reg_bldo3>;
> +};
> +
>  &r_i2c {
>  	status =3D "okay";
>
> @@ -191,6 +197,11 @@
>  	};
>  };
>
> +&r_pio {
> +        vcc-pl-supply =3D <&reg_aldo1>;
> +        vcc-pm-supply =3D <&reg_bldo3>;
> +};
> +

How was this tested?

Please run checkpatch on your patches as well.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--24vqx5wgiqrte236
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKdvfgAKCRDj7w1vZxhR
xU+WAP9gEYEPbCHJ23PZYj4W9VgUad9XxyRWrzWzEq/E4K0EbAD9G5gRann7GsLc
gpQklzZ4VKGCEvR4FGJEiqil6dU/ggI=
=PqoA
-----END PGP SIGNATURE-----

--24vqx5wgiqrte236--
