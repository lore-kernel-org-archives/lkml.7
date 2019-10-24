Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77769CA9EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8372084B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 02:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P0sNyB9z";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jXYYdZMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437064AbfJXCbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 22:31:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437045AbfJXCbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:31:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CEBE561068; Thu, 24 Oct 2019 02:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571884260;
        bh=9/HyGx8k6OZA11usgkO3f0IPDOmioYN0Pq3Ym6dXEsA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P0sNyB9znt9SvVsporJy7QUt6imvMg2AyomQnEcEV6znvzIAQ3SdBP/Bxl8LwMRLc
         lR6UJS4DBlo3Htffb1p3pBqWaGrD296ZNDV8TSdBnfpI+G70cblAtANLFgPkhdIWSK
         OOfxvU8H2kAiQ8QUU07Pr4Ykn5GHtEFCtpa2u8/w=
Received: from [10.79.136.17] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E0C8660FF9;
        Thu, 24 Oct 2019 02:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571884259;
        bh=9/HyGx8k6OZA11usgkO3f0IPDOmioYN0Pq3Ym6dXEsA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jXYYdZMVdiR5wVf0WCY+2dpxl07S0Q1gxKQwuNi3iJMP8ua4C5eZC9OwBG8+FrB5x
         ps0zlSbu2wCddbnODtiai+33mQl4UkVuGZ2sebiJZIF73DWGBokY8LUuQOf8TblTwH
         aPjMfpJJZsmVjPVZKL/nSMOgkieEy2oU3P6v4U60=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0C8660FF9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v3 05/11] arm64: dts: qcom: sc7180: Add cmd_db reserved
 area
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Maulik Shah <mkshah@codeaurora.org>,
        linux-arm-msm-owner@vger.kernel.org
References: <20191023090219.15603-1-rnayak@codeaurora.org>
 <20191023090219.15603-6-rnayak@codeaurora.org>
 <5bb4acef7f11af9e9c4016743d668f57@codeaurora.org>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <8d361445-d764-1653-76a3-05df25339c0c@codeaurora.org>
Date:   Thu, 24 Oct 2019 08:00:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5bb4acef7f11af9e9c4016743d668f57@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/2019 5:46 PM, Sibi Sankar wrote:
> On 2019-10-23 14:32, Rajendra Nayak wrote:
>> From: Maulik Shah <mkshah@codeaurora.org>
>>
>> Command_db provides mapping for resource key and address managed
>> by remote processor. Add cmd_db reserved memory area.
>>
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index f17684148595..dfa49ef2bce0 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -32,6 +32,18 @@
>>          };
>>      };
>>
>> +    reserved_memory: reserved-memory {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +
>> +        cmd_db: reserved-memory@80820000 {
> 
> aop_cmd_db_mem: memory@80820000 {
> please use ^^ instead

right, I thought I looked up sm8150.dtsi to make sure
the labeling for various things is consistent, but
maybe i didn't. Will fix. Thanks.

> 
>> +            reg = <0x0 0x80820000 0x0 0x20000>;
>> +            compatible = "qcom,cmd-db";
>> +            no-map;
>> +        };
>> +    };
>> +
>>      cpus {
>>          #address-cells = <2>;
>>          #size-cells = <0>;
> 

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
