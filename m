Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF1AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F17C2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfDWFRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 01:17:44 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:54253 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWFRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 01:17:43 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hInoL-00026e-3d; Tue, 23 Apr 2019 07:17:41 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hInoJ-000332-0b; Tue, 23 Apr 2019 07:17:39 +0200
Date:   Tue, 23 Apr 2019 07:17:38 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mm-evk: Enable audio codec wm8524
Message-ID: <20190423051738.tmyto7nvm4w5zt4r@pengutronix.de>
References: <20190422193542.2853-1-daniel.baluta@nxp.com>
 <20190422193542.2853-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422193542.2853-3-daniel.baluta@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:14:57 up 94 days,  9:56, 72 users,  load average: 0.00, 0.02,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 19-04-22 19:36, Daniel Baluta wrote:
> i.MX8MM has one wm8524 audio codec connected with
> SAI3 digital audio interface.
> 
> This patch uses simple-card machine driver in order
> to enable wm8524 codec.
> 
> We need to set:
> 	* SAI3 pinctrl configuration
> 	* clock hierarchy
> 	* codec node
> 	* simple-card configuration
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 48 ++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> index 2d5d89475b76..207b13266a96 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
> @@ -37,6 +37,35 @@
>  		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	wm8524: audio-codec {
> +		#sound-dai-cells = <0>;
> +		compatible = "wlf,wm8524";
> +		wlf,mute-gpios = <&gpio5 21 GPIO_ACTIVE_LOW>;

I would mux the gpio where I use them.

> +	};
> +
> +	sound-wm8524 {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "wm8524-audio";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&cpudai>;
> +		simple-audio-card,bitclock-master = <&cpudai>;
> +		simple-audio-card,widgets =
> +			"Line", "Left Line Out Jack",
> +			"Line", "Right Line Out Jack";
> +		simple-audio-card,routing =
> +			"Left Line Out Jack", "LINEVOUTL",
> +			"Right Line Out Jack", "LINEVOUTR";
> +
> +		cpudai: simple-audio-card,cpu {
> +			sound-dai = <&sai3>;
> +		};
> +
> +		link_codec: simple-audio-card,codec {

Can you drop that phandle?

Regards,
  Marco

> +			sound-dai = <&wm8524>;
> +			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
> +		};
> +	};
>  };
>  
>  &fec1 {
> @@ -61,6 +90,15 @@
>  	};
>  };
>  
> +&sai3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sai3>;
> +	assigned-clocks = <&clk IMX8MM_CLK_SAI3>;
> +	assigned-clock-parents = <&clk IMX8MM_AUDIO_PLL1_OUT>;
> +	assigned-clock-rates = <24576000>;
> +	status = "okay";
> +};
> +
>  &uart2 { /* console */
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart2>;
> @@ -130,6 +168,16 @@
>  		>;
>  	};
>  
> +	pinctrl_sai3: sai3grp {
> +		fsl,pins = <
> +			MX8MM_IOMUXC_SAI3_TXFS_SAI3_TX_SYNC     0xd6
> +			MX8MM_IOMUXC_SAI3_TXC_SAI3_TX_BCLK      0xd6
> +			MX8MM_IOMUXC_SAI3_MCLK_SAI3_MCLK        0xd6
> +			MX8MM_IOMUXC_SAI3_TXD_SAI3_TX_DATA0     0xd6
> +			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21        0xd6
> +		>;
> +	};
> +
>  	pinctrl_uart2: uart2grp {
>  		fsl,pins = <
>  			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
> -- 
> 2.17.1
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
