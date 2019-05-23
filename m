Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA29C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C482075E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558597135;
	bh=PDeQ/R6EFXXI6bmG+2plkabUTkZx6Xpn/gVapHNA3DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qOiJMNLjw6CI/VsCz0wNNRIM/UZ5xx3Cwz4rjwKLD9mqpTOaOt+QTMFttRhI7XhNo
	 xmwEWLQYn03p/XF56nhKF2dXSY6fEzd+++XzNkcLPMCdrIpYcHvkILnuj+fiWN7Tpg
	 bjeCuQNNLL8AxYRZIe6NePpZ2N1fw7iLdrMHFoeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbfEWHix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:38:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:39228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfEWHit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:38:49 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8E482075E;
        Thu, 23 May 2019 07:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558597128;
        bh=PDeQ/R6EFXXI6bmG+2plkabUTkZx6Xpn/gVapHNA3DQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7DoqJN2tSJu1utHXlZ/Uk9R23K9mhPPKEIMvUAwL23Qfy5vM6Xr98X0r923XXkRE
         wy7k9kJcj2h3C5v20tYNfAQ34HDISe6d248XLL5gQ+D32V1phD/sXMaBTIvhRxu0hf
         8SRKuiWIwfdzus11Ls+EacvJN1RcPhaRs1MbU2Ko=
Date:   Thu, 23 May 2019 15:37:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        xiaobo.xie@nxp.com, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        yangbo.lu@nxp.com, jiafei.pan@nxp.com,
        Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: ls1028a: Add esdhc node in dts
Message-ID: <20190523073744.GG9261@dragon>
References: <20190515040046.9230-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515040046.9230-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 12:00:46PM +0800, Yinbo Zhu wrote:
> From: Ashish Kumar <Ashish.Kumar@nxp.com>
> 
> This patch is to add esdhc node and enable SD UHS-I,
> eMMC HS200 for ls1028ardb/ls1028aqds board.
> 
> Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v2:
> 		Update the patch title
> 		Add a commont in dts code
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |    8 ++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts |   13 ++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi    |   27 +++++++++++++++++++++
>  3 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> index 14c79f4..180e5d2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
> @@ -42,6 +42,14 @@
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
> index f86b054..1bfaf42 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -30,6 +30,19 @@
>  	};
>  };
>  
> +&esdhc {
> +	status = "okay";

We usually put 'status' at the end of property list.

> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +	};

Bad indentation.

> +
> +&esdhc1 {
> +	status = "okay";
> +	mmc-hs200-1_8v;
> +	};
> +
>  &i2c0 {
>  	status = "okay";
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 2896bbc..5c7546f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -274,6 +274,33 @@
>  			status = "disabled";
>  		};
>  
> +		esdhc: esdhc@2140000 {

'mmc' for node name, and the node should be sorted in unit-address.

> +			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +			reg = <0x0 0x2140000 0x0 0x10000>;
> +			interrupts = <0 28 0x4>; /* Level high type */

interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;

> +			clock-frequency = <0>; /* fixed up by bootloader */
> +			clocks = <&clockgen 2 1>;
> +			voltage-ranges = <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			little-endian;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		esdhc1: esdhc@2150000 {
> +			compatible = "fsl,ls1028a-esdhc", "fsl,esdhc";
> +			reg = <0x0 0x2150000 0x0 0x10000>;
> +			interrupts = <0 63 0x4>; /* Level high type */
> +			clock-frequency = <0>; /* fixed up by bootloader */
> +			clocks = <&clockgen 2 1>;
> +			voltage-ranges = <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			broken-cd;

Shouldn't this one be a board level property?

Shawn

> +			little-endian;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
>  		sata: sata@3200000 {
>  			compatible = "fsl,ls1028a-ahci";
>  			reg = <0x0 0x3200000 0x0 0x10000>,
> -- 
> 1.7.1
> 
