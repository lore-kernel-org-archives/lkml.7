Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0CA20879
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 06:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbfDAGax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 02:30:53 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:60233 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDAGax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 02:30:53 -0400
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E3099240002;
        Mon,  1 Apr 2019 06:30:49 +0000 (UTC)
Date:   Mon, 1 Apr 2019 08:30:49 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     wens@csie.org, robh@kernel.org, johan@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/7] ARM: dts: sun8i: tbs-a711: Add node for BMA250
 accelerometer
Message-ID: <20190401063049.h2as3qllpelkxkbb@flea>
References: <20190327001843.2420-1-megous@megous.com>
 <20190327001843.2420-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fnpf52jkmyyf4nzn"
Content-Disposition: inline
In-Reply-To: <20190327001843.2420-3-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fnpf52jkmyyf4nzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Mar 27, 2019 at 01:18:38AM +0100, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> A711 tablet has BMA250 accelerometer connected to I2C1 bus. Enable
> both the I2C1 bus and add the accelerometer device to it.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> index 6aae70c89a1e..347fc0c31fa4 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -156,6 +156,21 @@
>  	status = "okay";
>  };
>
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;

It's there already

> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Accelerometer */
> +	bma250@18 {

The node name should be the class of the device, not its model, so
something like accelerometer.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fnpf52jkmyyf4nzn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKGwAwAKCRDj7w1vZxhR
xQveAQC8OUeLN0o//lp3b2Pvv9ePXMdeMlm0Iipabo3Q4eV9CQEA/nsWOP6bl21j
VdAn5ByJuEA+oaUpCbSydDKa6PeJKgw=
=5Ks7
-----END PGP SIGNATURE-----

--fnpf52jkmyyf4nzn--
