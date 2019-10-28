Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD88CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043B020B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572232119;
	bh=9pHjVHBWzzO8as/GlxtW409f8OPgE/yFlPmLQPZ/F7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uqV9h0FHrelasNnMsSHafFKe3kRIEA77LcZeE6EGlsXFtZo/CDa3CF1/BxISNBmS2
	 DaWMwb8n3fcScweljlql8KD1chlVWgI6RgT3Jr2VUy3mrQGTFC0ExSrEJejFrzwRhT
	 PesGJ1UROgvDZJ3Q2Fn5/utYlHOn1IZ/mCmy7D3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfJ1DId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 23:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfJ1DId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:08:33 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC1D20873;
        Mon, 28 Oct 2019 03:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572232111;
        bh=9pHjVHBWzzO8as/GlxtW409f8OPgE/yFlPmLQPZ/F7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIns11PAGhGhvvwvm97UvqGlArw66VuIrxzIJAikWoo53Yl05QBJA9iaAxz3/w+vg
         M0NXEsdUxfN1JRX9mK9xZ+YJMnTfk7rd7EpIwOTg+7sRmcJvDtRAf+bwqMos6BqPU1
         O816SZI5wlfoZsMZPhvKtcOvUBZ0ePvZyY5pqD3k=
Date:   Mon, 28 Oct 2019 11:08:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luka Pivk <luka.pivk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/2] arm: dts: imx*(colibri|apalis): add missing
 recovery modes to i2c
Message-ID: <20191028030810.GH16985@dragon>
References: <20191016170332.2013-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016170332.2013-1-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 05:03:41PM +0000, Philippe Schenker wrote:
> This patch adds missing i2c recovery modes and corrects wrongly named
> ones.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

As a practise, we use 'ARM: ' to prefix i.MX arch/arm/ patches.

I fixed it up and applied both patches.

Shawn

> 
> ---
> 
> Changes in v2:
> - Added scl/sda gpio
> - Added missing recovery mode to i2c2 on imx6qdl-colibri
> 
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 30 +++++++++++++++++++++-----
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 18 ++++++++++++----
>  2 files changed, 39 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 7c4ad541c3f5..86cad6c9f0f9 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -205,8 +205,11 @@
>  /* I2C1_SDA/SCL on MXM3 209/211 (e.g. RTC on carrier board) */
>  &i2c1 {
>  	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_gpio>;
> +	scl-gpios = <&gpio5 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio5 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "disabled";
>  };
>  
> @@ -216,8 +219,11 @@
>   */
>  &i2c2 {
>  	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_gpio>;
> +	scl-gpios = <&gpio4 12 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio4 13 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "okay";
>  
>  	pmic: pfuze100@8 {
> @@ -372,9 +378,9 @@
>   */
>  &i2c3 {
>  	clock-frequency = <100000>;
> -	pinctrl-names = "default", "recovery";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c3>;
> -	pinctrl-1 = <&pinctrl_i2c3_recovery>;
> +	pinctrl-1 = <&pinctrl_i2c3_gpio>;
>  	scl-gpios = <&gpio3 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	sda-gpios = <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "disabled";
> @@ -646,6 +652,13 @@
>  		>;
>  	};
>  
> +	pinctrl_i2c1_gpio: i2c1gpiogrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_CSI0_DAT8__GPIO5_IO26 0x4001b8b1
> +			MX6QDL_PAD_CSI0_DAT9__GPIO5_IO27 0x4001b8b1
> +		>;
> +	};
> +
>  	pinctrl_i2c2: i2c2grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
> @@ -653,6 +666,13 @@
>  		>;
>  	};
>  
> +	pinctrl_i2c2_gpio: i2c2gpiogrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_KEY_COL3__GPIO4_IO12 0x4001b8b1
> +			MX6QDL_PAD_KEY_ROW3__GPIO4_IO13 0x4001b8b1
> +		>;
> +	};
> +
>  	pinctrl_i2c3: i2c3grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_EIM_D17__I2C3_SCL 0x4001b8b1
> @@ -660,7 +680,7 @@
>  		>;
>  	};
>  
> -	pinctrl_i2c3_recovery: i2c3recoverygrp {
> +	pinctrl_i2c3_gpio: i2c3gpiogrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_EIM_D17__GPIO3_IO17 0x4001b8b1
>  			MX6QDL_PAD_EIM_D18__GPIO3_IO18 0x4001b8b1
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 019dda6b88ad..8ab9960fc15d 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -166,8 +166,11 @@
>   */
>  &i2c2 {
>  	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-0 = <&pinctrl_i2c2_gpio>;
> +	scl-gpios = <&gpio2 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +	sda-gpios = <&gpio3 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "okay";
>  
>  	pmic: pfuze100@8 {
> @@ -312,9 +315,9 @@
>   */
>  &i2c3 {
>  	clock-frequency = <100000>;
> -	pinctrl-names = "default", "recovery";
> +	pinctrl-names = "default", "gpio";
>  	pinctrl-0 = <&pinctrl_i2c3>;
> -	pinctrl-1 = <&pinctrl_i2c3_recovery>;
> +	pinctrl-1 = <&pinctrl_i2c3_gpio>;
>  	scl-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  	status = "disabled";
> @@ -509,6 +512,13 @@
>  		>;
>  	};
>  
> +	pinctrl_i2c2_gpio: i2c2grp {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_EB2__GPIO2_IO30 0x4001b8b1
> +			MX6QDL_PAD_EIM_D16__GPIO3_IO16 0x4001b8b1
> +		>;
> +	};
> +
>  	pinctrl_i2c3: i2c3grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_GPIO_3__I2C3_SCL 0x4001b8b1
> @@ -516,7 +526,7 @@
>  		>;
>  	};
>  
> -	pinctrl_i2c3_recovery: i2c3recoverygrp {
> +	pinctrl_i2c3_gpio: i2c3gpiogrp {
>  		fsl,pins = <
>  			MX6QDL_PAD_GPIO_3__GPIO1_IO03 0x4001b8b1
>  			MX6QDL_PAD_GPIO_6__GPIO1_IO06 0x4001b8b1
> -- 
> 2.23.0
> 
