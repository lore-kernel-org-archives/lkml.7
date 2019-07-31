Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB7C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0417C2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="fu0cH4+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfGaI3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:29:25 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46412 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfGaI3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:29:24 -0400
Received: from pendragon.ideasonboard.com (unknown [38.98.37.141])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 36743CC;
        Wed, 31 Jul 2019 10:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1564561762;
        bh=39Gd4WSZywKOAPb3q5uRQnsUP9o8VKzDKaJGcnx+P10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fu0cH4+Pzgaq4PcZ02PFK23hKE1wQCN2Ohcmfdk6m2zZ1wQqPfru0d1Ed4qNTsW2D
         Y1qrjH9kg0K6Q4i5WdOy2wezfFXR35vcvStJRpMp2FHJ9DYaCWhPcs1/xKIld6vxfw
         wjmw76hiSnXxETESRbjYFPekO4FewAqJ4VdZHEIA=
Date:   Wed, 31 Jul 2019 11:29:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Bogdan Togorean <bogdan.togorean@analog.com>
Cc:     dri-devel@lists.freedesktop.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, a.hajda@samsung.com, sam@ravnborg.org,
        gregkh@linuxfoundation.org, allison@lohutok.net,
        tglx@linutronix.de, matt.redfearn@thinci.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: drm: bridge: adv7511: Add ADV7535
 support
Message-ID: <20190731082908.GB5080@pendragon.ideasonboard.com>
References: <20190730131736.30187-1-bogdan.togorean@analog.com>
 <20190730131736.30187-2-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190730131736.30187-2-bogdan.togorean@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bogdan,

Thank you for the patch.

On Tue, Jul 30, 2019 at 04:17:35PM +0300, Bogdan Togorean wrote:
> ADV7535 is a part compatible with ADV7533 but it supports 1080p@60hz and
> v1p2 supply is fixed to 1.8V
> 
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/display/bridge/adi,adv7511.txt   | 23 ++++++++++---------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
> index 2c887536258c..e8ddec5d9d91 100644
> --- a/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/adi,adv7511.txt
> @@ -1,10 +1,10 @@
> -Analog Device ADV7511(W)/13/33 HDMI Encoders
> +Analog Device ADV7511(W)/13/33/35 HDMI Encoders
>  -----------------------------------------
>  
> -The ADV7511, ADV7511W, ADV7513 and ADV7533 are HDMI audio and video transmitters
> -compatible with HDMI 1.4 and DVI 1.0. They support color space conversion,
> -S/PDIF, CEC and HDCP. ADV7533 supports the DSI interface for input pixels, while
> -the others support RGB interface.
> +The ADV7511, ADV7511W, ADV7513, ADV7533 and ADV7535 are HDMI audio and video
> +transmitters compatible with HDMI 1.4 and DVI 1.0. They support color space
> +conversion, S/PDIF, CEC and HDCP. ADV7533/5 supports the DSI interface for input
> +pixels, while the others support RGB interface.
>  
>  Required properties:
>  
> @@ -13,6 +13,7 @@ Required properties:
>  		"adi,adv7511w"
>  		"adi,adv7513"
>  		"adi,adv7533"
> +		"adi,adv7535"
>  
>  - reg: I2C slave addresses
>    The ADV7511 internal registers are split into four pages exposed through
> @@ -52,14 +53,14 @@ The following input format properties are required except in "rgb 1x" and
>  - bgvdd-supply: A 1.8V supply that powers up the BGVDD pin. This is
>    needed only for ADV7511.
>  
> -The following properties are required for ADV7533:
> +The following properties are required for ADV7533 and ADV7535:
>  
>  - adi,dsi-lanes: Number of DSI data lanes connected to the DSI host. It should
>    be one of 1, 2, 3 or 4.
>  - a2vdd-supply: 1.8V supply that powers up the A2VDD pin on the chip.
>  - v3p3-supply: A 3.3V supply that powers up the V3P3 pin on the chip.
>  - v1p2-supply: A supply that powers up the V1P2 pin on the chip. It can be
> -  either 1.2V or 1.8V.
> +  either 1.2V or 1.8V for ADV7533 but only 1.8V for ADV7535.
>  
>  Optional properties:
>  
> @@ -71,9 +72,9 @@ Optional properties:
>  - adi,embedded-sync: The input uses synchronization signals embedded in the
>    data stream (similar to BT.656). Defaults to separate H/V synchronization
>    signals.
> -- adi,disable-timing-generator: Only for ADV7533. Disables the internal timing
> -  generator. The chip will rely on the sync signals in the DSI data lanes,
> -  rather than generate its own timings for HDMI output.
> +- adi,disable-timing-generator: Only for ADV7533 and ADV7535. Disables the
> +  internal timing generator. The chip will rely on the sync signals in the
> +  DSI data lanes, rather than generate its own timings for HDMI output.
>  - clocks: from common clock binding: reference to the CEC clock.
>  - clock-names: from common clock binding: must be "cec".
>  - reg-names : Names of maps with programmable addresses.
> @@ -85,7 +86,7 @@ Required nodes:
>  The ADV7511 has two video ports. Their connections are modelled using the OF
>  graph bindings specified in Documentation/devicetree/bindings/graph.txt.
>  
> -- Video port 0 for the RGB, YUV or DSI input. In the case of ADV7533, the
> +- Video port 0 for the RGB, YUV or DSI input. In the case of ADV7533/5, the
>    remote endpoint phandle should be a reference to a valid mipi_dsi_host device
>    node.
>  - Video port 1 for the HDMI output

-- 
Regards,

Laurent Pinchart
