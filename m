Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7C7C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B162085A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OMOhoz7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfFTIfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:35:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12696 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfFTIfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:35:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0b453e0000>; Thu, 20 Jun 2019 01:35:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 01:35:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Jun 2019 01:35:11 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 08:35:09 +0000
Subject: Re: [PATCH v6 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560945082-24554-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <953850e1-c562-65bd-a7a1-75d31d4cd154@nvidia.com>
Date:   Thu, 20 Jun 2019 09:35:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560945082-24554-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561019710; bh=u8ruBWZaG4+DMY43KeT5wsAt3fh+0m2tf7B99LSbLp4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OMOhoz7bhWzwwLx0CLZJzJG7UgTNjRaOi+uLprovtsMM+D6Nu8qZfWa5ebrt9JCoM
         2mV3Uz+unUAnZ4eq4gBTw7ld6yV+8rk+1o6naD2MQ+RM/1aGh/f5oqhTt8QbJtgKxN
         q8PzS8T/hNK9vuRu0e6m2LUX4//tLvdvHNF0KTenvT8MyvfRIQ+wLMMmz3/XCDpzzQ
         3utDxz1x8cmT3jJqNvJdynhrlYFHQX/vYPi0Iih//HFs4kvjZAJ4l0XNS4oZOBF/3z
         mBPNzsh42Q6gukUKLLKQtSX+rh5rEvAha+CfzAq5CeYY0Eq1fxC2sSL0RPf8hcK+T1
         E7/xDaevtRotg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/06/2019 12:51, Sameer Pujar wrote:
> Add DT nodes for following devices on Tegra186 and Tegra194
>  * ACONNECT
>  * ADMA
>  * AGIC
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  changes in current revision
>    * updated ranges property for aconnect
>    * renamed agic node
> 
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 426ac0b..4bb765d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -1295,4 +1295,71 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent = <&gic>;
>  	};
> +
> +	aconnect {
> +		compatible = "nvidia,tegra210-aconnect";
> +		clocks = <&bpmp TEGRA186_CLK_APE>,
> +			 <&bpmp TEGRA186_CLK_APB2APE>;
> +		clock-names = "ape", "apb2ape";
> +		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_AUD>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x02900000 0x0 0x02900000 0x200000>;
> +		status = "disabled";
> +
> +		dma-controller@2930000 {
> +			compatible = "nvidia,tegra186-adma";
> +			reg = <0x02930000 0x20000>;
> +			interrupt-parent = <&agic>;
> +			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			clocks = <&bpmp TEGRA186_CLK_AHUB>;
> +			clock-names = "d_audio";
> +			status = "disabled";
> +		};
> +
> +		agic: interrupt-controller@2a40000 {
> +			compatible = "nvidia,tegra210-agic";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x02a41000 0x1000>,
> +			      <0x02a42000 0x2000>;
> +			interrupts = <GIC_SPI 145
> +				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks = <&bpmp TEGRA186_CLK_APE>;
> +			clock-names = "clk";
> +			status = "disabled";
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index c77ca21..d6aee0d 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1054,4 +1054,71 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent = <&gic>;
>  	};
> +
> +	aconnect {
> +		compatible = "nvidia,tegra210-aconnect";
> +		clocks = <&bpmp TEGRA194_CLK_APE>,
> +			 <&bpmp TEGRA194_CLK_APB2APE>;
> +		clock-names = "ape", "apb2ape";
> +		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_AUD>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x02900000 0x0 0x02900000 0x200000>;
> +		status = "disabled";
> +
> +		dma-controller@2930000 {
> +			compatible = "nvidia,tegra186-adma";
> +			reg = <0x02930000 0x20000>;
> +			interrupt-parent = <&agic>;
> +			interrupts =  <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
> +				      <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			clocks = <&bpmp TEGRA194_CLK_AHUB>;
> +			clock-names = "d_audio";
> +			status = "disabled";
> +		};
> +
> +		agic: interrupt-controller@2a40000 {
> +			compatible = "nvidia,tegra210-agic";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg = <0x02a41000 0x1000>,
> +			      <0x02a42000 0x2000>;
> +			interrupts = <GIC_SPI 145
> +				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			clocks = <&bpmp TEGRA194_CLK_APE>;
> +			clock-names = "clk";
> +			status = "disabled";
> +		};
> +	};
>  };
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
