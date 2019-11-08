Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EDBFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4304621882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfKHQ6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:58:21 -0500
Received: from muru.com ([72.249.23.125]:40912 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbfKHQ6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:58:16 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 937C380D4;
        Fri,  8 Nov 2019 16:58:51 +0000 (UTC)
Date:   Fri, 8 Nov 2019 08:58:12 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 02/10] ARM: dts: dra7: add cam clkctrl node
Message-ID: <20191108165812.GG5610@atomide.com>
References: <20191104204853.4355-1-bparrot@ti.com>
 <20191104204853.4355-3-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104204853.4355-3-bparrot@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [191104 20:49]:
> Add clkctrl nodes for CAM domain.

This too should mention that we need to use custom node naming. Other
than that this looks good to me. Again, I can queue the dts changes once
I have an immutable clock changes branch to use as base from Tero.

And up to Tero to consider if he wants to pick this clock node patch too.

Regards,

Tony

> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  arch/arm/boot/dts/dra7xx-clocks.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> index d1c2406ec71c..199f8d483f75 100644
> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -1734,6 +1734,20 @@
>  		};
>  	};
>  
> +	cam_cm: cam-cm@1000 {
> +		compatible = "ti,omap4-cm";
> +		reg = <0x1000 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0x1000 0x100>;
> +
> +		cam_clkctrl: cam-clkctrl@20 {
> +			compatible = "ti,clkctrl";
> +			reg = <0x20 0x2c>;
> +			#clock-cells = <2>;
> +		};
> +	};
> +
>  	dss_cm: dss-cm@1100 {
>  		compatible = "ti,omap4-cm";
>  		reg = <0x1100 0x100>;
> -- 
> 2.17.1
> 
