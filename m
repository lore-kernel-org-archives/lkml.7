Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241DCC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCEF20820
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565618172;
	bh=Rnpz2gfo/cmld6mdLNQ9CgYpB9S8DKG9sxArptaImhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GKYcJkMnVLgNGfyPNHzagAPtawLzoyd+KGyroVYV8ygL6LptDaINLEHedTvsRJB9R
	 q5gY3XJ/sHwycQ8ZGozCQ0YbUT5i5jzgbPswd9jgWAlmZJK6QwuH4fmbsTFd0K/jIZ
	 4LOb5g4ADDvV/v02h/QmYk52Xoa0h/EGyoREUua8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfHLN4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfHLN4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:56:10 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC9020684;
        Mon, 12 Aug 2019 13:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565618169;
        bh=Rnpz2gfo/cmld6mdLNQ9CgYpB9S8DKG9sxArptaImhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0g0G7ylCN34wslN5FzloLxtVcKILiuGVQNsHbkMZCHOJ66a9bAYR+RWpRh8Sk6+Z
         +jtxcogP3ka/c8kZ7xIzH3acga9W7VyetXtqvn5YuX6V3ezEPIsRD+hRJi0OuJxbby
         O49yjG8ZiVInZeQQBpJHnik9268uRynhVOodTEb8=
Date:   Mon, 12 Aug 2019 15:55:59 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        xiaobo.xie@nxp.com, jiafei.pan@nxp.com,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        yangbo.lu@nxp.com, Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: Re: [PATCH v4] arm64: dts: ls1028a: Add esdhc node in dts
Message-ID: <20190812135556.GG27041@X250>
References: <20190805102641.3732-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805102641.3732-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 06:26:41PM +0800, Yinbo Zhu wrote:
> From: Ashish Kumar <Ashish.Kumar@nxp.com>
> 
> This patch is to add esdhc node and enable SD UHS-I,
> eMMC HS200 for ls1028ardb/ls1028aqds board.
> 
> Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v4:
> 		put esdhc 'status' at end of property list.
> 		sort the nodes in unit-address
> 		Use IRQ_TYPE_LEVEL_HIGH represent 0x4 in "interrupts = <0 28 0x4>"
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |  8 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 13 +++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    | 27 +++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index de6ef39..5e14e5a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -95,6 +95,14 @@
>  	status = "okay";
>  };
>  
> +&esdhc {
> +	status = "okay";
> +};
> +
> +&esdhc1 {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 9fb9113..12c9cd3 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -83,6 +83,19 @@
>  	};
>  };
>  
> +&esdhc {
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +	status = "okay";
> +	};

Fix indent.

> +
> +&esdhc1 {
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +	};

Ditto

Shawn

> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 7975519..f299075 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -245,6 +245,33 @@
>  			status = "disabled";
>  		};
>  
> +		esdhc: mmc@2140000 {
> +			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +			reg = <0x0 0x2140000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <0>; /* fixed up by bootloader */
> +			clocks = <&clockgen 2 1>;
> +			voltage-ranges = <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			little-endian;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		esdhc1: mmc@2150000 {
> +			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +			reg = <0x0 0x2150000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
> +			clock-frequency = <0>; /* fixed up by bootloader */
> +			clocks = <&clockgen 2 1>;
> +			voltage-ranges = <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			broken-cd;
> +			little-endian;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
>  		duart0: serial@21c0500 {
>  			compatible = "fsl,ns16550", "ns16550a";
>  			reg = <0x00 0x21c0500 0x0 0x100>;
> -- 
> 2.9.5
> 
