Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D73C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607C22171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N7csTN6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfDLICD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:02:03 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1962 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDLICB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:02:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb045e80000>; Fri, 12 Apr 2019 01:01:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Apr 2019 01:02:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Apr 2019 01:02:00 -0700
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 12 Apr
 2019 08:02:00 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 2105641B97; Fri, 12 Apr 2019 11:01:58 +0300 (EEST)
Date:   Fri, 12 Apr 2019 11:01:58 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] ARM: dts: tegra30: Add External Memory Controller
 node
Message-ID: <20190412080158.GG12975@pdeschrijver-desktop.Nvidia.com>
References: <20190411230221.31362-1-digetx@gmail.com>
 <20190411230221.31362-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190411230221.31362-4-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555056104; bh=BK9NQTQz9YD156sUw/1DYb+sHj7A+1jttdjImZHJPMY=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=N7csTN6U6jTwNKcmPlm5U0gR8648fg1M7H+WLjqihekMHTGFNRz32FjVweZyuO74G
         rXmWQ43HBnplLtqmI03ftYDLsQ/Bib6w8o1vq0az6Urzn5a5c/7CpHUI3aU3v7uDiy
         xgkwvaM9dYOCZUS4x99b8A0+m63FAyvnicndzuqhSBAhV3Wnv26ZTATnphgixDTwE5
         U8ix6cAlcLlJZv23/mbHZpgfdMiYwnbqNd7VB4X96Jp0FzOxKf8P4B6eZ7T3d08gF4
         +goVaiKxEY6Sjc5gcrhLgQ/JeT9Thq+0CCNwpYTIjIZX0OIOPsF8JyIetbkvbTrFsB
         UOzV8sKgEmMOg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 02:02:21AM +0300, Dmitry Osipenko wrote:
> Add Add External Memory Controller node to the device-tree.
> 

One 'Add' is enough I think :)

Peter.

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/boot/dts/tegra30.dtsi     | 11 +++++++++++
>  drivers/memory/tegra/tegra30-emc.c |  3 ++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
> index e074258d4518..92c4aeafab29 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -732,6 +732,17 @@
>  		#reset-cells = <1>;
>  	};
>  
> +	memory-controller@7000f400 {
> +		compatible = "nvidia,tegra30-emc";
> +		reg = <0x7000f400 0x400>;
> +		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&tegra_car TEGRA30_CLK_EMC>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		nvidia,memory-controller = <&mc>;
> +	};
> +
>  	fuse@7000f800 {
>  		compatible = "nvidia,tegra30-efuse";
>  		reg = <0x7000f800 0x400>;
> diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
> index 38ebdb076ccd..defdb38bde54 100644
> --- a/drivers/memory/tegra/tegra30-emc.c
> +++ b/drivers/memory/tegra/tegra30-emc.c
> @@ -980,7 +980,8 @@ static long emc_round_rate(unsigned long rate,
>  	}
>  
>  	if (!timing) {
> -		dev_err(emc->dev, "no timing for rate %lu\n", rate);
> +		dev_err(emc->dev, "no timing for rate %lu min %lu max %lu\n",
> +			rate, min_rate, max_rate);
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.21.0
> 
