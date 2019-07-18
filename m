Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AF4C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E90B20873
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 17:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfGRR5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 13:57:00 -0400
Received: from verein.lst.de ([213.95.11.211]:33070 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfGRR47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 13:56:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C28C468B02; Thu, 18 Jul 2019 19:56:55 +0200 (CEST)
Date:   Thu, 18 Jul 2019 19:56:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH v3 4/6] x86,s390/mm: Move sme_active() and sme_me_mask
 to x86-specific header
Message-ID: <20190718175655.GA361@lst.de>
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <20190718032858.28744-5-bauerman@linux.ibm.com> <cf48e778-130a-df2a-d94b-170bd85d692c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf48e778-130a-df2a-d94b-170bd85d692c@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 05:42:18PM +0000, Lendacky, Thomas wrote:
> You may want to try and build the out-of-tree nvidia driver just to be
> sure you can remove the EXPORT_SYMBOL(). But I believe that was related
> to the DMA mask check, which now removed, may no longer be a problem.

Out of tree driver simply don't matter for kernel development decisions.
