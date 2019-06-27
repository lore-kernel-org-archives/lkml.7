Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA506C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5C820828
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 14:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfF0Oaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:30:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfF0Oaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 10:30:46 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3BB1FC78B537B291C284;
        Thu, 27 Jun 2019 22:30:43 +0800 (CST)
Received: from [127.0.0.1] (10.65.87.206) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 27 Jun 2019
 22:30:38 +0800
Subject: Re: [PATCH] irqchip/gic: Add dependency for ARM_GIC
To:     Marc Zyngier <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <linus.walleij@linaro.org>
References: <1561644707-25191-1-git-send-email-xiaojiangfeng@huawei.com>
 <2934608c-9eb6-76b0-ff34-dd22bf670318@arm.com>
CC:     <linux-kernel@vger.kernel.org>
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <a6c1662b-0713-1116-baf5-bff520d03187@huawei.com>
Date:   Thu, 27 Jun 2019 22:30:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <2934608c-9eb6-76b0-ff34-dd22bf670318@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.87.206]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/6/27 22:20, Marc Zyngier wrote:
> On 27/06/2019 15:11, Jiangfeng Xiao wrote:
>> Not every arch has ARM_GIC, it is strange
>> to see ARM_GIC_MAX_NR in the .config file
>> of the x86 and IA-64 architecture. so fix
>> build by adding necessary dependency.
>>
>> Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
>> ---
>>  drivers/irqchip/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 659c5e0..e338b471 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -19,6 +19,7 @@ config ARM_GIC_PM
>>  
>>  config ARM_GIC_MAX_NR
>>  	int
>> +	depends on ARM_GIC
>>  	default 2 if ARCH_REALVIEW
>>  	default 1
>>  
>>
> 
> Isn't that the patch[1] that has already been in -next for the past 10 
> days or so?
> 
> Thanks,
> 
> 	M.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-next&id=702655234dd1d07e76f9bff9575e438c969fc32c
> 

I am very sorry. I thought that this patch was not reviewed,
so I pushed it again. I asked my colleagues how to get information
about whether the patch is included.

Will not make this low-level mistake again.

Thanks.

