Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75103C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD5C23D29
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nKHJ41EB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfFDNXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:23:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40040 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfFDNXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:23:09 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54DMl4n121195;
        Tue, 4 Jun 2019 08:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559654567;
        bh=QmemnxW2n5NUE/qgZlfL+6iRsLZV0ClQaFreagH1yes=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nKHJ41EBikRMi5vGzmffvE6MVHK7JXEl3pe752f6MhtcWcEPDcRTNDI0xMNxBwhFm
         caZzlTiKGpzRD5Oc78ONCIuzF7d9CNifx67t1lVgAqNFrocnafBFJXpj7AxfQ7GXEg
         1Ek9HugNFf8C68L0OrDz/bbXX3VoXbE6KPlkhRLg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54DMls6058955
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 08:22:47 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 08:22:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 08:22:46 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54DMisS123230;
        Tue, 4 Jun 2019 08:22:44 -0500
Subject: Re: [PATCH] arm64: arch_k3: Fix kconfig dependency warning
To:     Yuehaibing <yuehaibing@huawei.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <marc.zyngier@arm.com>,
        <lokeshvutla@ti.com>, <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190510035255.27568-1-yuehaibing@huawei.com>
 <a9ea9cf2-71d0-d8f8-3139-33f1945520c5@huawei.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <dd0e40b3-bf1d-12b4-3396-458c1aec9657@ti.com>
Date:   Tue, 4 Jun 2019 16:22:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a9ea9cf2-71d0-d8f8-3139-33f1945520c5@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, this has sort of slipped through. I can pick this up and queue 
towards 5.2-rc fixes.

-Tero

On 04/06/2019 11:33, Yuehaibing wrote:
> Hi all,
> 
> Friendly ping:
> 
> Who can take this?
> 
> On 2019/5/10 11:52, YueHaibing wrote:
>> Fix Kbuild warning when SOC_TI is not set
>>
>> WARNING: unmet direct dependencies detected for TI_SCI_INTA_IRQCHIP
>>    Depends on [n]: TI_SCI_PROTOCOL [=y] && SOC_TI [=n]
>>    Selected by [y]:
>>    - ARCH_K3 [=y]
>>
>> Fixes: 009669e74813 ("arm64: arch_k3: Enable interrupt controller drivers")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   arch/arm64/Kconfig.platforms | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 42eca65..9d1292f 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -88,6 +88,7 @@ config ARCH_K3
>>   	bool "Texas Instruments Inc. K3 multicore SoC architecture"
>>   	select PM_GENERIC_DOMAINS if PM
>>   	select MAILBOX
>> +	select SOC_TI
>>   	select TI_MESSAGE_MANAGER
>>   	select TI_SCI_PROTOCOL
>>   	select TI_SCI_INTR_IRQCHIP
>>
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
