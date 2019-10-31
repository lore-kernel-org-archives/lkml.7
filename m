Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A20CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA74321929
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfJaSc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:32:59 -0400
Received: from verein.lst.de ([213.95.11.211]:52524 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfJaSc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:32:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC3F5227A81; Thu, 31 Oct 2019 19:32:55 +0100 (CET)
Date:   Thu, 31 Oct 2019 19:32:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] dma/direct: turn ARCH_ZONE_DMA_BITS into a variable
Message-ID: <20191031183255.GA10116@lst.de>
References: <20191031152837.15253-1-nsaenzjulienne@suse.de> <20191031154759.GA7162@lst.de> <40d06d463c05d36968e8b64924d78f7794f8de50.camel@suse.de> <20191031155750.GA7394@lst.de> <6726a651c12d91ca22b9d8984745d90db5d507ec.camel@suse.de> <20191031165853.GA8532@lst.de> <20191031180619.GI39590@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031180619.GI39590@arrakis.emea.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 06:06:19PM +0000, Catalin Marinas wrote:
> On Thu, Oct 31, 2019 at 05:58:53PM +0100, Christoph Hellwig wrote:
> > On Thu, Oct 31, 2019 at 05:22:59PM +0100, Nicolas Saenz Julienne wrote:
> > > OK, I see what you mean now. It's wrong indeed.
> > > 
> > > The trouble is the ZONE_DMA series[1] in arm64, also due for v5.5, will be
> > > affected by this patch. I don't know the right way to approach this problem
> > > since depending on the merge order, this patch should be updated or the arm64
> > > ZONE_DMA series fixed.
> > > 
> > > Maybe it's easier to just wait for v5.6.
> > 
> > Ok, I can wait.  Or the arm64 maintainers can pick up this patch if
> > you want to add it to that series.
> 
> This branch is stable (may add a fix but not I'm not rebasing it) if you
> want to base this patch on top:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/zone-dma
> 
> Otherwise, with your ack, I can add it on top of the above branch (aimed
> at 5.5).

Please go ahead:

Acked-by: Christoph Hellwig <hch@lst.de>
