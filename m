Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF4DC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7518F21721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570445832;
	bh=AALnra5vbHx8f6yVsAevgDkTKmsX71cNwxA0cJMD1fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mXUuukNWiW3tI4zumAdEYltmQf333so+k2ADp4fp/RLIvkeZaL6wV9fMi7Ll1TRBD
	 2sFRCUPVLcUrh3QdaHqkhsiUyyp9fb9m7oCo81xUOb8z0Qf4M5bmL/9xm9aCpnN+O8
	 nT3dT0z0RCaBaiiUo7CHjRGiYC2YHYDU3aFeQ72Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfJGK5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbfJGK5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:57:11 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FDA920867;
        Mon,  7 Oct 2019 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570445831;
        bh=AALnra5vbHx8f6yVsAevgDkTKmsX71cNwxA0cJMD1fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=siVCpq8WhOMrMwv7Gq+RexhGWPE/5wuuGZWmusjEN1rInKUhFBqtR2ooxS0Y0Nlb6
         OsD+i0bGLfartsntJWJCcZ38q986Pk+QWMc06kAoZIZt3vSU27Q+gw45clMkjUYML7
         bWZC55o4/yOiqE8DRn51u/ZfkN2rM+zA/Idc2DfE=
Date:   Mon, 7 Oct 2019 12:57:08 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v10 5/6] arm64: dts: allwinner: a64: Add MIPI DSI pipeline
Message-ID: <20191007105708.raxavxk4n7bvxh7x@gilmour>
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
 <20191005141913.22020-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="msd5tjzsj4hwrcaz"
Content-Disposition: inline
In-Reply-To: <20191005141913.22020-6-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--msd5tjzsj4hwrcaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 05, 2019 at 07:49:12PM +0530, Jagan Teki wrote:
> Add MIPI DSI pipeline for Allwinner A64.
>
> - dsi node, with A64 compatible since it doesn't support
>   DSI_SCLK gating unlike A33
> - dphy node, with A64 compatible with A33 fallback since
>   DPHY on A64 and A33 is similar
> - finally, attach the dsi_in to tcon0 for complete MIPI DSI
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 69128a6dfc46..ad4170b8aee0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -382,6 +382,12 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  					reg = <1>;
> +
> +					tcon0_out_dsi: endpoint@1 {
> +						reg = <1>;
> +						remote-endpoint = <&dsi_in_tcon0>;
> +						allwinner,tcon-channel = <1>;
> +					};
>  				};
>  			};
>  		};
> @@ -1003,6 +1009,38 @@
>  			status = "disabled";
>  		};
>
> +		dsi: dsi@1ca0000 {
> +			compatible = "allwinner,sun50i-a64-mipi-dsi";
> +			reg = <0x01ca0000 0x1000>;
> +			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_MIPI_DSI>;
> +			clock-names = "bus";

This won't validate with the bindings you have either here, since it
still expects bus and mod.

I guess in that cas, we can just drop clock-names, which will require
a bit of work on the driver side as well.

Maxime

--msd5tjzsj4hwrcaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXZsaBAAKCRDj7w1vZxhR
xXn6AQCt+htvtym5wdP+F2AnazteXITvMk5Rfl6c9YFMfW0GswD+MILpcTLFvoCd
opCA2BNbbbbCbvP1aXhnkHjZupGsbg4=
=Qm2A
-----END PGP SIGNATURE-----

--msd5tjzsj4hwrcaz--
