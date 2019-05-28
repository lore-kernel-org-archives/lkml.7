Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B84C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC3220989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfE1NGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:06:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbfE1NGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:06:08 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9196F290A5DB12249000;
        Tue, 28 May 2019 21:06:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 28 May 2019
 21:05:52 +0800
Subject: Re: [PATCH v7 1/1] iommu: enhance IOMMU dma mode build options
To:     Joerg Roedel <joro@8bytes.org>
References: <20190520135947.14960-1-thunder.leizhen@huawei.com>
 <20190520135947.14960-2-thunder.leizhen@huawei.com>
 <20190527142140.GH8420@8bytes.org>
CC:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        x86 <x86@kernel.org>, linux-ia64 <linux-ia64@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5CED322E.20102@huawei.com>
Date:   Tue, 28 May 2019 21:05:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190527142140.GH8420@8bytes.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/5/27 22:21, Joerg Roedel wrote:
> Hi Zhen Lei,
> 
> On Mon, May 20, 2019 at 09:59:47PM +0800, Zhen Lei wrote:
>>  arch/ia64/kernel/pci-dma.c                |  2 +-
>>  arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
>>  arch/s390/pci/pci_dma.c                   |  2 +-
>>  arch/x86/kernel/pci-dma.c                 |  7 ++---
>>  drivers/iommu/Kconfig                     | 44 ++++++++++++++++++++++++++-----
>>  drivers/iommu/amd_iommu_init.c            |  3 ++-
>>  drivers/iommu/intel-iommu.c               |  2 +-
>>  drivers/iommu/iommu.c                     |  3 ++-
>>  8 files changed, 48 insertions(+), 18 deletions(-)
> 
> This needs Acks from the arch maintainers of ia64, powerpc, s390 and
> x86, at least.
> 
> It is easier for them if you split it up into the Kconfig change and
> separete patches per arch and per iommu driver. Then collect the Acks on
> the individual patches.

OK, thanks. I will do it tomorrow.

> 
> Thanks,
> 
> 	Joerg
> 
> .
> 

-- 
Thanks!
BestRegards

