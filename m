Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21242C43140
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 04:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0747220854
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 04:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406478AbfIGEmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 00:42:21 -0400
Received: from verein.lst.de ([213.95.11.211]:34330 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389986AbfIGEmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 00:42:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ABA0268B05; Sat,  7 Sep 2019 06:42:17 +0200 (CEST)
Date:   Sat, 7 Sep 2019 06:42:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>,
        palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
Message-ID: <20190907044217.GC21510@lst.de>
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic> <20190819062619.GA20211@lst.de> <alpine.DEB.2.21.9999.1909061527510.6292@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1909061527510.6292@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 03:33:02PM -0700, Paul Walmsley wrote:
> If that's your primary concern, then in the short term, how about just 
> sending a single-line patch to the arch/riscv/mm Makefile to skip building 
> it if !CONFIG_SOC_SIFIVE?  Assuming, that is, you won't be enabling EDAC 
> support for those low-end SoCs.  Then you won't need to get the ack 
> from the EDAC folks in the short term.  

Paul, stop it.  The patch that meged this was complete crap and fucked up.
And instead of just fixing up this mess ASAP you just keep arguing even
when I finally get hold of a RISC-V maintainer after weeks of waiting.

If this isn't going to get any better I'm just going to bypass you for
RISC-V patches and will send patches straight to Linus.
