Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247F4C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B5321738
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="jI/jY+Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfHLJPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:15:47 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:39534 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfHLJPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:15:47 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 9D261A32FB;
        Mon, 12 Aug 2019 11:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1565601344;
        bh=7HwczNO4AaJxhz9DmNAJsQskuU0vcuHCLWic8ettZ1A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jI/jY+UzM1VHcCwq+/3IO6TnBVWOVbl8u7LnYXJ1phUy7WgS6Ahm7lYGCQ7TFIV4M
         DJuGH9XbOg+nKg/up1TxBvtRgezEW58h8Pt/pRrtW4Nkv9KgwjORu9eMonK1j6QvrO
         UWjKg4NKenMQuhYLadJHl6CNyVQtoCNfDoMwTt34=
Subject: Re: [PATCH v3 05/21] ARM: dts: add recovery for I2C for iMX7
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
 <20190807082556.5013-6-philippe.schenker@toradex.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <cd0da6ed-6b59-be60-34b2-74eb603aa10d@ysoft.com>
Date:   Mon, 12 Aug 2019 11:15:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807082556.5013-6-philippe.schenker@toradex.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 08. 19 10:26, Philippe Schenker wrote:
> From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> 
> - add recovery mode for applicable i2c buses for
>    Colibri iMX7 module.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
Hi Philippe,

since you are going to send v4 anyway I suggest you update the subject
to be consistent across all the patches.

	"ARM: dts: imx7-colibri: add recovery for I2C for iMX7"

fits better I think.

Thank you,
Michal

> 
> Changes in v3: None
> Changes in v2: None
> 
>   arch/arm/boot/dts/imx7-colibri.dtsi | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index a8d992f3e897..2480623c92ff 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -140,8 +140,12 @@
>   
>   &i2c1 {
>   	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c1 &pinctrl_i2c1_int>;
> +	pinctrl-1 = <&pinctrl_i2c1_recovery &pinctrl_i2c1_int>;
> +	scl-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
> +
>   	status = "okay";
>   
>   	codec: sgtl5000@a {
> @@ -242,8 +246,11 @@
>   
>   &i2c4 {
>   	clock-frequency = <100000>;
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "gpio";
>   	pinctrl-0 = <&pinctrl_i2c4>;
> +	pinctrl-1 = <&pinctrl_i2c4_recovery>;
> +	scl-gpios = <&gpio7 8 GPIO_ACTIVE_HIGH>;
> +	sda-gpios = <&gpio7 9 GPIO_ACTIVE_HIGH>;
>   };
>   
>   &lcdif {
> @@ -540,6 +547,13 @@
>   		>;
>   	};
>   
> +	pinctrl_i2c4_recovery: i2c4-recoverygrp {
> +		fsl,pins = <
> +			MX7D_PAD_ENET1_RGMII_TD2__GPIO7_IO8	0x4000007f
> +			MX7D_PAD_ENET1_RGMII_TD3__GPIO7_IO9	0x4000007f
> +		>;
> +	};
> +
>   	pinctrl_lcdif_dat: lcdif-dat-grp {
>   		fsl,pins = <
>   			MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
> @@ -740,6 +754,13 @@
>   		>;
>   	};
>   
> +	pinctrl_i2c1_recovery: i2c1-recoverygrp {
> +		fsl,pins = <
> +			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x4000007f
> +			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x4000007f
> +		>;
> +	};
> +
>   	pinctrl_cd_usdhc1: usdhc1-cd-grp {
>   		fsl,pins = <
>   			MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59 /* CD */
> 

