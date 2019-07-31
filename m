Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFC2C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7116D206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Vl4Zvjjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfGaHJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:09:11 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:55086 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfGaHJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:09:07 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 0036FA0375;
        Wed, 31 Jul 2019 09:09:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1564556946;
        bh=4iPoQC2zVdqrc1YYIrTN5Z2OucTh3nHLWJP6OzMlpOE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vl4Zvjjq6tAl+G4y63xuRdr3K/XyhXuB5s+ZWyEBG01eYPSI80tFB+rcvPjUVYiP/
         cIE+ykvQU1lvgQ/j45CJdEfCF9TI/ri9CvBf5tyZTUF2R8rYkj80eh9S03jpl6CJpO
         lhycBra2fA1+WFH1bAJyX1m6RXfZUp+oEV3zvhTw=
Subject: Re: [PATCH 13/22] ARM: dts: colibri-imx6: Add missing pinmuxing to
 Toradex eval board
To:     Philippe Schenker <dev@pschenker.ch>, marcel.ziswiler@toradex.com,
        max.krummenacher@toradex.com, stefan@agner.ch,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
References: <20190730144649.19022-1-dev@pschenker.ch>
 <20190730144649.19022-14-dev@pschenker.ch>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <ee2e4fec-21fe-709b-9c47-db7c24407c1c@ysoft.com>
Date:   Wed, 31 Jul 2019 09:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190730144649.19022-14-dev@pschenker.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 07. 19 16:46, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This patch adds some missing pinmuxing that is in the colibri
> standard to the dts.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---

"ARM: dts: imx6-colibri: " in the subject for consistency.

Same for the Apalis, please.

Michal

> 
>   arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> index 63d4f9ca9ad8..13800e60246c 100644
> --- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> @@ -204,6 +204,14 @@
>   };
>   
>   &iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <
> +		&pinctrl_weim_gpio_1 &pinctrl_weim_gpio_2
> +		&pinctrl_weim_gpio_3 &pinctrl_weim_gpio_4
> +		&pinctrl_weim_gpio_5 &pinctrl_weim_gpio_6
> +		&pinctrl_usbh_oc_1 &pinctrl_usbc_id_1
> +	>;
> +
>   	pinctrl_pcap_1: pcap-1 {
>   		fsl,pins = <
>   			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0 /* SODIMM 28 */
> 

