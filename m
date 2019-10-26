Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A4CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8031E214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572091786;
	bh=jnqy6bpsu7LwjMxf9NYpjRqZhY+UHjFFE6P1vS48bDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yTt4oGoYL5fQJnI+S2crIBB8adJmHBdxqjLppX4xnVqC77CNmO8E9BBtXkuBCyd3R
	 N+DZo6gHzXguI/UyTCqNMnwJTsgfcdNtc+SiP+ZuQt/MSnEk86fLwECOW7/a9phfP9
	 p0fCe2MlQ9owyCof2A3CcXxqmi057TRd9Q2pOh5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfJZMJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 08:09:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJZMJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 08:09:45 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F5EB20863;
        Sat, 26 Oct 2019 12:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572091784;
        bh=jnqy6bpsu7LwjMxf9NYpjRqZhY+UHjFFE6P1vS48bDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n13omwEvmRS5ku6EtIGlC+GXQZ+ohSuieGHMbPeDN8jC99dfYfzVASeLtYWuAA2h4
         pqS3hvO8hnplwNVMwPmISNV9m7lvm6B8LG1IMxny7J075rD29yvSCC4lA41RmxJf+y
         jnCDx0wp1zXoQPRlHzce3hNXx9R4x/WV/bHnwyQQ=
Date:   Sat, 26 Oct 2019 20:09:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, jun.li@nxp.com,
        ping.bai@nxp.com, daniel.baluta@nxp.com, leonard.crestez@nxp.com,
        daniel.lezcano@linaro.org, l.stach@pengutronix.de,
        ccaione@baylibre.com, abel.vesa@nxp.com, andrew.smirnov@gmail.com,
        jon@solid-run.com, baruch@tkos.co.il, angus@akkea.ca, pavel@ucw.cz,
        agx@sigxcpu.org, troy.kisky@boundarydevices.com,
        gary.bisson@boundarydevices.com, dafna.hirschfeld@collabora.com,
        richard.hu@technexion.com, andradanciu1997@gmail.com,
        manivannan.sadhasivam@linaro.org, aisheng.dong@nxp.com,
        peng.fan@nxp.com, fugang.duan@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/5] arm64: dts: imx8qxp: Move usdhc clocks assignment to
 board DT
Message-ID: <20191026120902.GL14401@dragon>
References: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571192067-19600-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:14:23AM +0800, Anson Huang wrote:
> usdhc's clock rate is different according to different devices
> connected, so clock rate assignment should be placed in board
> DT according to different devices connected on each usdhc port.

I think it should be fine that we have a reasonable default settings in
soc.dtsi, and boards that need a different setup can overwrite the
settings in board.dts.

Shawn

> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts   | 4 ++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi      | 6 ------
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
> index 91eef97..a3f8cf1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dts
> @@ -133,6 +133,8 @@
>  &usdhc1 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> +	assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
> +	assigned-clock-rates = <200000000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc1>;
>  	bus-width = <4>;
> @@ -149,6 +151,8 @@
>  
>  /* SD */
>  &usdhc2 {
> +	assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
> +	assigned-clock-rates = <200000000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc2>;
>  	bus-width = <4>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index 88dd9132..d3d26cc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -137,6 +137,8 @@
>  };
>  
>  &usdhc1 {
> +	assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
> +	assigned-clock-rates = <200000000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc1>;
>  	bus-width = <8>;
> @@ -147,6 +149,8 @@
>  };
>  
>  &usdhc2 {
> +	assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
> +	assigned-clock-rates = <200000000>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc2>;
>  	bus-width = <4>;
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 2d69f1a..9646a41 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -368,8 +368,6 @@
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_PER_CLK>,
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC0_HCLK>;
>  			clock-names = "ipg", "per", "ahb";
> -			assigned-clocks = <&clk IMX_CONN_SDHC0_CLK>;
> -			assigned-clock-rates = <200000000>;
>  			power-domains = <&pd IMX_SC_R_SDHC_0>;
>  			status = "disabled";
>  		};
> @@ -383,8 +381,6 @@
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_PER_CLK>,
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC1_HCLK>;
>  			clock-names = "ipg", "per", "ahb";
> -			assigned-clocks = <&clk IMX_CONN_SDHC1_CLK>;
> -			assigned-clock-rates = <200000000>;
>  			power-domains = <&pd IMX_SC_R_SDHC_1>;
>  			fsl,tuning-start-tap = <20>;
>  			fsl,tuning-step= <2>;
> @@ -400,8 +396,6 @@
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_PER_CLK>,
>  				 <&conn_lpcg IMX_CONN_LPCG_SDHC2_HCLK>;
>  			clock-names = "ipg", "per", "ahb";
> -			assigned-clocks = <&clk IMX_CONN_SDHC2_CLK>;
> -			assigned-clock-rates = <200000000>;
>  			power-domains = <&pd IMX_SC_R_SDHC_2>;
>  			status = "disabled";
>  		};
> -- 
> 2.7.4
> 
