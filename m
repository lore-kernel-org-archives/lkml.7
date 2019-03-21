Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0426218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553159039;
	bh=5eMO+aTOpne6EAfv8wHonDJU2Ql8FwFlXZkPAzeDwi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SFWX+G0ORMq/psKvpRK6sRplLcb3d/a1jVbPam4773G1akvge44eyTQCwaNXMKHyZ
	 VNP0IgKFBQu6lsVYj0Cxp0CRAxRXHSPisbRzcEpnExujDTH/sEEVr6izV5Z1372IDs
	 m57xiTBOLUIFJXLBKqiNwrjTKA1wSiaIFeLG6RwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfCUJD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfCUJD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:03:57 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080BE20811;
        Thu, 21 Mar 2019 09:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553159036;
        bh=5eMO+aTOpne6EAfv8wHonDJU2Ql8FwFlXZkPAzeDwi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v7Jsy6/7IFBabRRiTuUDPI0sgV41DjIZGCOkVr5AL3O4qLAEJrc49WJjGkjeXDvGL
         4Lm08t73XYbaqa/6WT5MTyF29Xst6reXm/ODHy6ev4VMMwPIC3ARU5ikgmt8hUE44M
         MpE3X/Fn2CphyjGGzWPCtjgfA1Q6zNaaalTl2Nf4=
