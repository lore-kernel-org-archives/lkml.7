Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA2EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D842073F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDKMca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:32:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726536AbfDKMc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:32:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7E4E0BFF5522A0FE345B;
        Thu, 11 Apr 2019 20:32:21 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Thu, 11 Apr 2019
 20:32:13 +0800
Subject: Re: [PATCH v3 1/4] x86: kdump: move reserve_crashkernel_low() into
 kexec_core.c
To:     Ingo Molnar <mingo@kernel.org>
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-2-chenzhou10@huawei.com>
 <20190410070914.GA10935@gmail.com>
CC:     <wangkefeng.wang@huawei.com>, <horms@verge.net.au>,
        <ard.biesheuvel@linaro.org>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <linux-kernel@vger.kernel.org>,
        <rppt@linux.ibm.com>, <linux-mm@kvack.org>,
        <takahiro.akashi@linaro.org>, <mingo@redhat.com>, <bp@alien8.de>,
        <ebiederm@xmission.com>, <kexec@lists.infradead.org>,
        <tglx@linutronix.de>, <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <31b41dcc-0d16-d1d0-bff9-dec3e77515c1@huawei.com>
Date:   Thu, 11 Apr 2019 20:32:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190410070914.GA10935@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 2019/4/10 15:09, Ingo Molnar wrote:
> 
> * Chen Zhou <chenzhou10@huawei.com> wrote:
> 
>> In preparation for supporting more than one crash kernel regions
>> in arm64 as x86_64 does, move reserve_crashkernel_low() into
>> kexec/kexec_core.c.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/x86/include/asm/kexec.h |  3 ++
>>  arch/x86/kernel/setup.c      | 66 +++++---------------------------------------
>>  include/linux/kexec.h        |  1 +
>>  kernel/kexec_core.c          | 53 +++++++++++++++++++++++++++++++++++
>>  4 files changed, 64 insertions(+), 59 deletions(-)
> 
> No objections for this to be merged via the ARM tree, as long as x86 
> functionality is kept intact.

This patch has no affect on x86.

Thanks,
Chen Zhou

> 
> Thanks,
> 
> 	Ingo
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 

