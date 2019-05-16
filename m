Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E5CC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494DB20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfEPIy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:54:27 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42753 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfEPIy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:54:26 -0400
X-Originating-IP: 80.215.246.107
Received: from localhost (unknown [80.215.246.107])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D086CFF807;
        Thu, 16 May 2019 08:54:17 +0000 (UTC)
Date:   Thu, 16 May 2019 10:54:16 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Harald Geyer <harald@ccbib.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: DTS: allwinner: a64: Add pinmux for RGB666 LCD
Message-ID: <20190516085416.qfrbylku7226rub6@flea>
References: <20190514155911.6C0AC68B05@newverein.lst.de>
 <20190514160225.AB0D368B20@newverein.lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h2fn4argqt45zmoa"
Content-Disposition: inline
In-Reply-To: <20190514160225.AB0D368B20@newverein.lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h2fn4argqt45zmoa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2019 at 06:02:25PM +0200, Torsten Duwe wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
>
> Allwinner A64's TCON0 can output RGB666 LCD signal.
>
> Add its pinmux.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>
> originally: patchwork.kernel.org/patch/10814179
>
> Almost trivial, and obviously correct.
> I added the /omit-if-no-ref/.
>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 2abb335145a6..a8bbee84e7da 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -559,6 +559,16 @@
>  				function = "i2c1";
>  			};
>
> +			/omit-if-no-ref/
> +			lcd_rgb666_pins: lcd-rgb666 {

This should have the -pins suffix

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--h2fn4argqt45zmoa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN0lOAAKCRDj7w1vZxhR
xfczAP949KD6LxwvBpLAV424mzw9jhUzLgBNJAOIYxQ1QQ2afAEAqHyh7A4+J2EV
4OxzrWJXa/IL7TiTlQCvFyhQrynH+AI=
=R8dD
-----END PGP SIGNATURE-----

--h2fn4argqt45zmoa--
