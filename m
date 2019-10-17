Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FDBFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E5F2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440422AbfJQQUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:20:55 -0400
Received: from verein.lst.de ([213.95.11.211]:42557 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729913AbfJQQUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:20:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 34EB768BE1; Thu, 17 Oct 2019 18:20:52 +0200 (CEST)
Date:   Thu, 17 Oct 2019 18:20:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 08/20] riscv: abstract out CSR names for supervisor vs
 machine mode
Message-ID: <20191017162052.GA10221@lst.de>
References: <20190903093239.21278-1-hch@lst.de> <20190903093239.21278-9-hch@lst.de> <alpine.DEB.2.21.9999.1910151902060.12675@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.9999.1910151902060.12675@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 07:07:17PM -0700, Paul Walmsley wrote:
> >  void start_thread(struct pt_regs *regs, unsigned long pc,
> >  	unsigned long sp)
> >  {
> > -	regs->sstatus = SR_SPIE;
> > +	regs->xstatus = SR_SPIE;
> 
> Looks like this should be "regs->xstatus = SR_PIE;"
> 
> Will update it here.  Let me know if you don't agree -

there is no SR_PIE, do you mean SR_XPІE?  Good catch in that case,
but please let me resend the whole thing.  I have some minor updates,
and I'd also like to do the rebase myself.
