Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1763C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2212077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 14:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="u/TyFOV3";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="KALVHfDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfG1OxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 10:53:10 -0400
Received: from node.akkea.ca ([192.155.83.177]:40874 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfG1OxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 10:53:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 5EC1F4E2006;
        Sun, 28 Jul 2019 14:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1564325589; bh=jFYSwWQ6KDwhrZUv1WSImF62zPOOJ60VfGwI0NTIRtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=u/TyFOV3OsHurjKFSzVTZVsUvO56d41BY6WC/NR9rwA0sfSzvBMiTmVEQZpN9Vj2q
         IEj++/3DNSLJbDhI6loYMA2rG+MQ2rUtiWHKQ6J+cbxYocRy6ZojMUltNpE8nBEIka
         ftP7xlWgRsn80FXtbDnPGhvLba3lzPh+pWoJseuU=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hMTirB_UYjpE; Sun, 28 Jul 2019 14:53:08 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
        by node.akkea.ca (Postfix) with ESMTPSA id D24544E2003;
        Sun, 28 Jul 2019 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1564325588; bh=jFYSwWQ6KDwhrZUv1WSImF62zPOOJ60VfGwI0NTIRtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=KALVHfDBnZ7/KQ4LI/qhXLyjgpzXaxKFr1sJ3+OPYUy9j7NwAqQ1QHrY+yNi08w1g
         v2VH11VnJ4HNc6AQAkCVyWtPoHlH9xDB1SHiEsuEj+PGEJi3/h+dGVwktLsZybukqm
         AQRAuHdQChjlzv8Q1oLlrc+7yW440JfuguM0NwQA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 28 Jul 2019 07:53:08 -0700
From:   Angus Ainslie <angus@akkea.ca>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de, ccaione@baylibre.com,
        abel.vesa@nxp.com, baruch@tkos.co.il, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@nxp.com,
        agx@sigxcpu.org, Anson.Huang@nxp.com,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: imx8mq: Init rates and parents configs for
 clocks
In-Reply-To: <20190728141218.12702-1-daniel.baluta@nxp.com>
References: <20190728141218.12702-1-daniel.baluta@nxp.com>
Message-ID: <b6506f6579f823e4c1e26ef3a7d1eed2@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 2019-07-28 07:12, Daniel Baluta wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> Add the initial configuration for clocks that need default parent and 
> rate
> setting. This is based on the vendor tree clock provider parents and 
> rates
> configuration except this is doing the setup in dts rather then using 
> clock
> consumer API in a clock provider driver.
> 
> Note that by adding the initial rate setting for audio_pll1/audio_pll
> setting we need to remove it from imx8mq-librem5-devkit.dts
> imx8mq-librem5-devkit.dts
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

This works with our board. One small nit below

Tested-by: Angus Ainslie (Purism) <angus@akkea.ca>

> ---
> Changes since v2:
> 	- set rate for audio_pll1/audio_pll2  in the dtsi file and
> 	remove the setting from imx8mq-librem5-devkit.dts
> 
>  .../dts/freescale/imx8mq-librem5-devkit.dts   |  5 -----
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 21 +++++++++++++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> index 683a11035643..c702ccc82867 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
> @@ -169,11 +169,6 @@
>  	};
>  };
> 
> -&clk {
> -	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL2>;
> -	assigned-clock-rates = <786432000>, <722534400>;
> -};
> -
>  &dphy {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 02fbd0625318..c67625a881a4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -494,6 +494,27 @@
>  				clock-names = "ckil", "osc_25m", "osc_27m",
>  				              "clk_ext1", "clk_ext2",
>  				              "clk_ext3", "clk_ext4";
> +				assigned-clocks = <&clk IMX8MQ_VIDEO_PLL1>,
> +					<&clk IMX8MQ_AUDIO_PLL1>,
> +					<&clk IMX8MQ_AUDIO_PLL2>,
> +					<&clk IMX8MQ_CLK_AHB>,
> +					<&clk IMX8MQ_CLK_NAND_USDHC_BUS>,
> +					<&clk IMX8MQ_CLK_AUDIO_AHB>,
> +					<&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
> +					<&clk IMX8MQ_CLK_NOC>;
> +				assigned-clock-parents = <0>,
> +						<0>,
> +						<0>,
> +						<&clk IMX8MQ_SYS1_PLL_133M>,
> +						<&clk IMX8MQ_SYS1_PLL_266M>,
> +						<&clk IMX8MQ_SYS2_PLL_500M>,
> +						<&clk IMX8MQ_CLK_27M>,
> +						<&clk IMX8MQ_SYS1_PLL_800M>;
> +				assigned-clock-rates = <593999999>,
> +						<786432000>,
> +						<722534400>;
> +
> +

Extra whitespace

Angus

>  			};
> 
>  			src: reset-controller@30390000 {
