Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C8C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D31B2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfDYLM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:12:59 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:40959 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfDYLM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:12:58 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id B365E3C00D1;
        Thu, 25 Apr 2019 13:12:54 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FuD-uAvYsWA8; Thu, 25 Apr 2019 13:12:48 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 161BC3C0034;
        Thu, 25 Apr 2019 13:12:48 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 25 Apr
 2019 13:12:47 +0200
Date:   Thu, 25 Apr 2019 13:12:45 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Simon Horman <horms+renesas@verge.net.au>,
        Simon Horman <horms@verge.net.au>,
        Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
CC:     <magnus.damm@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-renesas-soc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tfranzen@de.adit-jv.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] arm64: dts: ulcb-kf: Add support for TI WL1837
Message-ID: <20190425111245.GA7258@vmlxhi-102.adit-jv.com>
References: <20190411124102.22442-1-spapageorgiou@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190411124102.22442-1-spapageorgiou@de.adit-jv.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

Do we have any chance getting this upstream? If so, would you kindly
list the acceptance criteria we have to conform to?

Many thanks.

On Thu, Apr 11, 2019 at 02:41:03PM +0200, Spyridon Papageorgiou wrote:
> This patch adds description of TI WL1837 and links interfaces
> to communicate with the IC, namely the SDIO interface to WLAN.
> 
> Signed-off-by: Spyridon Papageorgiou <spapageorgiou@de.adit-jv.com>
> ---
>  arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 49 ++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> index 7a09576..27851a7 100644
> --- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> +++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
> @@ -38,6 +38,18 @@
>  		regulator-min-microvolt = <5000000>;
>  		regulator-max-microvolt = <5000000>;
>  	};
> +
> +	wlan_en: regulator-wlan_en {
> +		compatible = "regulator-fixed";
> +		regulator-name = "wlan-en-regulator";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&gpio_exp_74 4 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +	};
>  };
>  
>  &can0 {
> @@ -88,6 +100,13 @@
>  			line-name = "Audio_Out_OFF";
>  		};
>  
> +		sd-wifi-mux {
> +			gpio-hog;
> +			gpios = <5 GPIO_ACTIVE_HIGH>;
> +			output-low;	/* Connect WL1837 */
> +			line-name = "SD WiFi mux";
> +		};
> +
>  		hub_pwen {
>  			gpio-hog;
>  			gpios = <6 GPIO_ACTIVE_HIGH>;
> @@ -254,6 +273,12 @@
>  		function = "scif1";
>  	};
>  
> +	sdhi3_pins: sdhi3 {
> +		groups = "sdhi3_data4", "sdhi3_ctrl";
> +		function = "sdhi3";
> +		power-source = <3300>;
> +	};
> +
>  	usb0_pins: usb0 {
>  		groups = "usb0";
>  		function = "usb0";
> @@ -273,6 +298,30 @@
>  	status = "okay";
>  };
>  
> +&sdhi3 {
> +	pinctrl-0 = <&sdhi3_pins>;
> +	pinctrl-names = "default";
> +
> +	vmmc-supply = <&wlan_en>;
> +	vqmmc-supply = <&wlan_en>;
> +	bus-width = <4>;
> +	no-1-8-v;
> +	non-removable;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
> +	max-frequency = <26000000>;
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	wlcore: wlcore@2 {
> +		compatible = "ti,wl1837";
> +		reg = <2>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
>  &usb2_phy0 {
>  	pinctrl-0 = <&usb0_pins>;
>  	pinctrl-names = "default";
> -- 
> 2.7.4
> 

-- 
Best regards,
Eugeniu.
