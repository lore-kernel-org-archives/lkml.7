Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D806BC47404
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 01:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4A2222CC
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 01:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570324590;
	bh=w0gsQYTE+55d9vtKjjYnHHUWNASN6/OWINizJtI09iU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nndeLFLkUzaCZotitRr6RVK88dcHXST+jcy6cAlC9mYBu9CWiyjITkwvse83qEsy7
	 8Xl9mbbSGzSyPL+jwT0+dm7p5QBMieeVnDwp1IsgCiNPZR4xPSTvQiDNpKEiOgh/4F
	 Xr21BlEYveK/ZZOkPx0ABngBthfmB+I/WbE7yrWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfJFBQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 21:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbfJFBQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 21:16:29 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0727520830;
        Sun,  6 Oct 2019 01:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570324588;
        bh=w0gsQYTE+55d9vtKjjYnHHUWNASN6/OWINizJtI09iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDkNZQlcXFBb5qvCQBbRFAHYMac8LSF0zGVELXPn6eQxWNsoiTNniFSq9qrMeqXhr
         hYuO8UNew35VxJNJp4OZX4Q95BNp7e3zXX+vMzCRraAiJ0axeiHQNDM1TvGfzQpLlX
         keAwA6eTwRe2xMbrHaqXYmUyvcHl+cegBlZWWeNg=
Date:   Sun, 6 Oct 2019 09:16:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, m.felsch@pengutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        marcel@ziswiler.com, marcel.ziswiler@toradex.com, stefan@agner.ch
Subject: Re: [PATCH v3 1/1] ARM: dts: colibri: introduce dts with UHS-I
 support enabled
Message-ID: <20191006011610.GH7150@dragon>
References: <20190904110918.25009-1-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904110918.25009-1-igor.opaniuk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:09:18PM +0300, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
> 
> Introduce DTS for Colibri iMX6S/DL V1.1x re-design, where UHS-I support was
> added. Provide proper configuration for VGEN3, which allows that rail to
> be automatically switched to 1.8 volts for proper UHS-I operation mode.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> ---
> 
> v3:
> - change hierarchy according to Marco's suggestions [Marco Felsch]
> - adjust compatible string adding v1.1 [Stefan Agner]
> 
> v2:
> - rework hierarchy of dts files, and a separate dtsi for Colibri
>   iMX6S/DL V1.1x re-design, where UHS-I was added [Marcel Ziswiler]
> - add comments about vgen3 power rail [Marcel Ziswiler]
> - fix other minor issues, addressing Marcel's comments. [Marcel Ziswiler]
> 
>  arch/arm/boot/dts/Makefile                    |  1 +
>  .../boot/dts/imx6dl-colibri-v1_1-eval-v3.dts  | 59 +++++++++++++++++++
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 11 +++-
>  3 files changed, 70 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9159fa2cea90..87dfc3db4343 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -401,6 +401,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6dl-aristainetos2_4.dtb \
>  	imx6dl-aristainetos2_7.dtb \
>  	imx6dl-colibri-eval-v3.dtb \
> +	imx6dl-colibri-v1_1-eval-v3.dtb \
>  	imx6dl-cubox-i.dtb \
>  	imx6dl-cubox-i-emmc-som-v15.dtb \
>  	imx6dl-cubox-i-som-v15.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
> new file mode 100644
> index 000000000000..92fcf4e62ba2
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0 OR X11
> +/*
> + * Copyright 2019 Toradex AG
> + */
> +
> +/dts-v1/;
> +
> +#include "imx6dl-colibri-eval-v3.dts"
> +
> +/ {
> +	model = "Toradex Colibri iMX6DL/S V1.1 on Colibri Evaluation Board V3";
> +	compatible = "toradex,colibri_imx6dl-v1_1-eval-v3",
> +		     "toradex,colibri_imx6dl-v1_1",
> +		     "toradex,colibri_imx6dl-eval-v3",
> +		     "toradex,colibri_imx6dl",

Please make sure these compatibles are documented.

> +		     "fsl,imx6dl";
> +};
> +
> +&iomuxc {
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170b1
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100b1
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170b1
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170b1
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170b1
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170b1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__SD1_CMD    0x170f1
> +			MX6QDL_PAD_SD1_CLK__SD1_CLK    0x100f1
> +			MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x170f1
> +			MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x170f1
> +			MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x170f1
> +			MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x170f1
> +		>;
> +	};
> +};
> +
> +/* Colibri MMC */
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1 &pinctrl_mmc_cd>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz &pinctrl_mmc_cd>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz &pinctrl_mmc_cd>;
> +	vmmc-supply = <&reg_module_3v3>;
> +	vqmmc-supply = <&vgen3_reg>;
> +	enable-sdio-wakeup;

Check out Documentation/devicetree/bindings/power/wakeup-source.txt

Shawn

> +	keep-power-in-suspend;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	status = "okay";
> +	/delete-property/no-1-8-v;
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 1beac22266ed..27097ab5eaab 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -215,7 +215,16 @@
>  				regulator-always-on;
>  			};
>  
> -			/* vgen3: unused */
> +			/*
> +			 * +V3.3_1.8_SD1 coming off VGEN3 and supplying
> +			 * the i.MX 6 NVCC_SD1.
> +			 */
> +			vgen3_reg: vgen3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
>  
>  			vgen4_reg: vgen4 {
>  				regulator-min-microvolt = <1800000>;
> -- 
> 2.17.1
> 
