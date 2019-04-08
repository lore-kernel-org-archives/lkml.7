Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1479EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E040D20870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfDHJwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:52:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725933AbfDHJwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:52:09 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 633868A0D550D054A9A4;
        Mon,  8 Apr 2019 17:52:06 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 17:51:59 +0800
Subject: Re: [PATCH v4 0/6] normalize IOMMU dma mode boot options
To:     Thomas Gleixner <tglx@linutronix.de>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
 <b20fd8a6-88ce-7d26-8eb0-ed9f095988a6@huawei.com>
 <5CAABD03.9000301@huawei.com>
 <alpine.DEB.2.21.1904080829490.1840@nanos.tec.linutronix.de>
CC:     Hanjun Guo <guohanjun@huawei.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        "Gerald Schaefer" <gerald.schaefer@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5CAB19BC.2040804@huawei.com>
Date:   Mon, 8 Apr 2019 17:51:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904080829490.1840@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/8 14:32, Thomas Gleixner wrote:
> On Mon, 8 Apr 2019, Leizhen (ThunderTown) wrote:
>>>
>>> This will break systems using boot options as now, and I think
>>> this is unacceptable. If you want to do so, just introduce iommu.dma_mode
>>> on top of those iommu boot options with dma mode boot options unchanged,
>>> and iommu.dma_mode is for all archs but compatible with them.
>>
>> I just changed the boot options name, but keep the function no change. I added
>> all related maintainers/supporters in the "to=" list, maybe we can disuss this.
> 
> Changing the name _IS_ the problem. Think about unattended updates.
> 
>> Should I add some "obsoleted" warnings for old options and keep them for a while?
> 
> No, just keep the old options around for backwards compatibilty sake. We
> just do not add new arch specific options in the future. New options need
> to use the generic iommu.dma_mode name space.

OK, thanks for your advise.


> 
> Thanks,
> 
> 	tglx
> 
> .
> 

-- 
Thanks!
BestRegards

