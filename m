Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE67C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 08:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0624B21479
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 08:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570350256;
	bh=2iGl1rQrR/BnAzbATpIyfQDG/xC97wAOefdDXaS7h3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CNWwCsAk573GnyEOUX71qLeEB8RTpPql7DOgZTb/KgQkJw/xesKQK3sfR8YIoQPAY
	 w4qrAV9t19SH+x2t+uYxTItWX5KNrpi29xHOv9xPRLimSMRAKaqfjZkSFh7oIPVZaS
	 YEcTSSraqKy1whMFFIgW7eILhtVlUhWSUCpuXJ5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfJFIYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 04:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfJFIYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 04:24:15 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D1820835;
        Sun,  6 Oct 2019 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570350253;
        bh=2iGl1rQrR/BnAzbATpIyfQDG/xC97wAOefdDXaS7h3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6L2pAop/2yu0puRY0cFdFS8zCdwPJMyiXqlEncUQYokhet0EREnCAewdHBEbB3yS
         QgY+U//qBuyd4mpoKmvxA3+0HQdrT0U/uYFkvqIgVW69/VZ7kP45mQhBNrRkk37UlI
         t7fim8yGMh6VmmMQ+Ji5HHpxBP7Cx79VmaGdWWgU=
Date:   Sun, 6 Oct 2019 16:23:52 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6: Extend support for Phytec phycore
 i.MX6ULL SoM
Message-ID: <20191006082349.GA7150@dragon>
References: <20190912202928.946200-1-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912202928.946200-1-pn@denx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 10:29:28PM +0200, Parthiban Nallathambi wrote:
> Extend Phycore i.MX6UL SoM for i.MX6ULL with on board eMMC. Phycore
> i.MX6ULL is deployed with same carrier board Segin as the pins are
> compatible with UL version.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

What is the base that the patch was generated from?  It doesn't apply to
my tree.

Shawn

> ---
>  arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi   | 26 +++++++++++++++++--
>  .../dts/imx6ul-phytec-phyboard-segin-full.dts |  5 ++++
>  arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi  | 24 +++++++++++++++++
>  3 files changed, 53 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi b/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
> index fc2997449b49..822a178ce438 100644
> --- a/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi
> @@ -7,7 +7,6 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pwm/pwm.h>
> -#include "imx6ul.dtsi"
>  
>  / {
>  	model = "Phytec phyCORE i.MX6 UltraLite";
> @@ -65,7 +64,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gpmi_nand>;
>  	nand-on-flash-bbt;
> -	status = "okay";
> +	status = "disabled";
>  };
>  
>  &i2c1 {
> @@ -90,6 +89,15 @@
>  	status = "okay";
>  };
>  
> +&usdhc2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	bus-width = <8>;
> +	no-1-8-v;
> +	non-removable;
> +	status = "disabled";
> +};
> +
>  &iomuxc {
>  	pinctrl_enet1: enet1grp {
>  		fsl,pins = <
> @@ -145,4 +153,18 @@
>  		>;
>  	};
>  
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
> +			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
> +			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
> +			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
> +			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
> +			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
> +			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
> +			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
> +			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
> +			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
> +		>;
> +	};
>  };
> diff --git a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> index b6a1407a9d44..76f2447f2657 100644
> --- a/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> +++ b/arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts
> @@ -5,6 +5,7 @@
>   */
>  
>  /dts-v1/;
> +#include "imx6ul.dtsi"
>  #include "imx6ul-phytec-pcl063.dtsi"
>  #include "imx6ul-phytec-phyboard-segin.dtsi"
>  #include "imx6ul-phytec-peb-eval-01.dtsi"
> @@ -37,6 +38,10 @@
>  	status = "okay";
>  };
>  
> +&gpmi {
> +	status = "okay";
> +};
> +
>  &i2c_rtc {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi b/arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi
> new file mode 100644
> index 000000000000..3f749d9f09a5
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ull-phytec-pcl063.dtsi
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2018 PHYTEC Messtechnik GmbH
> + * Author: Stefan Riedmueller <s.riedmueller@phytec.de>
> + */
> +
> +#include "imx6ul-phytec-pcl063.dtsi"
> +
> +/ {
> +	model = "PHYTEC phyCORE-i.MX 6ULL";
> +	compatible = "phytec,imx6ull-pcl063", "fsl,imx6ull";
> +};
> +
> +&iomuxc {
> +	/delete-node/ gpioledssomgrp;
> +};
> +
> +&iomuxc_snvs {
> +	pinctrl_gpioleds_som: gpioledssomgrp {
> +		fsl,pins = <
> +			MX6ULL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x0b0b0
> +		>;
> +	};
> +};
> -- 
> 2.21.0
> 
