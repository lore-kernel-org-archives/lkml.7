Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A26C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC4320665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfFYGdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:33:33 -0400
Received: from verein.lst.de ([213.95.11.211]:59906 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfFYGdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:33:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0D43868B05; Tue, 25 Jun 2019 08:33:02 +0200 (CEST)
Date:   Tue, 25 Jun 2019 08:33:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
Message-ID: <20190625063301.GB29561@lst.de>
References: <20190614102126.8402-1-hch@lst.de> <CAMuHMdUbuTc+MWqDFw=RnYxtiNQPQkzJ91KDuAQbhMq533tBCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUbuTc+MWqDFw=RnYxtiNQPQkzJ91KDuAQbhMq533tBCQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 09:16:30AM +0200, Geert Uytterhoeven wrote:
> Doing
> 
> -       select DMA_DIRECT_REMAP if MMU && !COLDFIRE
> +       select DMA_DIRECT_REMAP if MMU && !COLDFIRE && !SUN3
> 
> in arch/m68k/Kconfig fixes the build.
> 
> Alternatively, you could use:
> 
> -       select DMA_DIRECT_REMAP if MMU && !COLDFIRE
> +       select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE

The latter might be a little cleaner.
