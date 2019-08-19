Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F9C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097E22087B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566214259;
	bh=FQV5Xq+K1NWQNMFPHHsWUc0BPzvLcSph101rqifwyH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sOptfweN1AglkPBP1JUpEnT9qKBk6guY7iLFdvt66BAn7l726Yy7vvR2srOneKGlO
	 lFNr0GsOKJjuSHEI2vOk1OABm5l9jXjDzuVzFOiKJVuTBLwGZFMLSjAtc3enXhg+It
	 bGJail6/PArLLw5VL5cemB/lQXVbZfLIdCf3lkrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfHSLa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfHSLa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:30:57 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E7620851;
        Mon, 19 Aug 2019 11:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566214256;
        bh=FQV5Xq+K1NWQNMFPHHsWUc0BPzvLcSph101rqifwyH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHRaYVkEPNlPMj4BCnrKc6YmDgIsFLRpJHkQpRy9IGiFzivMTPza12JJcCziPko5C
         hOczRt3zVCJZxnfE9sBOX+Hiku+dpIFSqB6GgFTLUf5u1rcuGJMgD1p5A6pmwLOb1o
         F+2BGNF1E7E0R4t60gtXvdfpE3U/GP7q+n2pfIZQ=
Date:   Mon, 19 Aug 2019 13:30:44 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 12/21] ARM: dts: imx6-apalis: Add touchscreens used on
 Toradex eval boards
Message-ID: <20190819113042.GV5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-13-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-13-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:33PM +0000, Philippe Schenker wrote:
> This commit adds the touchscreens from Toradex so one can enable it.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v4:
> - Add Marcel Ziswiler's Ack
> 
> Changes in v3:
> - Fix commit title to "...imx6-apalis:..."
> 
> Changes in v2:
> - Deleted touchrevolution downstream stuff
> - Use generic node name
> - Put a better comment in there
> 
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 31 +++++++++++++++++++
>  arch/arm/boot/dts/imx6q-apalis-eval.dts       | 13 ++++++++
>  arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 13 ++++++++
>  arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 13 ++++++++
>  4 files changed, 70 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> index 9a5d6c94cca4..763fb5e90bd3 100644
> --- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> @@ -168,6 +168,21 @@
>  &i2c3 {
>  	status = "okay";
>  
> +	/*
> +	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
> +	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
> +	 */
> +	touchscreen@4a {
> +		compatible = "atmel,maxtouch";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pcap_1>;
> +		reg = <0x4a>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 */
> +		reset-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;	/* SODIMM 30 */
> +		status = "disabled";

If you have a reason to keep this disabled, please comment or state in
the commit log.

> +	};
> +
>  	/* M41T0M6 real time clock on carrier board */
>  	rtc_i2c: rtc@68 {
>  		compatible = "st,m41t0";
> @@ -175,6 +190,22 @@
>  	};
>  };
>  
> +&iomuxc {
> +	pinctrl_pcap_1: pcap-1 {

Name pinctrl node more consistently like pinctrl_xxx: xxxgrp.

Shawn

> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0 /* SODIMM 28 */
> +			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10	0x1b0b0 /* SODIMM 30 */
> +		>;
> +	};
> +
> +	pinctrl_mxt_ts: mxt-ts {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_CS1__GPIO2_IO24	0x130b0 /* SODIMM 107 */
> +			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14	0x130b0 /* SODIMM 106 */
> +		>;
> +	};
> +};
> +
>  &ipu1_di0_disp0 {
>  	remote-endpoint = <&lcd_display_in>;
>  };
> diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
> index 0edd3043d9c1..4665e15b196d 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
> @@ -167,6 +167,19 @@
>  &i2c1 {
>  	status = "okay";
>  
> +	/*
> +	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
> +	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
> +	 */
> +	touchscreen@4a {
> +		compatible = "atmel,maxtouch";
> +		reg = <0x4a>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* SODIMM 13 */
> +		status = "disabled";
> +	};
> +
>  	pcie-switch@58 {
>  		compatible = "plx,pex8605";
>  		reg = <0x58>;
> diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
> index b94bb687be6b..a3fa04a97d81 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
> @@ -172,6 +172,19 @@
>  &i2c1 {
>  	status = "okay";
>  
> +	/*
> +	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
> +	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
> +	 */
> +	touchscreen@4a {
> +		compatible = "atmel,maxtouch";
> +		reg = <0x4a>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* SODIMM 13 */
> +		status = "disabled";
> +	};
> +
>  	/* M41T0M6 real time clock on carrier board */
>  	rtc_i2c: rtc@68 {
>  		compatible = "st,m41t0";
> diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> index 302fd6adc8a7..5ba49d0f4880 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> @@ -171,6 +171,19 @@
>  &i2c1 {
>  	status = "okay";
>  
> +	/*
> +	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
> +	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
> +	 */
> +	touchscreen@4a {
> +		compatible = "atmel,maxtouch";
> +		reg = <0x4a>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <10 IRQ_TYPE_EDGE_FALLING>;
> +		reset-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* SODIMM 13 */
> +		status = "disabled";
> +	};
> +
>  	eeprom@50 {
>  		compatible = "atmel,24c02";
>  		reg = <0x50>;
> -- 
> 2.22.0
> 
