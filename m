Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A637C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 08:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E765217D6
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 08:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570349238;
	bh=2mYmcL2dg3bAvRrFA6Aywfj8TPXbjBQZQZ81zTLe+rA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YWQQ7WdBlymOHyP08M9C3pQ9Jm5Se7CFpYo3NglwEqVAPALhirku1TftsJHnXUGKe
	 yW72qqVR4mEc2gWdRDdhIK2ERWJ5QuPFO8VlcCYpRkb535MiCOcMruckieFOhh6rdd
	 0GVdmmtWvjBsPWDMegv3kPoSX2RKQAH66k7G4XTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfJFIHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 04:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfJFIHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 04:07:17 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC5B2084D;
        Sun,  6 Oct 2019 08:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570349236;
        bh=2mYmcL2dg3bAvRrFA6Aywfj8TPXbjBQZQZ81zTLe+rA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zDR/zSv/WMVB4QUZ6FD/4WP2wLrUai/phhlsD/r282C6LRflGbq1p6YnEhTYTRpyY
         idChEquLgQ2wmccjNxJ3997rD4FAypI00QTA+FRq1Zw3v3W7I4lbo/10ZgW+Qfrp5F
         S3PzIyDmVZwugTG3SWsBRdmeZA87YZ/f0IO9AGUQ=
Date:   Sun, 6 Oct 2019 16:06:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     "To : Lucas Stach" <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dts: arm64: imx8mq: Enable gpu passive throttling
Message-ID: <20191006080641.GX7150@dragon>
References: <cover.1568255903.git.agx@sigxcpu.org>
 <0ab2ee7de9c2e24f6de860ffcbcdfc25b72c2c61.1568255903.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ab2ee7de9c2e24f6de860ffcbcdfc25b72c2c61.1568255903.git.agx@sigxcpu.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 07:40:35PM -0700, Guido Günther wrote:
> Temperature and hysteresis were picked after the CPU.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

The patch prefix should be 'arm64: dts: ...'

I fixed it up and applied the patch.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 4fdd60f2c51e..5023a0e5068d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -235,12 +235,26 @@
>  			thermal-sensors = <&tmu 1>;
>  
>  			trips {
> +				gpu_alert: gpu-alert {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
>  				gpu-crit {
>  					temperature = <90000>;
>  					hysteresis = <2000>;
>  					type = "critical";
>  				};
>  			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&gpu_alert>;
> +					cooling-device =
> +						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		vpu-thermal {
> @@ -912,6 +926,7 @@
>  			         <&clk IMX8MQ_CLK_GPU_AXI>,
>  			         <&clk IMX8MQ_CLK_GPU_AHB>;
>  			clock-names = "core", "shader", "bus", "reg";
> +			#cooling-cells = <2>;
>  			assigned-clocks = <&clk IMX8MQ_CLK_GPU_CORE_SRC>,
>  			                  <&clk IMX8MQ_CLK_GPU_SHADER_SRC>,
>  			                  <&clk IMX8MQ_CLK_GPU_AXI>,
> -- 
> 2.23.0.rc1
> 
