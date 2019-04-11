Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9775DC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CD121841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554965876;
	bh=dlQby/NJ7q2keehVnTFPrY3wJ409brT3trhs7Pfa8v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1gBHYcZw5WuhsQltNUiHfeJ7vLUUShIdlsRXVrQ+QHQGCLe6/e6eJCImrnltW/Ro3
	 zwxHdSG2kubkXyLB0DwcjRgefO530qzRByRGZzL9N6s0OAcuLFj1npJDigcJkF/XSx
	 b8N7t3+Foo2ilhxrh7Zg7tsPQymEx1z2Jr0JlQYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfDKG5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfDKG5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:57:54 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35F42082E;
        Thu, 11 Apr 2019 06:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554965873;
        bh=dlQby/NJ7q2keehVnTFPrY3wJ409brT3trhs7Pfa8v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzU1xXhdBzMtqMRa9qN+24vVpA8/4Qf5+zT8IwiN4eoyMLMm15iO8JibEflE08URt
         3ilWyldsNZs38gsaoyC/ceRThvm5LrWT4su9U7FFh2zrJP7ksl0oVRoUjDmikudteH
         ffYsIfpsGDYkU9wEIc6/eormADQyZ43EdXa6l88o=
Date:   Thu, 11 Apr 2019 14:57:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx6ul-pico: Add support for the dwarf
 baseboard
Message-ID: <20190411065734.GC26817@dragon>
References: <20190407193723.3351-1-otavio@ossystems.com.br>
 <20190407193723.3351-2-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407193723.3351-2-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 04:37:23PM -0300, Otavio Salvador wrote:
> From: Fabio Estevam <festevam@gmail.com>
> 
> Add support for the imx6ul pico board with dwarf baseboard combination.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> ---
> 
>  arch/arm/boot/dts/Makefile              |  1 +
>  arch/arm/boot/dts/imx6ul-pico-dwarf.dts | 52 +++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-pico-dwarf.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index a969ca820d41..e4a2349e130e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -566,6 +566,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-isiot-nand.dtb \
>  	imx6ul-liteboard.dtb \
>  	imx6ul-opos6uldev.dtb \
> +	imx6ul-pico-dwarf.dtb \
>  	imx6ul-pico-hobbit.dtb \
>  	imx6ul-pico-pi.dtb \
>  	imx6ul-phytec-phyboard-segin-full.dtb \
> diff --git a/arch/arm/boot/dts/imx6ul-pico-dwarf.dts b/arch/arm/boot/dts/imx6ul-pico-dwarf.dts
> new file mode 100644
> index 000000000000..3edd60f46d37
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-pico-dwarf.dts
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Copyright 2015 Technexion Ltd.
> +//
> +// Author: Wig Cheng  <wig.cheng@technexion.com>
> +//	   Richard Hu <richard.hu@technexion.com>
> +//	   Tapani Utriainen <tapani@technexion.com>
> +/dts-v1/;
> +
> +#include "imx6ul-pico.dtsi"
> +/ {
> +	model = "TechNexion PICO-IMX6UL and DWARF baseboard";
> +	compatible = "technexion,imx6ul-pico-dwarf", "fsl,imx6ul";
> +
> +	sound {
> +		compatible = "fsl,imx-audio-sgtl5000";
> +		model = "imx6ul-sgtl5000";
> +		audio-cpu = <&sai1>;
> +		audio-codec = <&sgtl5000>;
> +		audio-routing =
> +			"LINE_IN", "Line In Jack",
> +			"MIC_IN", "Mic Jack",
> +			"Mic Jack", "Mic Bias",
> +			"Headphone Jack", "HP_OUT";
> +	};
> +
> +	sys_mclk: clock-sys-mclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <24576000>;
> +	};
> +};
> +
> +&i2c2 {
> +	clock_frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	sgtl5000: codec@a {

audio-codec for node name.

Shawn

> +		reg = <0x0a>;
> +		compatible = "fsl,sgtl5000";
> +		clocks = <&sys_mclk>;
> +		VDDA-supply = <&reg_2p5v>;
> +		VDDIO-supply = <&reg_3p3v>;
> +	};
> +
> +	pressure-sensor@60 {
> +		compatible = "fsl,mpl3115";
> +		reg = <0x60>;
> +	};
> +};
> -- 
> 2.21.0
> 
