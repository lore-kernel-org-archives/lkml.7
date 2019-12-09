Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68157C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 01:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8C520709
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 01:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575853576;
	bh=diImKIxWYiCfkVFDpFphmhIAKhSJkzitOSJh3ppOi8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iLg6UMc5ju0ODainkfneV0njq5MX9C1/pNAVWw4r3rSdCnE5syRmMmpvYhkF5l1Y8
	 IT9t1tRaUfzqHWuVC8lPmqP5sERYbw9JzLdxYoScYKqy89m0wYVawjKolFLWnaVf8Z
	 WbIgz9fBwocf/ytcqTlibUgyeP29+5ALU2iBpywQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLIBGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 20:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfLIBGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 20:06:13 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB68A2070A;
        Mon,  9 Dec 2019 01:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575853572;
        bh=diImKIxWYiCfkVFDpFphmhIAKhSJkzitOSJh3ppOi8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXD0FoNc+Hf9Pd51Sg5TFhXQdy/jILHk2oxaKvx8nNkgYUTogvLeifcwjg2FefGpu
         FzzScTc/MEMZtXZ3xiDSD8l7ZrVSWXeWD4vJE+XtTnMutj0mA1p614qMS5TZuADRYg
         zPnqBm3su8c94kAu9k4IZ5Ac3q0m7mrpYaFcdEQk=
Date:   Mon, 9 Dec 2019 09:05:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: imx8-clock: Add ADMA clock ids
Message-ID: <20191209010031.GP3365@dragon>
References: <1573647909-31081-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573647909-31081-1-git-send-email-abel.vesa@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:25:13PM +0000, Abel Vesa wrote:
> According to the RM, the Audio and DMA (ADMA) subsystem is a collection
> of audio peripherals and some system modules.
> Add the ADMA specific clock ids to the dt-bindings clock file.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/clock/imx8-clock.h | 96 +++++++++++++++++++++++++++++++++-
>  1 file changed, 94 insertions(+), 2 deletions(-)
> 
> diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
> index 673a8c6..6e0c752 100644
> --- a/include/dt-bindings/clock/imx8-clock.h
> +++ b/include/dt-bindings/clock/imx8-clock.h
> @@ -131,7 +131,60 @@
>  #define IMX_ADMA_PWM_CLK				188
>  #define IMX_ADMA_LCD_CLK				189
>  
> -#define IMX_SCU_CLK_END					190
> +#define IMX_ADMA_AUD_PLL0				190
> +#define IMX_ADMA_AUD_PLL1				191
> +
> +#define IMX_ADMA_AUD_PLL_DIV_CLK0_CLK			192
> +#define IMX_ADMA_AUD_PLL_DIV_CLK1_CLK			193
> +#define IMX_ADMA_AUD_REC_CLK0_CLK			194
> +#define IMX_ADMA_AUD_REC_CLK1_CLK			195
> +
> +/* CM40 SS */
> +#define IMX_CM40_IPG_CLK				196
> +#define IMX_CM40_I2C_DIV				197

These two don't look like ADMA clock.

Shawn