Date:   Thu, 21 Mar 2019 17:03:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH v2] ARM: dts: vf610: Add ZII SPB4 board
Message-ID: <20190321090329.GG12513@dragon>
References: <20190313070224.30124-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313070224.30124-1-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:02:24AM -0700, Andrey Smirnov wrote:
> Add Device Tree for VF610 based Zodiac Seat Power Box.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-imx@nxp.com
> ---
> 
> Changes since [v1]:
> 
>     - Change Makefile diff to keep entries in alphabetical order
>     
>     - Various node name changes
> 
> [v1] lkml.kernel.org/r/20190311184928.25988-1-andrew.smirnov@gmail.com
> 
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/vf610-zii-spb4.dts | 359 +++++++++++++++++++++++++++
>  2 files changed, 360 insertions(+)
>  create mode 100644 arch/arm/boot/dts/vf610-zii-spb4.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f4f5aeaf3298..efefce8efa05 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -606,6 +606,7 @@ dtb-$(CONFIG_SOC_VF610) += \
>  	vf610-zii-dev-rev-b.dtb \
>  	vf610-zii-dev-rev-c.dtb \
>  	vf610-zii-scu4-aib.dtb \
> +	vf610-zii-spb4.dtb \
>  	vf610-zii-ssmb-dtu.dtb \
>  	vf610-zii-ssmb-spu3.dtb
>  dtb-$(CONFIG_ARCH_MXS) += \
> diff --git a/arch/arm/boot/dts/vf610-zii-spb4.dts b/arch/arm/boot/dts/vf610-zii-spb4.dts
> new file mode 100644
> index 000000000000..3b0c003a9fcf
> --- /dev/null
> +++ b/arch/arm/boot/dts/vf610-zii-spb4.dts
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +
> +/*
> + * Device tree file for ZII's SPB4 board
> + *
> + * SPB - Seat Power Box
> + *
> + * Copyright (C) 2019 Zodiac Inflight Innovations
> + */
> +
> +/dts-v1/;
> +#include "vf610.dtsi"
> +
> +/ {
> +	model = "ZII VF610 SPB4 Board";
> +	compatible = "zii,vf610spb4", "zii,vf610dev", "fsl,vf610";

The board compatible needs to be documented in
Documentation/devicetree/bindings/arm/fsl.yaml.  And it should be a
separate patch that needs to be ACKed by DT maintainer.

> +
> +	chosen {
> +		stdout-path = &uart0;
> +	};
> +

<snip>

> +&iomuxc {
> +	pinctrl_dspi1: dspi1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTD5__DSPI1_CS0		0x1182
> +			VF610_PAD_PTD4__DSPI1_CS1		0x1182
> +			VF610_PAD_PTC6__DSPI1_SIN		0x1181
> +			VF610_PAD_PTC7__DSPI1_SOUT		0x1182
> +			VF610_PAD_PTC8__DSPI1_SCK		0x1182
> +		>;
> +	};
> +
> +	pinctrl_esdhc0: esdhc0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTC0__ESDHC0_CLK		0x31ef
> +			VF610_PAD_PTC1__ESDHC0_CMD		0x31ef
> +			VF610_PAD_PTC2__ESDHC0_DAT0		0x31ef
> +			VF610_PAD_PTC3__ESDHC0_DAT1		0x31ef
> +			VF610_PAD_PTC4__ESDHC0_DAT2		0x31ef
> +			VF610_PAD_PTC5__ESDHC0_DAT3		0x31ef
> +			VF610_PAD_PTD23__ESDHC0_DAT4		0x31ef
> +			VF610_PAD_PTD22__ESDHC0_DAT5		0x31ef
> +			VF610_PAD_PTD21__ESDHC0_DAT6		0x31ef
> +			VF610_PAD_PTD20__ESDHC0_DAT7		0x31ef
> +		>;
> +	};
> +
> +	pinctrl_esdhc1: esdhc1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA24__ESDHC1_CLK		0x31ef
> +			VF610_PAD_PTA25__ESDHC1_CMD		0x31ef
> +			VF610_PAD_PTA26__ESDHC1_DAT0		0x31ef
> +			VF610_PAD_PTA27__ESDHC1_DAT1		0x31ef
> +			VF610_PAD_PTA28__ESDHC1_DATA2		0x31ef
> +			VF610_PAD_PTA29__ESDHC1_DAT3		0x31ef
> +		>;
> +	};
> +
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTA6__RMII_CLKIN		0x30d1
> +			VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
> +			VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
> +			VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
> +			VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
> +			VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
> +			VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
> +			VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
> +			VF610_PAD_PTC16__ENET_RMII1_TXD0	0x30d2
> +			VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
> +		>;
> +	};
> +
> +	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
> +		fsl,pins = <
> +			VF610_PAD_PTE2__GPIO_107		0x31c2
> +			VF610_PAD_PTB28__GPIO_98		0x219d
> +		>;
> +	};
> +
> +	pinctrl_i2c0: i2c0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB14__I2C0_SCL		0x37ff
> +			VF610_PAD_PTB15__I2C0_SDA		0x37ff
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB16__I2C1_SCL		0x37ff
> +			VF610_PAD_PTB17__I2C1_SDA		0x37ff
> +		>;
> +	};
> +
> +	pinctrl_leds_debug: pinctrl-leds-debug {
> +		fsl,pins = <
> +			VF610_PAD_PTD3__GPIO_82			0x31c2
> +		>;
> +	};
> +
> +	pinctrl_uart0: uart0grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB10__UART0_TX		0x21a2
> +			VF610_PAD_PTB11__UART0_RX		0x21a1
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			VF610_PAD_PTB23__UART1_TX		0x21a2
> +			VF610_PAD_PTB24__UART1_RX		0x21a1
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins = <
> +			VF610_PAD_PTD0__UART2_TX		0x21a2
> +			VF610_PAD_PTD1__UART2_RX		0x21a1
> +		>;
> +	};
> +
> +	pinctrl_uart3: uart3grp {
> +                fsl,pins = <
> +                	VF610_PAD_PTA30__UART3_TX               0x21a2
> +                	VF610_PAD_PTA31__UART3_RX               0x21a1

.git/rebase-apply/patch:388: space before tab in indent.
                	VF610_PAD_PTA30__UART3_TX               0x21a2
.git/rebase-apply/patch:389: space before tab in indent.
                	VF610_PAD_PTA31__UART3_RX               0x21a1
warning: 2 lines add whitespace errors.

Shawn

> +                >;
> +        };
> +};
> -- 
> 2.20.1
> 
