Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6399CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD82D2190F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mV3/u4Ok";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WVzDJ8sw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfKDGFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:05:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:38476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKDGFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:05:05 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 669F160931; Mon,  4 Nov 2019 06:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572847504;
        bh=ObKudLAi9uqkjt2DeiRKuSbPAWi11wPeXW5aEddSJKg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mV3/u4OkERJfNwJKgNlOPbIXmtZpd0oyVa1Ji4pAqXEU38KxpJ3/mdST48nBMZ8rc
         eJWHywAigFXKNYQix65WXgsff4bkVvxXxQc28VJwsXsnKEyCKXFYAbcv19wV7135jV
         0OxdLDcv4b9CP0tYc0C8jDBkFDxDrvoCbfIb4FPM=
Received: from [10.79.136.17] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCCAC60931;
        Mon,  4 Nov 2019 06:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572847503;
        bh=ObKudLAi9uqkjt2DeiRKuSbPAWi11wPeXW5aEddSJKg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WVzDJ8swpKQeJNFbOYyOSZ4V5Yvb/s8aE6dJwHs+Q33At0JgntTr3NEzH2GyEhTBp
         KO5RiIPnMMe/KryFmuYTzxnp8TBYe6p5NEL2w2xq9QstMFLoUri3DV/jBkfb89z0C4
         f/iCJep6i8oRmu14iltQv7ilxDvhACX+MDWvWh8g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCCAC60931
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 03/11] dt-bindings: arm-smmu: update binding for qcom
 sc7180 SoC
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Joerg Roedel <joro@8bytes.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20191023090219.15603-1-rnayak@codeaurora.org>
 <20191023090219.15603-4-rnayak@codeaurora.org> <20191025195143.GA31658@bogus>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <7007719e-c038-02b0-7729-b654e008f627@codeaurora.org>
Date:   Mon, 4 Nov 2019 11:34:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025195143.GA31658@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2019 1:21 AM, Rob Herring wrote:
> On Wed, Oct 23, 2019 at 02:32:11PM +0530, Rajendra Nayak wrote:
>> Add the soc specific compatible for sc7180 smmu-500
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> ---
>>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> index 3133f3ba7567..347869807cf2 100644
>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
>> @@ -30,6 +30,7 @@ conditions.
>>                     Qcom SoCs implementing "arm,mmu-500" must also include,
>>                     as below, SoC-specific compatibles:
>>                     "qcom,sdm845-smmu-500", "arm,mmu-500"
>> +                  "qcom,sc7180-smmu-500", "arm,mmu-500"
> 
> This is now a schema file in my tree.

sure, will rebase on your for-next when I repost.

> 
>>   
>>   - reg           : Base address and size of the SMMU.
>>   
>> -- 
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
>> of Code Aurora Forum, hosted by The Linux Foundation
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
