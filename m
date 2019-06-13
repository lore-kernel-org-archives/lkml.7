Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92781C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B05E206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="drEIs2S/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfFMPfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:35:31 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4110 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfFMKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:22:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d022400001b>; Thu, 13 Jun 2019 03:22:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 13 Jun 2019 03:22:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 13 Jun 2019 03:22:56 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Jun
 2019 10:22:54 +0000
Subject: Re: [PATCH v4 1/2] arm64: tegra: add ACONNECT, ADMA and AGIC nodes
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560420972-22350-1-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <0549eb4c-a182-3181-46fe-62466e12e490@nvidia.com>
Date:   Thu, 13 Jun 2019 11:22:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560420972-22350-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560421377; bh=fCmTU224eAkT7uYPWe9CPZq2HADRYEei6cu60EAx61M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=drEIs2S/e20X1/dolYgKqvNZlkL93jiwFm3aZ8veo3OFbSlKVCEQqBJtBqSzDqdU5
         T2+jpJeb4+ELLlZcXrmtMD9hc/ilM4rul4R87PNM9sOiNx5M713MGpbPwg1L69lFM1
         zrPs1SziP74HYf5DDcMyzVpUQGfTtHA5Bw0Yw9QgE4427Mmrcu0p7LCwL5aZ8QU1S7
         xvzaxhBYIvOX4BfCpTw3I/1V+ucx66/SYjEIDxqu802nU+YRjICjI54+a6FaRwexK1
         MnWskRyxgB4ihUA0BUDKHad0m83RbavP24UNM83Z6ozhwrsErU807PluT8H6NQaTgf
         TyWcH3JXLbrDw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/06/2019 11:16, Sameer Pujar wrote:
> Add DT nodes for following devices on Tegra186 and Tegra194
>  * ACONNECT
>  * ADMA
>  * AGIC
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  changes in current revision
>   * node names changed for aconnect and agic
>   * size value updated for ranges property in aconnect node
> 
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 67 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 67 ++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 426ac0b..017fddd 100644
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
> +		ranges = <0x02900000 0x0 0x02900000 0x1fffff>;

Nearly, not quite. See my last message.

Cheers
Jon

-- 
nvpublic
