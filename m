Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E94AC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CF2206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YVINHl5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406913AbfFLBpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:45:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56402 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405767AbfFLBpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:45:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5C1iw8g037740;
        Tue, 11 Jun 2019 20:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560303898;
        bh=2NCPKUbRarLqkAlzqq9qkjBHRnMGcpEhq9GuD3nrYSI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YVINHl5LXFoyn566/EfAsjdlqLMXy6I4GY4r/cdxwk/sWREBjZquPX/4r4q0VpoCs
         7d4SzNulgxzBwJCXZ0EU+FYWINkkSDIuyNVq8SbunYKNztH6GBKO41RAVjECssVGE4
         0c2E1UttRWoby5Qcx+o2Vs6TmW3wdeVtEOIwa1Ho=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5C1iwc0072627
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 20:44:58 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 20:44:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 20:44:58 -0500
Received: from [172.22.218.126] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5C1isWO065965;
        Tue, 11 Jun 2019 20:44:55 -0500
Subject: Re: [PATCH] arm64: configs: Enable GPIO_DAVINCI
To:     Tero Kristo <t-kristo@ti.com>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <shawnguo@kernel.org>
CC:     <lokeshvutla@ti.com>, <nm@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190605061401.25806-1-j-keerthy@ti.com>
 <09a60289-2747-a570-54e0-822b0ea4b01a@ti.com>
From:   keerthy <j-keerthy@ti.com>
Message-ID: <f32dc8da-7c17-6cb4-be31-53a59b7cea35@ti.com>
Date:   Wed, 12 Jun 2019 07:14:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <09a60289-2747-a570-54e0-822b0ea4b01a@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/2019 11:49 PM, Tero Kristo wrote:
> On 05/06/2019 09:14, Keerthy wrote:
>> Enable GPIO_DAVINCI and related configs for TI K3 AM6 platforms.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>   arch/arm64/configs/defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index d1b72f99e2f4..57d7a4c207bd 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -385,6 +385,9 @@ CONFIG_PINCTRL_QCS404=y
>>   CONFIG_PINCTRL_QDF2XXX=y
>>   CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>>   CONFIG_PINCTRL_SDM845=y
>> +CONFIG_DEBUG_GPIO=y
> 
> Why DEBUG_GPIO?

Okay this can be left out.

> 
>> +CONFIG_GPIO_SYSFS=y
> 
> Also, why GPIO_SYSFS?

This has been there for pretty much all the SoCs in the past
and one of the ways to validate GPIOs are functional. This is very much 
needed IMHO.

> 
> Both of the above are nice for debugging purposes, but should not be 
> enabled by default imho, as they are not needed by drivers.
> 
>> +CONFIG_GPIO_DAVINCI=y
> 
> I think you should not modify defconfig, rather add these as platform 
> required features under arch/arm64/Kconfig.platforms?

I observed CONFIG_RESET_TI_SCI, CONFIG_TI_SCI_PROTOCOL which are 
platform specific in the defconfig and added them here. Already there 
are n number of GPIO config options as well under defconfig. If the norm 
is to add selects under arch/arm64/Kconfig.platforms then i am fine with 
that as well. Kindly let me know.

- Keerthy
> 
> -Tero
> 
>>   CONFIG_GPIO_DWAPB=y
>>   CONFIG_GPIO_MB86S7X=y
>>   CONFIG_GPIO_PL061=y
>>
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. 
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
