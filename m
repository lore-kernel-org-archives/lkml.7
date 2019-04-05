Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D4CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE2C217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfDEJIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:08:40 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:40493 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfDEJIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:08:39 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 24587100002;
        Fri,  5 Apr 2019 09:08:36 +0000 (UTC)
Date:   Fri, 5 Apr 2019 11:08:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: sun50i: h6: Introduce Beelink GS1 board
Message-ID: <20190405090836.cyz2eabxpqjgesig@flea>
References: <20190404124504.11137-1-peron.clem@gmail.com>
 <20190404124504.11137-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6yy35wrlg3teogrf"
Content-Disposition: inline
In-Reply-To: <20190404124504.11137-2-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6yy35wrlg3teogrf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 04, 2019 at 02:45:04PM +0200, Cl=E9ment P=E9ron wrote:
> Beelink GS1 is an Allwinner H6 based TV box,
> which support:
> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
> - GPU Mali-T720
> - 2GB LPDDR3 RAM
> - AXP805 PMIC
> - 1Gbps GMAC via RTL8211E
> - FN-Link 6222B-SRB Wifi/BT
> - 1x USB 2.0 Host and 1x USB 3.0 Host
> - HDMI port
> - S/PDIF Tx
> - IR receiver
> - 5V/2A DC power supply
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>
> Thanks to Jagan and Icenowy, most of this devicetree is taken from their =
works on
> the OrangePi One Plus and Pine H64.
>
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 252 ++++++++++++++++++
>  2 files changed, 253 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.d=
ts
>
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index e4dce2f6fa3a..2dd806a3d5c9 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-pc2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-prime.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h5-orangepi-zero-plus2.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-beelink-gs1.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-lite2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> new file mode 100644
> index 000000000000..d927e7d33bf3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -0,0 +1,252 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2019 Cl=E9ment P=E9ron <peron.clem@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h6.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model =3D "Beelink GS1";
> +	compatible =3D "azw,beelink-gs1", "allwinner,sun50i-h6";

Please add that board to
Documentation/devicetree/bindings/arm/sunxi.yaml, it's new and in
linux-next.

> +&mmc0 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc0_pins>;
> +	vmmc-supply =3D <&reg_cldo1>;
> +	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
> +	bus-width =3D <4>;
> +	status =3D "okay";
> +};
> +
> +&mmc2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mmc2_pins>;

If those (mmc0 and mmc2_pins) are the only muxing options as their
names suggests, it should be set in the DTSI.

If not, the name of the pin group should be changed.

> +			reg_cldo2: cldo2 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc-wifi-1";
> +			};
> +
> +			reg_cldo3: cldo3 {
> +				regulator-always-on;
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-name =3D "vcc-wifi-2";
> +			};

I don't see any SDIO bus declared, why do you need those regulators on?

Can you also declare the PIO regulators?

Thanks!
Maxmie

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6yy35wrlg3teogrf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKcbFAAKCRDj7w1vZxhR
xUWRAQDMdLGDuUZ7lVOmzhAdMIIdH16CRE63HKc/jJml0U0W9QEA6CdLF9RgAEbw
uyi6nnpeKJthCHYeLGifRcIUYTqpiQM=
=PhuJ
-----END PGP SIGNATURE-----

--6yy35wrlg3teogrf--
