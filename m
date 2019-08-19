Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A633C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083132086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566213701;
	bh=rbe0ZJX0S7ZC9cn7XqBdlwI52Gljn2EhY1w3k/I2IDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GS9bWoT2uGUy/QpmS3/3vtGULajsh8lagsVvSA4a8c4UHlZeOEwDsF/z6AA5upRx6
	 sRSVb5vL6YxWxJExtW8xIrCOAz/p44dHQq8fOmiEK+hDFdgiLV9YGadgvuLVl4HGRT
	 YVoToREMGL8ZnZWHeyVUVV8o5WPrhGcBhrUqjEqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfHSLVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfHSLVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:21:39 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97E352085A;
        Mon, 19 Aug 2019 11:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213699;
        bh=rbe0ZJX0S7ZC9cn7XqBdlwI52Gljn2EhY1w3k/I2IDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hLRQkbiZ6pcBq+kZyNNrEKS3av5RqmLttMJtMZVdRGpaNFrOIMT1o2Q2FfN8/sI4W
         xbVKqXeVVwkMJhH6UzXEztEsfJhpkyuOqep68cq4GUIGdkpVbi2eOB0N5X4Z6eqj+k
         ELUJui8xxI0izBklsJizC1ulI2wtWENH8qNb9CFI=
Date:   Mon, 19 Aug 2019 13:21:26 +0200
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
Subject: Re: [PATCH v4 08/21] ARM: dts: imx7-colibri: Add touch controllers
Message-ID: <20190819112124.GR5999@X250>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-9-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812142105.1995-9-philippe.schenker@toradex.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:21:26PM +0000, Philippe Schenker wrote:
> Add touch controller that is connected over an I2C bus.
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
> - Fix commit message
> 
> Changes in v2:
> - Deleted touchrevolution downstream stuff
> - Use generic node name
> - Better comment
> 
>  arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> index d4dbc4fc1adf..576dec9ff81c 100644
> --- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> @@ -145,6 +145,21 @@
>  &i2c4 {
>  	status = "okay";
>  
> +	/*
> +	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
> +	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
> +	 */
> +	touchscreen@4a {
> +		compatible = "atmel,maxtouch";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpiotouch>;
> +		reg = <0x4a>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 */
> +		reset-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;	/* SODIMM 30 */
> +		status = "disabled";

Why disabled?

Shawn

> +	};
> +
>  	/* M41T0M6 real time clock on carrier board */
>  	rtc: m41t0m6@68 {
>  		compatible = "st,m41t0";
> @@ -200,3 +215,12 @@
>  	vmmc-supply = <&reg_3v3>;
>  	status = "okay";
>  };
> +
> +&iomuxc {
> +	pinctrl_gpiotouch: touchgpios {
> +		fsl,pins = <
> +			MX7D_PAD_GPIO1_IO09__GPIO1_IO9		0x74
> +			MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x14
> +		>;
> +	};
> +};
> -- 
> 2.22.0
> 
