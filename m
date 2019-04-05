Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA30EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B06421852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731413AbfDEPKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:10:39 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52541 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:10:39 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id DD47D60004;
        Fri,  5 Apr 2019 15:10:35 +0000 (UTC)
Date:   Fri, 5 Apr 2019 17:10:35 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 5/5] ARM: dts: sun50i: h6: Introduce Beelink GS1 board
Message-ID: <20190405151035.233r2pwabsf777ix@flea>
References: <20190405122446.2101-1-peron.clem@gmail.com>
 <20190405122446.2101-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zh3wncgztcqhaxzy"
Content-Disposition: inline
In-Reply-To: <20190405122446.2101-5-peron.clem@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zh3wncgztcqhaxzy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 02:24:46PM +0200, Cl=E9ment P=E9ron wrote:
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
> Changes in v2 (Thanks to Maxime Ripard):
>  - move MMC pinctrl to SOC dtsi
>  - add board to Sunxi YAML file
>  - add PIO/R_PIO regulators
>  - remove always_on from SDIO regulators
>
>
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   | 256 ++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.d=
ts
>
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documenta=
tion/devicetree/bindings/arm/sunxi.yaml
> index 11563d3f7c65..9ab9b266881d 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -136,6 +136,11 @@ properties:
>            - const: lemaker,bananapro
>            - const: allwinner,sun7i-a20
>
> +      - description: Beelink GS1
> +        items:
> +          - const: azw,beelink-gs1
> +          - const: allwinner,sun50i-h6
> +

Can you make that a separate patch?

Maxime


--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zh3wncgztcqhaxzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKdv6wAKCRDj7w1vZxhR
xVP3APsEyf4HBq3KxDxWMrXONlbBSDKNfZpLf/1RQEWpyY6NfAD/cILffRdU7sT8
aS8akdYHh2iCZRAcoxBCmwU7NSGhxgI=
=sq4w
-----END PGP SIGNATURE-----

--zh3wncgztcqhaxzy--
