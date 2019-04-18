Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1F5C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9962214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 11:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbfDRLYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 07:24:49 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:34825 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRLYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 07:24:49 -0400
X-Originating-IP: 90.88.160.238
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 25D914000B;
        Thu, 18 Apr 2019 11:24:45 +0000 (UTC)
Date:   Thu, 18 Apr 2019 13:24:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 2/2] arm64: dts: allwinner: a64-oceanic-5205-5inmfd:
 Enable GT911 CTP
Message-ID: <20190418112445.wlom3pisnwmddlnr@flea>
References: <20190418083543.11695-1-jagan@amarulasolutions.com>
 <20190418083543.11695-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ydku54e2qlyhouka"
Content-Disposition: inline
In-Reply-To: <20190418083543.11695-2-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ydku54e2qlyhouka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2019 at 02:05:43PM +0530, Jagan Teki wrote:
> Goodix GT911 CTP is bound with Oceanic 5205 5inMFD board.
>
> The CTP connected to board with,
> - SDA, SCK from i2c0
> - GPIO-LD0 as AVDD28 supply
> - PH4 gpio as interrupt pin
> - PH11 gpio as reset pin
> - X axis is inverted
> - Y axis is inverted
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - drop i2c1, bias-pull-up
>
>  .../sun50i-a64-oceanic-5205-5inmfd.dts        | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> index 6a2154525d1e..02c1a04cc7eb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
> @@ -37,6 +37,24 @@
>  	status = "okay";
>  };
>
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;

The comments on PATCH 1 apply here as well.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ydku54e2qlyhouka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLhefQAKCRDj7w1vZxhR
xWPaAQCD5smtLgqsihoZx6uOeqUyKtycUPc+rF3zT080U/t13QEA3Ecl/2Umk+WE
LHJ2JpBbkRtMVZI9x98AazdkFo9e6A0=
=K7xJ
-----END PGP SIGNATURE-----

--ydku54e2qlyhouka--
