Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3085C20645
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 12:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfDAMyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 08:54:23 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51889 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDAMyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 08:54:23 -0400
X-Originating-IP: 90.88.32.136
Received: from localhost (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BE07DFF814;
        Mon,  1 Apr 2019 12:54:18 +0000 (UTC)
Date:   Mon, 1 Apr 2019 14:54:18 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     megous@megous.com
Cc:     wens@csie.org, robh@kernel.org, johan@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 1/5] ARM: dts: sun8i: tbs-a711: Add node for BMA250
 accelerometer
Message-ID: <20190401125418.udh5dfid2rqzqxi4@flea>
References: <20190401115616.21337-1-megous@megous.com>
 <20190401115616.21337-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mc77lh6hyeikdfbm"
Content-Disposition: inline
In-Reply-To: <20190401115616.21337-2-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mc77lh6hyeikdfbm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Apr 01, 2019 at 01:56:12PM +0200, megous@megous.com wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> A711 tablet has BMA250 accelerometer connected to I2C1 bus. Enable
> both the I2C1 bus and add the accelerometer device to it.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> index 1e840ab5a541..d70fe04b66f0 100644
> --- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> +++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
> @@ -156,6 +156,19 @@
>  	status = "okay";
>  };
>
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	/* Accelerometer */
> +	accelerometer@18 {
> +		compatible = "bosch,bma250";
> +		reg = <0x18>;
> +		interrupt-parent = <&pio>;
> +		interrupts = <7 10 IRQ_TYPE_EDGE_RISING>; /* PH10 / EINT10 */
> +	};
> +};

I've dropped the comment, since it's pretty obvious now, and applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--mc77lh6hyeikdfbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKIJ+gAKCRDj7w1vZxhR
xZHLAP0eTwe+4AbgjHy+rohybyoUskCpRHkKo9sevo2OS+qm1QD/cZoyzB8a6RrU
UhOFhmrHX9n8CScjSa12JhRExdh3Dwk=
=BPwK
-----END PGP SIGNATURE-----

--mc77lh6hyeikdfbm--
