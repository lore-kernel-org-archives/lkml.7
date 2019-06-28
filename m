Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AB2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBAF208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PmTFMMrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfF1DiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:38:11 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52860 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfF1DiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:38:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5S3c3sP008526;
        Thu, 27 Jun 2019 22:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561693083;
        bh=dzmOZZff9xHTE8ZakTRvyW2vPBFPMXEZjI/07/tzJdY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PmTFMMrFC0XpLwzqjUEL99pdWFb5xuITGQNnRtjaNWfs6PkLQk5p4AInIwbgfDvQO
         qEK44L9+NeiThBMQ/KTdxbg3pMdQGxzLkCOz2w1K4RYZL78Jn0JuUH4TU/PGNhMXtj
         wYQl7Y+mlO72LTLWVNITvQtr+MGIG6VdR1bNrjR8=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5S3c3bh058049
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 22:38:03 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 27
 Jun 2019 22:38:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 27 Jun 2019 22:38:03 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5S3c0s2064279;
        Thu, 27 Jun 2019 22:38:01 -0500
Subject: Re: [PATCH v2] arm64: Kconfig.platforms: Enable GPIO_DAVINCI for
 ARCH_K3
To:     Nishanth Menon <nm@ti.com>
CC:     <t-kristo@ti.com>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <shawnguo@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lokeshvutla@ti.com>
References: <20190627110920.15099-1-j-keerthy@ti.com>
 <20190627143208.eeca4xyygml7s4n3@kahuna>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <39f5e726-8542-b650-3bdb-7542e8fab8ac@ti.com>
Date:   Fri, 28 Jun 2019 09:08:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627143208.eeca4xyygml7s4n3@kahuna>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/06/19 8:02 PM, Nishanth Menon wrote:
> On 16:39-20190627, Keerthy wrote:
>> Enable GPIO_DAVINCI and related configs for TI K3 AM6 platforms.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Changes in v2:
>>
>>    * Enabling configs in Kconfig.platforms file instead of defconfig.
>>    * Removed GPIO_DEBUG config.
>>
>>   arch/arm64/Kconfig.platforms | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 4778c775de1b..6e43a0995ed4 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -97,6 +97,8 @@ config ARCH_K3
>>   	select TI_SCI_PROTOCOL
>>   	select TI_SCI_INTR_IRQCHIP
>>   	select TI_SCI_INTA_IRQCHIP
>> +	select GPIO_SYSFS
>> +	select GPIO_DAVINCI
> 
> 
> Could you help explain the logic of doing this? commit message is
> basically the diff in English. To me, this does NOT make sense.
> 
> I understand GPIO_DAVINCI is the driver compatible, but we cant do this for
> every single SoC driver that is NOT absolutely mandatory for basic
> functionality.

In case of ARM64 could you help me find the right place to enable
such SoC specific configs?

> 
> Also keep in mind the impact to arm64/configs/defconfig -> every single
> SoC in the arm64 world will be now rebuild with GPIO_SYSFS.. why force
> that?

This was the practice in arm32 soc specific configs like 
omap2plus_defconfig. GPIO_SYSFS was he only way to validate. Now i 
totally understand your concern about every single SoC rebuilding but 
now where do we need to enable the bare minimal GPIO_DAVINCI config?

v1 i received feedback from Tero to enable in Kconfig.platforms. Hence i 
shifted to this approach.

> 
