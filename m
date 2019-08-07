Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85273C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6692022293
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbfHGPYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:24:43 -0400
Received: from verein.lst.de ([213.95.11.211]:38537 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387815AbfHGPYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:24:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 20D6D68B20; Wed,  7 Aug 2019 17:24:39 +0200 (CEST)
Date:   Wed, 7 Aug 2019 17:24:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@sifive.com, arnd@arndb.de,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, mchehab@kernel.org, james.morse@arm.com
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/misc
Message-ID: <20190807152438.GA16495@lst.de>
References: <20190807151009.31971-1-hch@lst.de> <20190807152215.GA26690@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807152215.GA26690@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:22:15PM +0200, Greg KH wrote:
> > Fixes: a967a289f169 ("RISC-V: sifive_l2_cache: Add L2 cache controller driver for SiFive SoCs")
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/riscv/mm/Makefile                            | 1 -
> >  drivers/misc/Makefile                             | 1 +
> >  {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c | 0
> >  3 files changed, 1 insertion(+), 1 deletion(-)
> >  rename {arch/riscv/mm => drivers/misc}/sifive_l2_cache.c (100%)
> 
> Why isn't this in drivers/edac/ ?
> why is this a misc driver?  Seems like it should sit next to the edac
> stuff.

No idea.  EDAC maintainers, would you object to taking what is 
currently in arch/riscv/mm//sifive_l2_cache.c to drivers/edac/ ?