> +
> +#define IMX_SCU_CLK_END					198
> +
> +#define IMX_ADMA_ACM_AUD_CLK0_SEL			0
> +#define IMX_ADMA_ACM_AUD_CLK0_CLK			1
> +#define IMX_ADMA_ACM_AUD_CLK1_SEL			2
> +#define IMX_ADMA_ACM_AUD_CLK1_CLK			3
> +#define IMX_ADMA_ACM_MCLKOUT0_SEL			4
> +#define IMX_ADMA_ACM_MCLKOUT1_SEL			5
> +#define IMX_ADMA_ACM_ESAI0_MCLK_SEL			6
> +#define IMX_ADMA_ACM_GPT0_MUX_CLK_SEL			7
> +#define IMX_ADMA_ACM_GPT1_MUX_CLK_SEL			8
> +#define IMX_ADMA_ACM_GPT2_MUX_CLK_SEL			9
> +#define IMX_ADMA_ACM_GPT3_MUX_CLK_SEL			10
> +#define IMX_ADMA_ACM_GPT4_MUX_CLK_SEL			11
> +#define IMX_ADMA_ACM_GPT5_MUX_CLK_SEL			12
> +#define IMX_ADMA_ACM_SAI0_MCLK_SEL			13
> +#define IMX_ADMA_ACM_SAI1_MCLK_SEL			14
> +#define IMX_ADMA_ACM_SAI2_MCLK_SEL			15
> +#define IMX_ADMA_ACM_SAI3_MCLK_SEL			16
> +#define IMX_ADMA_ACM_SAI4_MCLK_SEL			17
> +#define IMX_ADMA_ACM_SAI5_MCLK_SEL			18
> +#define IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL			19
> +#define IMX_ADMA_ACM_MQS_TX_CLK_SEL			20
> +#define IMX_ADMA_ACM_ASRC0_MUX_CLK_SEL			21
> +#define IMX_ADMA_ACM_ASRC1_MUX_CLK_SEL			22
> +
> +#define IMX_ADMA_EXT_AUD_MCLK0				23
> +#define IMX_ADMA_EXT_AUD_MCLK1				24
> +#define IMX_ADMA_ESAI0_RX_CLK				25
> +#define IMX_ADMA_ESAI0_RX_HF_CLK			26
> +#define IMX_ADMA_ESAI0_TX_CLK				27
> +#define IMX_ADMA_ESAI0_TX_HF_CLK			28
> +#define IMX_ADMA_SPDIF0_RX				29
> +#define IMX_ADMA_SAI0_RX_BCLK				30
> +#define IMX_ADMA_SAI0_TX_BCLK				31
> +#define IMX_ADMA_SAI1_RX_BCLK				32
> +#define IMX_ADMA_SAI1_TX_BCLK				33
> +#define IMX_ADMA_SAI2_RX_BCLK				34
> +#define IMX_ADMA_SAI3_RX_BCLK				35
> +#define IMX_ADMA_SAI4_RX_BCLK				36
> +
> +#define IMX_ADMA_ACM_CLK_END				37
>  
>  /* LPCG clocks */
>  
> @@ -287,7 +340,46 @@
>  #define IMX_ADMA_LPCG_DSP_IPG_CLK			42
>  #define IMX_ADMA_LPCG_DSP_CORE_CLK			43
>  #define IMX_ADMA_LPCG_OCRAM_IPG_CLK			44
> +#define IMX_ADMA_LPCG_AMIX_IPG_CLK			45
> +#define IMX_ADMA_LPCG_ESAI_0_IPG_CLK			46
> +#define IMX_ADMA_LPCG_ESAI_0_EXTAL_CLK			47
> +#define IMX_ADMA_LPCG_SAI_0_IPG_CLK			48
> +#define IMX_ADMA_LPCG_SAI_0_MCLK			49
> +#define IMX_ADMA_LPCG_SAI_1_IPG_CLK			50
> +#define IMX_ADMA_LPCG_SAI_1_MCLK			51
> +#define IMX_ADMA_LPCG_SAI_2_IPG_CLK			52
> +#define IMX_ADMA_LPCG_SAI_2_MCLK			53
> +#define IMX_ADMA_LPCG_SAI_3_IPG_CLK			54
> +#define IMX_ADMA_LPCG_SAI_3_MCLK			55
> +#define IMX_ADMA_LPCG_SAI_4_IPG_CLK			56
> +#define IMX_ADMA_LPCG_SAI_4_MCLK			57
> +#define IMX_ADMA_LPCG_SAI_5_IPG_CLK			58
> +#define IMX_ADMA_LPCG_SAI_5_MCLK			59
> +#define IMX_ADMA_LPCG_MQS_IPG_CLK			60
> +#define IMX_ADMA_LPCG_MQS_MCLK				61
> +#define IMX_ADMA_LPCG_GPT5_IPG_CLK			62
> +#define IMX_ADMA_LPCG_GPT5_CLKIN			63
> +#define IMX_ADMA_LPCG_GPT6_IPG_CLK			64
> +#define IMX_ADMA_LPCG_GPT6_CLKIN			65
> +#define IMX_ADMA_LPCG_GPT7_IPG_CLK			66
> +#define IMX_ADMA_LPCG_GPT7_CLKIN			67
> +#define IMX_ADMA_LPCG_GPT8_IPG_CLK			68
> +#define IMX_ADMA_LPCG_GPT8_CLKIN			69
> +#define IMX_ADMA_LPCG_GPT9_IPG_CLK			70
> +#define IMX_ADMA_LPCG_GPT9_CLKIN			71
> +#define IMX_ADMA_LPCG_GPT10_IPG_CLK			72
> +#define IMX_ADMA_LPCG_GPT10_CLKIN			73
> +#define IMX_ADMA_LPCG_MCLKOUT0				74
> +#define IMX_ADMA_LPCG_MCLKOUT1				75
> +#define IMX_ADMA_LPCG_SPDIF_0_TX_CLK			76
> +#define IMX_ADMA_LPCG_SPDIF_0_GCLKW			77
> +#define IMX_ADMA_LPCG_ASRC_0_IPG_CLK			79
> +#define IMX_ADMA_LPCG_ASRC_1_IPG_CLK			80
> +#define IMX_ADMA_LPCG_AUD_PLL_DIV_CLK0_CLK		81
> +#define IMX_ADMA_LPCG_AUD_PLL_DIV_CLK1_CLK		82
> +#define IMX_ADMA_LPCG_AUD_REC_CLK0_CLK			83
> +#define IMX_ADMA_LPCG_AUD_REC_CLK1_CLK			84
>  
> -#define IMX_ADMA_LPCG_CLK_END				45
> +#define IMX_ADMA_LPCG_CLK_END				85
>  
>  #endif /* __DT_BINDINGS_CLOCK_IMX_H */
> -- 
> 2.7.4
> 
