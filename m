Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E5C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9B12077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 07:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfHPHwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 03:52:17 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:60601 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfHPHwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 03:52:16 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 61A9610000A;
        Fri, 16 Aug 2019 07:52:12 +0000 (UTC)
Date:   Fri, 16 Aug 2019 09:52:11 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Bhushan Shah <bshah@kde.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Wolfram Sang <wsa@the-dreams.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: allwinner: h6: add i2c0 node in PineH64
Message-ID: <20190816075211.xaq54q2cdniwjpp3@flea>
References: <20190811090503.32396-1-bshah@kde.org>
 <20190816064710.18280-1-bshah@kde.org>
 <20190816064710.18280-4-bshah@kde.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ft24qo4b5lbfpatv"
Content-Disposition: inline
In-Reply-To: <20190816064710.18280-4-bshah@kde.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ft24qo4b5lbfpatv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

65;5603;1c
On Fri, Aug 16, 2019 at 12:17:10PM +0530, Bhushan Shah wrote:
> i2c0 bus is exposed by PI-2 BUS in the PineH64, model B.
>
> Signed-off-by: Bhushan Shah <bshah@kde.org>
> ---
> Changes in v2:
>   - Don't enable the i2c0 node in PineH64 by default
>
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index 684d1daa3081..97d9b7c63fb3 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -160,6 +160,15 @@
>  	vcc-pg-supply = <&reg_aldo1>;
>  };
>
> +/* This i2c interface is exposed on PI-2 BUS, Pin 3 (I2C_SDA) and 5 (I2C_SCL) */
> +&i2c0 {
> +	status = "disabled";
> +};

This property is set to disabled in the DTSI already

> +&i2c0_pins {
> +	bias-pull-up;
> +};
> +

And this should be in the same overlay than the one that sets status
to okay.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ft24qo4b5lbfpatv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXVZgqwAKCRDj7w1vZxhR
xRnpAQCA1Dnh07ZLw+W8kJWaeBmCKi6OoeBA81ASauE2EwWjfAEApDyrf66lZnxn
8aFeeQ7tNBJFyO0BUDMs+ClRbnuPawQ=
=EKXH
-----END PGP SIGNATURE-----

--ft24qo4b5lbfpatv--
