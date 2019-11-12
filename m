Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E510C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB87521A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 12:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573560144;
	bh=Yg2XoR2AQ2Dyq+/wLccnV918OcIcs8U+HHKtW2NtsuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D3W5rBUlNmJaEYszfFz07Qlb2T+wW6A4DfoyJPPn9jXK9e2vDqG7rS2a5YDtJcSZx
	 sBNiGK9n2ZPwrqAerGMA0P++ZLjMGb7og8zQ0A2Omkc1u8mUaOD9l5yJ2ylbgac0g8
	 /Kf9BOwPTtxZwSrXPZ7T+vAcE0I2p0EGrNgswGxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfKLMCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfKLMCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:02:23 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66A7D2084E;
        Tue, 12 Nov 2019 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573560142;
        bh=Yg2XoR2AQ2Dyq+/wLccnV918OcIcs8U+HHKtW2NtsuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y1lXsl/2SYZExjnI3bCn60A/vEVh5Q8AgmPiN3D5HpkHicJZiNZ8DZaBhEwR7XOT2
         uNJU6DYWLgJRPqIECNi7BDx2OScrnaUp9adyY7rtxal0CxODze+7iHK0AYidXGjE1A
         IuIxihpjR+DCaJM5NDBypIR5ePrLbjfUim4mT6Sg=
Date:   Tue, 12 Nov 2019 13:02:19 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 1/2] ARM64: dts: sun50i-h6-pine-h64: state that the DT
 supports the modelA
Message-ID: <20191112120219.GX4345@gilmour.lan>
References: <1573316433-40669-1-git-send-email-clabbe@baylibre.com>
 <1573316433-40669-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MhP8cYafZlTESjGT"
Content-Disposition: inline
In-Reply-To: <1573316433-40669-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MhP8cYafZlTESjGT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Nov 09, 2019 at 04:20:32PM +0000, Corentin Labbe wrote:
> The current sun50i-h6-pine-h64 DT does not specify which model (A or B)
> it supports.
> When this file was created, only modelA was existing, but now both model
> exists and with the time, this DT drifted to support the model B since it is
> the most common one.
> Furtheremore, some part of the model A does not work with it like ethernet and
> HDMI connector (as confirmed by Jernej on IRC).
>
> So it is time to settle the issue, and the easiest way was to state that
> this DT is for model B.
> Easiest since only a small name changes is required.
> Doing the opposite (stating this file is for model A) will add changes (for
> ethernet and HDMI) and so, will break too many setup.
>
> But as asked by the maintainer this patch state this file is for model A.
> In the process this patch adds the missing compoments to made it work on
> model A.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../devicetree/bindings/arm/sunxi.yaml        |  4 ++--
>  .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 19 +++++++++++++++----
>  2 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
> index 8a1e38a1d7ab..b8ec616c2538 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -599,9 +599,9 @@ properties:
>            - const: pine64,pine64-plus
>            - const: allwinner,sun50i-a64
>
> -      - description: Pine64 PineH64
> +      - description: Pine64 PineH64 model A
>          items:
> -          - const: pine64,pine-h64
> +          - const: pine64,pine-h64-modelA

You can change the description to make it more obvious if you want to,
but changing the compatible is a no-go.

>            - const: allwinner,sun50i-h6
>
>        - description: Pine64 LTS
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index 74899ede00fb..1d9afde4d3d7 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -10,8 +10,8 @@
>  #include <dt-bindings/gpio/gpio.h>
>
>  / {
> -	model = "Pine H64";
> -	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
> +	model = "Pine H64 model A";
> +	compatible = "pine64,pine-h64-modelA", "allwinner,sun50i-h6";

Same thing here, changing the model is fine, the compatible isn't

>  	aliases {
>  		ethernet0 = &emac;
> @@ -22,9 +22,10 @@
>  		stdout-path = "serial0:115200n8";
>  	};
>
> -	connector {
> +	hdmi_connector: connector {

Why do you need to add the label?

Thanks!
Maxime

--MhP8cYafZlTESjGT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcqfSwAKCRDj7w1vZxhR
xbtVAQCjK/Nue5ofSHTF+N2UYD2oQHh9eCSQaNnpwH0L9zEvIgEAn9sTMRVhOQZp
PbvVGTIVHfDgrpeI3lrH/v6mZmKcbAI=
=1SAq
-----END PGP SIGNATURE-----

--MhP8cYafZlTESjGT--
