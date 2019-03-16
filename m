Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8925BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F17218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552733844;
	bh=iwuIyyx+1tPM0xVKRiE6ifAV9llHYRwDyPX3Zsglh9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GOgU+JJY522IzGZkQ8OSrhhGtAogTBjjUe/BZFW7K0n05r4Gv1IkWWJqmKZLOVWAd
	 vcwsf7DwU0jJbzeXjMzzacEDBu9Mqb+4rCvpDARLPYx0+kp/2LE/IgSHqd+u7gtV3g
	 e/+YOQ5l8Md7mZUzNwmeBqd76E+jB/4X0xqup8bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfCPK5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 06:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfCPK5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 06:57:22 -0400
Received: from localhost (unknown [122.167.125.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F27206DF;
        Sat, 16 Mar 2019 10:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552733842;
        bh=iwuIyyx+1tPM0xVKRiE6ifAV9llHYRwDyPX3Zsglh9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t2QWrEaI+h81FzabGLyj2aHm6coXmNmL3p4kp0SsA7lTtVLWA/JWRfxtIwvwBND2g
         TIiCPkGIPlM7KsEhVEFDb1YSE15ZgDNgwCrNxJOjdG7BYNwO99fnJCyAKRhZJ7YttP
         +7JIqMFyeSp3YjyRrlkT0DPxDvbO4JnSjjpPUpk0=
Date:   Sat, 16 Mar 2019 16:27:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/6] dt-bindings: arm64: allwinner: h6: Add binding for
 DMA controller
Message-ID: <20190316105711.GG5348@vkoul-mobl>
References: <20190307165829.9086-1-jernej.skrabec@siol.net>
 <20190307165829.9086-2-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307165829.9086-2-jernej.skrabec@siol.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-03-19, 17:58, Jernej Skrabec wrote:
> DMA in H6 is similar to other DMA controller, except it is first which
> supports more than 32 request sources and has 16 channels. It also needs
> additional clock to be enabled.

Please see DT folks on this patch, when in doubt, use get_maintainers.pl
Need an ack on this patch before applying

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/dma/sun6i-dma.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> index 7fccc20d8331..cae31f4e77ba 100644
> --- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> +++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
> @@ -28,12 +28,17 @@ Example:
>  	};
>  
>  ------------------------------------------------------------------------------
> -For A64 DMA controller:
> +For A64 and H6 DMA controller:
>  
>  Required properties:
> -- compatible:	"allwinner,sun50i-a64-dma"
> +- compatible:	Must be one of
> +		  "allwinner,sun50i-a64-dma"
> +		  "allwinner,sun50i-h6-dma"
>  - dma-channels: Number of DMA channels supported by the controller.
>  		Refer to Documentation/devicetree/bindings/dma/dma.txt
> +- clocks:	In addition to parent AHB clock, it should also contain mbus
> +		clock (H6 only)
> +- clock-names:	Should contain "bus" and "mbus" (H6 only)
>  - all properties above, i.e. reg, interrupts, clocks, resets and #dma-cells
>  
>  Optional properties:
> -- 
> 2.21.0

-- 
~Vinod
