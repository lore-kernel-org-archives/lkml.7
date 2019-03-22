Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D427AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AFD218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553220693;
	bh=21voZlmTYfBpBNlUti6twAYJCV2rlig14i/vbhS8hZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N7kqx3HS6Nms8/87gflXwUStA2c78cD+HglJRLRxb6DhkCqfiR/y8TJ6NWyQSEQgQ
	 a2TSnEV8YyAfWsVZppErUUXvxdC+Kx0XWVCqcd3sGMbmDkMHGMMmrxo+wcIYubHu/t
	 k//LuCm/mHocN86FuH/KeYpNDwFyRCr/vLqENOy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCVCLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbfCVCLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 22:11:31 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DF2D218FE;
        Fri, 22 Mar 2019 02:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553220690;
        bh=21voZlmTYfBpBNlUti6twAYJCV2rlig14i/vbhS8hZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R92IchNawQr/Km2AZtoZOnoOwidvOyiYpHoq0IiaF/zU/XUxsvOpLuflZpBsZWJbJ
         S8Pi+KYq34/sJWZ5XOcAWXsqZgx3eMFOc8wRquOpx21UrjkoDyujq25x7IpbrKcVtZ
         RweQPrfw7jWP4NHYhynJ1mdIYgqTzTFr1nBdbKdM=
Date:   Fri, 22 Mar 2019 10:11:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: fsl: imx8mq: enable the multi sensor TMU
Message-ID: <20190322021102.GW12513@dragon>
References: <20190311213124.29325-1-angus@akkea.ca>
 <20190321125252.4498-1-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321125252.4498-1-angus@akkea.ca>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 05:52:52AM -0700, Angus Ainslie (Purism) wrote:
> Add the imx8mq TMU (Thermal management unit) nodes for CPU,
> GPU, and VPU.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Subject prefix 'arm64: dts: imx8mq:' would be good enough.  I changed it
and applied patch.

Shawn

> ---
> 
> Changes since v3:
> 
> Moved the annotation.
> 
> Changes since v2:
> 
> Updated alert and critical temps for commercial parts.
> Fixed node names.
> 
> Changes since v1:
> 
> Removed references to multi sensor patch.
> 
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 118 ++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index b39c6c75c043..81d5ce1b1ec1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -8,6 +8,7 @@
>  #include <dt-bindings/power/imx8mq-power.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
>  #include "imx8mq-pinfunc.h"
>  
>  / {
> @@ -89,6 +90,7 @@
>  			reg = <0x0>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A53_1: cpu@1 {
> @@ -97,6 +99,7 @@
>  			reg = <0x1>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A53_2: cpu@2 {
> @@ -105,6 +108,7 @@
>  			reg = <0x2>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A53_3: cpu@3 {
> @@ -113,6 +117,7 @@
>  			reg = <0x3>;
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			#cooling-cells = <2>;
>  		};
>  
>  		A53_L2: l2-cache0 {
> @@ -210,6 +215,119 @@
>  				#interrupt-cells = <2>;
>  			};
>  
> +			tmu: tmu@30260000 {
> +				compatible = "fsl,imx8mq-tmu";
> +				reg = <0x30260000 0x10000>;
> +				interrupt = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +				little-endian;
> +				fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
> +				fsl,tmu-calibration = <0x00000000 0x00000023
> +						       0x00000001 0x00000029
> +						       0x00000002 0x0000002f
> +						       0x00000003 0x00000035
> +						       0x00000004 0x0000003d
> +						       0x00000005 0x00000043
> +						       0x00000006 0x0000004b
> +						       0x00000007 0x00000051
> +						       0x00000008 0x00000057
> +						       0x00000009 0x0000005f
> +						       0x0000000a 0x00000067
> +						       0x0000000b 0x0000006f
> +
> +						       0x00010000 0x0000001b
> +						       0x00010001 0x00000023
> +						       0x00010002 0x0000002b
> +						       0x00010003 0x00000033
> +						       0x00010004 0x0000003b
> +						       0x00010005 0x00000043
> +						       0x00010006 0x0000004b
> +						       0x00010007 0x00000055
> +						       0x00010008 0x0000005d
> +						       0x00010009 0x00000067
> +						       0x0001000a 0x00000070
> +
> +						       0x00020000 0x00000017
> +						       0x00020001 0x00000023
> +						       0x00020002 0x0000002d
> +						       0x00020003 0x00000037
> +						       0x00020004 0x00000041
> +						       0x00020005 0x0000004b
> +						       0x00020006 0x00000057
> +						       0x00020007 0x00000063
> +						       0x00020008 0x0000006f
> +
> +						       0x00030000 0x00000015
> +						       0x00030001 0x00000021
> +						       0x00030002 0x0000002d
> +						       0x00030003 0x00000039
> +						       0x00030004 0x00000045
> +						       0x00030005 0x00000053
> +						       0x00030006 0x0000005f
> +						       0x00030007 0x00000071>;
> +				#thermal-sensor-cells =  <1>;
> +			};
> +
> +			thermal-zones {
> +				cpu-thermal {
> +					polling-delay-passive = <250>;
> +					polling-delay = <2000>;
> +					thermal-sensors = <&tmu 0>;
> +
> +					trips {
> +						cpu_alert: cpu-alert {
> +							temperature = <80000>;
> +							hysteresis = <2000>;
> +							type = "passive";
> +						};
> +
> +						cpu-crit {
> +							temperature = <90000>;
> +							hysteresis = <2000>;
> +							type = "critical";
> +						};
> +					};
> +
> +					cooling-maps {
> +						map0 {
> +							trip = <&cpu_alert>;
> +							cooling-device =
> +								<&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								<&A53_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								<&A53_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						};
> +					};
> +				};
> +
> +				gpu-thermal {
> +					polling-delay-passive = <250>;
> +					polling-delay = <2000>;
> +					thermal-sensors = <&tmu 1>;
> +
> +					trips {
> +						gpu-crit {
> +							temperature = <90000>;
> +							hysteresis = <2000>;
> +							type = "critical";
> +						};
> +					};
> +				};
> +
> +				vpu-thermal {
> +					polling-delay-passive = <250>;
> +					polling-delay = <2000>;
> +					thermal-sensors = <&tmu 2>;
> +
> +					trips {
> +						vpu-crit {
> +							temperature = <90000>;
> +							hysteresis = <2000>;
> +							type = "critical";
> +						};
> +					};
> +				};
> +			};
> +
>  			wdog1: watchdog@30280000 {
>  				compatible = "fsl,imx8mq-wdt", "fsl,imx21-wdt";
>  				reg = <0x30280000 0x10000>;
> -- 
> 2.17.1
> 
