Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8466BC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573F3217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfE0OVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:21:46 -0400
Received: from 8bytes.org ([81.169.241.247]:40300 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfE0OVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:21:46 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 46D282AF; Mon, 27 May 2019 16:21:44 +0200 (CEST)
Date:   Mon, 27 May 2019 16:21:40 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        John Garry <john.garry@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
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
Subject: Re: [PATCH v7 1/1] iommu: enhance IOMMU dma mode build options
Message-ID: <20190527142140.GH8420@8bytes.org>
References: <20190520135947.14960-1-thunder.leizhen@huawei.com>
 <20190520135947.14960-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520135947.14960-2-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhen Lei,

On Mon, May 20, 2019 at 09:59:47PM +0800, Zhen Lei wrote:
>  arch/ia64/kernel/pci-dma.c                |  2 +-
>  arch/powerpc/platforms/powernv/pci-ioda.c |  3 ++-
>  arch/s390/pci/pci_dma.c                   |  2 +-
>  arch/x86/kernel/pci-dma.c                 |  7 ++---
>  drivers/iommu/Kconfig                     | 44 ++++++++++++++++++++++++++-----
>  drivers/iommu/amd_iommu_init.c            |  3 ++-
>  drivers/iommu/intel-iommu.c               |  2 +-
>  drivers/iommu/iommu.c                     |  3 ++-
>  8 files changed, 48 insertions(+), 18 deletions(-)

This needs Acks from the arch maintainers of ia64, powerpc, s390 and
x86, at least.

It is easier for them if you split it up into the Kconfig change and
separete patches per arch and per iommu driver. Then collect the Acks on
the individual patches.

Thanks,

	Joerg
