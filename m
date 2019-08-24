Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C88C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D7F2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfHXWez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 18:34:55 -0400
Received: from verein.lst.de ([213.95.11.211]:37645 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfHXWez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 18:34:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E93268AEF; Sun, 25 Aug 2019 00:34:50 +0200 (CEST)
Date:   Sun, 25 Aug 2019 00:34:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Guan Xuetao <gxt@pku.edu.cn>,
        Shawn Anastasio <shawn@anastas.io>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        James Hogan <jhogan@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: cleanup the dma_pgprot handling
Message-ID: <20190824223449.GC21729@lst.de>
References: <20190816070754.15653-1-hch@lst.de> <20190823215759.zprrwotlbva46y33@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823215759.zprrwotlbva46y33@pburton-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 09:58:04PM +0000, Paul Burton wrote:
> So I believe uncached & uncached accelerated are another case like that
> described above - they're 2 different CCAs but the same "access type",
> namely uncached.
> 
> Section 4.9 then goes on to forbid mixing access types, but not CCAs.
> 
> It would be nice if the precise mapping from CCA to access type was
> provided, but I don't see that anywhere. I can check with the
> architecture team to be sure, but to my knowledge we're fine to mix
> access via kseg1 (ie. uncached) & mappings with CCA=7 (uncached
> accelerated).

Ok.  Looks like we can keep it then and I'll add a comment to the
code with the above reference.
