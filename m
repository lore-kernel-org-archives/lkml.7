Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F22ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8973320872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436741AbfJQRT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:19:28 -0400
Received: from verein.lst.de ([213.95.11.211]:42748 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbfJQRT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:19:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B322368BE1; Thu, 17 Oct 2019 19:19:24 +0200 (CEST)
Date:   Thu, 17 Oct 2019 19:19:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>,
        paul.walmsley@sifive.com, palmer@sifive.com,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20191017171924.GA10928@lst.de>
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic> <20190819062619.GA20211@lst.de> <20190822062635.00f6e507@coco.lan> <20190927225304.GA18456@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927225304.GA18456@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro, can you Ack this patch?

On Sat, Sep 28, 2019 at 12:53:04AM +0200, Christoph Hellwig wrote:
> > > well enough myself, and I really need to get this code out of the
> > > forced on RISC-V codebase as some SOCs I'm working with simply don't
> > > have the memory for it..
> > > 
> > > So unless someone signs up to do a per-IP block edac drivers instead
> > > very quickly I'd still like to see something like this go into 5.4
> > > for now.
> > 
> > I'm wandering if we should at least add an entry for this one at
> > MAINTAINERS, pointing it to the EDAC mailing list. Something like:
> 
> Sounds fine.  Can you also ACK the patch with that, as Paul mention
> in another thread he wants an EDAC ACK for it.
---end quoted text---
