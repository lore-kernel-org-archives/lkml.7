Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C3EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A44021897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="RjQWf++o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfH3MJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:09:36 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:51085 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfH3MJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5KAK3GGIAW+vTDP3zQ/cvvjRXZvCcS3poVmmyqNR8xw=; b=RjQWf++oCH1waNajLdDE9OfH8l
        mpzggLTChCK+Ya8xO9qqPX13bG/MxSHfGYwVa8iQ+lxCnNudaybCBZV0Od/LBc/euBGjxdHrmYAqb
        dNOxRIyLCG1Et2bvbd3ciN3bCoUxJQX0XJqa7mizJGZi92LibkdV+fOt3nXOCtr/NnhN6n5nZGxy6
        UD6iJA2Bgsn0wXDkwUPs2NDJPXsvirQhot+7mxmE8AqTr83mtojDeov3ZrWvHwTgGtf5OhF5IdL1O
        eXzfZ2zKfFDJvsRS26XJGW/HP3oAlriuGA369xiZQDZaDsCbNexNVTP9uuRJJh77IGXYaRscEPiMI
        qxb+WFOg==;
Received: from [193.209.96.43] (helo=[10.21.26.179])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1i3fif-0005DG-2n; Fri, 30 Aug 2019 15:09:33 +0300
Subject: Re: [PATCH 6/7] arm64: tegra: Add DT node for T194 SMMU
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        avanbrunt@nvidia.com, thomasz@nvidia.com, olof@lixom.net,
        jtukkinen@nvidia.com, mperttunen@nvidia.com
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-7-git-send-email-vdumpa@nvidia.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <ba06d6b8-c6b9-f9bd-c2c1-d5e39292f67d@kapsi.fi>
Date:   Fri, 30 Aug 2019 15:09:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567118827-26358-7-git-send-email-vdumpa@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.8.2019 1.47, Krishna Reddy wrote:
> Add DT node for T194 SMMU to enable SMMU support.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 75 ++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index d906958..ad509bb 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1401,6 +1401,81 @@
>   			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-prefetchable memory (3GB) */
>   	};
>   
> +	smmu: iommu@12000000 {
> +		compatible = "nvidia,smmu-v2";

Should we have a compatibility string like "nvidia,tegra194-smmu" so 
that we can have other chips with SMMUv2 that could be different?

Mikko

> +		reg = <0 0x12000000 0 0x800000>,
> +		      <0 0x11000000 0 0x800000>,
> +		      <0 0x10000000 0 0x800000>;
> +		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +		stream-match-mask = <0x7f80>;
> +		#global-interrupts = <1>;
> +		#iommu-cells = <1>;
> +	};
> +
>   	sysram@40000000 {
>   		compatible = "nvidia,tegra194-sysram", "mmio-sram";
>   		reg = <0x0 0x40000000 0x0 0x50000>;
> 
