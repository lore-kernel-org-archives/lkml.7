Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6190DC04AB5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB4E26047
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFDCIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:08:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfFDCIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 22:08:54 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B6F40E578F138A30FD44;
        Tue,  4 Jun 2019 10:08:51 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Jun 2019
 10:08:48 +0800
Subject: Re: [PATCH] ARM: mm: remove unused variables
To:     Krzysztof Kozlowski <krzk@kernel.org>
References: <20190512114105.41792-1-yuehaibing@huawei.com>
 <CAJKOXPeDRuvmHG=KUCYiPav2ODT4MC4hEgi5hAsy7s_+v-DB3g@mail.gmail.com>
CC:     <linux@armlinux.org.uk>, <rppt@linux.ibm.com>,
        <akpm@linux-foundation.org>, <geert+renesas@glider.be>,
        <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <208eb75a-dda5-98d9-3cad-c4f67cbf267f@huawei.com>
Date:   Tue, 4 Jun 2019 10:08:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPeDRuvmHG=KUCYiPav2ODT4MC4hEgi5hAsy7s_+v-DB3g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/4 2:45, Krzysztof Kozlowski wrote:
> On Sun, 12 May 2019 at 13:51, YueHaibing <yuehaibing@huawei.com> wrote:
>>
>> Fix gcc warnings:
>>
>> arch/arm/mm/init.c: In function 'mem_init':
>> arch/arm/mm/init.c:456:13: warning: unused variable 'itcm_end' [-Wunused-variable]
>>   extern u32 itcm_end;
>>              ^
>> arch/arm/mm/init.c:455:13: warning: unused variable 'dtcm_end' [-Wunused-variable]
>>   extern u32 dtcm_end;
>>              ^
>>
>> They are not used any more since
>> commit 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  arch/arm/mm/init.c | 6 ------
>>  1 file changed, 6 deletions(-)
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> Did you submit it to Russell's patch system?

Thanks for your reminder, I will send it.

> 
> Best regards,
> Krzysztof
> 
> .
> 

