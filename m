Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D1AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B7520870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDHKmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:42:05 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:47509 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfDHKmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:42:03 -0400
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id C491B100010;
        Mon,  8 Apr 2019 10:41:57 +0000 (UTC)
Date:   Mon, 8 Apr 2019 12:41:57 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/6] arm64: dts: allwinner: h6: move MMC pinctrl to
 dtsi
Message-ID: <20190408104157.tdxg2al3fpanhqqu@flea>
References: <20190408092619.23152-1-peron.clem@gmail.com>
 <20190408092619.23152-2-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z3higc46mou4if3b"
Content-Disposition: inline
In-Reply-To: <20190408092619.23152-2-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z3higc46mou4if3b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 11:26:14AM +0200, Cl=E9ment P=E9ron wrote:
> There is only one pinmuxing available for each MMC controller.
>
> Move the pinctrl to the SOC
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 2 --
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts  | 4 ----
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi          | 4 ++++
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch=
/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> index b2526dac2fcf..62e27948a3fa 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
> @@ -56,8 +56,6 @@
>  };
>
>  &mmc0 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&mmc0_pins>;
>  	vmmc-supply =3D <&reg_cldo1>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
>  	bus-width =3D <4>;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/=
arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index bdb8470fc8dc..4802902e128f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -104,8 +104,6 @@
>  };
>
>  &mmc0 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&mmc0_pins>;
>  	vmmc-supply =3D <&reg_cldo1>;
>  	cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>;
>  	bus-width =3D <4>;
> @@ -113,8 +111,6 @@
>  };
>
>  &mmc2 {
> -	pinctrl-names =3D "default";
> -	pinctrl-0 =3D <&mmc2_pins>;
>  	vmmc-supply =3D <&reg_cldo1>;
>  	vqmmc-supply =3D <&reg_bldo2>;
>  	non-removable;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index 3e4bb0b0de69..006d3b6418af 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -278,6 +278,8 @@
>  			resets =3D <&ccu RST_BUS_MMC0>;
>  			reset-names =3D "ahb";
>  			interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +		        pinctrl-names =3D "default";

This is indented with spaces and not tabulations. This error is
reported by checkpatch.

> +			pinctrl-0 =3D <&mmc0_pins>;
>  			status =3D "disabled";
>  			#address-cells =3D <1>;
>  			#size-cells =3D <0>;
> @@ -306,6 +308,8 @@
>  			resets =3D <&ccu RST_BUS_MMC2>;
>  			reset-names =3D "ahb";
>  			interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names =3D "default";
> +			pinctrl-0 =3D <&mmc0_pins>;

I guess you meant mmc2?

Can you test your patches before sending them please?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--z3higc46mou4if3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKsldQAKCRDj7w1vZxhR
xXGnAP99TBRvSJ0rpD/2Yfgh6WXHm7ypxBGhdz34nxuZCeghpAEAiRChgRYD5zk3
uXjFTbssB+DHZmn119gguJEO9itM1QA=
=fgYB
-----END PGP SIGNATURE-----

--z3higc46mou4if3b--
