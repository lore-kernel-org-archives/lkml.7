Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DC2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 03:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8BF218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 03:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551323972;
	bh=xePYJHDagXzcOhYXctzwQW8JZanDVo7BDIflpVHfPE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fHE13w4sB2Z1wtOI2UIFryJmoTIlxBw2dChgF2yWfnqysb+cBifxkS9MBaEZzbCyU
	 s/MBKqrl9osuX3amLpvyxEEhXQDttGQ8NtQv4J/RFknU1reNOMwqht7wv73BFI0nNp
	 rfukBRZTpM8j1e9Q/Q8x5t4angbp7qp2b5dLdfTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbfB1DTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 22:19:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:60924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbfB1DTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 22:19:30 -0500
Received: from dragon (unknown [139.162.86.229])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A75A2183F;
        Thu, 28 Feb 2019 03:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551323969;
        bh=xePYJHDagXzcOhYXctzwQW8JZanDVo7BDIflpVHfPE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbEZhmOsNZAIOEu1ugj4MGpwIKsf1oyn1S1xz+6c0cg2USnKTrm7s1obnOgnRE7+p
         J/Agka6rq/a3m+JKjrLk0eFv6fa6uuiQWY8XfZB+8wr49jAOkG9GoQg5xhnVFUGv8g
         hVMH8XlhcKWIV6KXL1dqcon6bCCCCuMFLXG+HS5o=
Date:   Thu, 28 Feb 2019 11:18:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V7 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Message-ID: <20190228031832.GH26041@dragon>
References: <1551157967-30925-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551157967-30925-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:17:31AM +0000, Anson Huang wrote:
> Add i.MX8QXP CPU opp table to support cpufreq.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Prefix 'arm64: dts: imx8qxp: ' would already be clear enough.  I dropped
'freescale' from there and applied patch.

> ---
> No changes since V6.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4c3dd95..41bf0ce 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -34,6 +34,9 @@
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			clocks = <&clk IMX_A35_CLK>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_1: cpu@1 {
> @@ -42,6 +45,9 @@
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			clocks = <&clk IMX_A35_CLK>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_2: cpu@2 {
> @@ -50,6 +56,9 @@
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			clocks = <&clk IMX_A35_CLK>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_3: cpu@3 {
> @@ -58,6 +67,9 @@
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&A35_L2>;
> +			clocks = <&clk IMX_A35_CLK>;
> +			operating-points-v2 = <&a35_0_opp_table>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A35_L2: l2-cache0 {
> @@ -65,6 +77,24 @@
>  		};
>  	};
>  
> +	a35_0_opp_table: opp-table {

What does the '0' in the label mean?

Shawn

> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-900000000 {
> +			opp-hz = /bits/ 64 <900000000>;
> +			opp-microvolt = <1000000>;
> +			clock-latency-ns = <150000>;
> +		};
> +
> +		opp-1200000000 {
> +			opp-hz = /bits/ 64 <1200000000>;
> +			opp-microvolt = <1100000>;
> +			clock-latency-ns = <150000>;
> +			opp-suspend;
> +		};
> +	};
> +
>  	gic: interrupt-controller@51a00000 {
>  		compatible = "arm,gic-v3";
>  		reg = <0x0 0x51a00000 0 0x10000>, /* GIC Dist */
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
