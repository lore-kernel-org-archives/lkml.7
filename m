Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D08CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DCC2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbfJVR46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:56:58 -0400
Received: from [217.140.110.172] ([217.140.110.172]:58984 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJVR45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:56:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C71161B;
        Tue, 22 Oct 2019 10:56:32 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CE643F718;
        Tue, 22 Oct 2019 10:56:30 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] dt-bindings: arm-smmu: Add binding for Tegra194
 SMMU
To:     Krishna Reddy <vdumpa@nvidia.com>
Cc:     joro@8bytes.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com, yhsu@nvidia.com,
        snikam@nvidia.com, praithatha@nvidia.com, talho@nvidia.com,
        avanbrunt@nvidia.com, thomasz@nvidia.com, olof@lixom.net,
        jtukkinen@nvidia.com, mperttunen@nvidia.com, nicolinc@nvidia.com,
        Rob Herring <robh@kernel.org>
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
 <1571441492-21919-4-git-send-email-vdumpa@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <76513c1a-2fec-0b84-a9fb-f485f5fcbb78@arm.com>
Date:   Tue, 22 Oct 2019 18:56:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1571441492-21919-4-git-send-email-vdumpa@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2019 00:31, Krishna Reddy wrote:
> Add binding for NVIDIA's Tegra194 Soc SMMU that is based
> on ARM MMU-500.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 4 ++++

Rob (+cc) is in the process of converting the SMMU bindings to schema, 
so we might need a bit of coordination here...

Robin.

>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 3133f3b..1d72fac 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -31,6 +31,10 @@ conditions.
>                     as below, SoC-specific compatibles:
>                     "qcom,sdm845-smmu-500", "arm,mmu-500"
>   
> +                  NVIDIA SoCs that use more than one ARM MMU-500 together
> +                  needs following SoC-specific compatibles along with "arm,mmu-500":
> +                  "nvidia,tegra194-smmu"
> +
>   - reg           : Base address and size of the SMMU.
>   
>   - #global-interrupts : The number of global interrupts exposed by the
> 
