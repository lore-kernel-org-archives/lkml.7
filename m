Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23689C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B1820652
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 07:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfFYHf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 03:35:56 -0400
Received: from verein.lst.de ([213.95.11.211]:60360 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728539AbfFYHf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 03:35:56 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1FAFC68B02; Tue, 25 Jun 2019 09:35:25 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:35:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] switch m68k to use the generic remapping DMA allocator
Message-ID: <20190625073524.GA30815@lst.de>
References: <20190614102126.8402-1-hch@lst.de> <CAMuHMdVPU5RQyX4FnHFEhxXZeG3v0uh_-t2FB=vAzQ8_3u-gSw@mail.gmail.com> <20190625063228.GA29561@lst.de> <CAMuHMdUNwERTRg4MbkkD62EtNhsU7kWVy6x4kB89rYh6ann0Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUNwERTRg4MbkkD62EtNhsU7kWVy6x4kB89rYh6ann0Pw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 09:26:48AM +0200, Geert Uytterhoeven wrote:
> > > bloat-o-meter says:
> > >
> > > add/remove: 75/0 grow/shrink: 11/6 up/down: 4122/-82 (4040)
> >
> > What do these values stand for?  The code should grow a little as
> > we now need to include the the pool allocator for the above API
> > fix.
> 
> Last 3 values are "bytes added/removed (net increase)".
> So this increases the static kernel size by ca. 4 KiB.

That seems a lot for the little bit of pool code.  Did m68k not
build lib/genalloc.c by default before?

Also I'd be curious what the first 4 values are.
