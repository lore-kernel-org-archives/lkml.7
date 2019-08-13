Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662CEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E33D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfHMQnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:43:00 -0400
Received: from verein.lst.de ([213.95.11.211]:58583 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfHMQnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:43:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6435568B02; Tue, 13 Aug 2019 18:42:57 +0200 (CEST)
Date:   Tue, 13 Aug 2019 18:42:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 02/15] riscv: use CSR_SATP instead of the legacy sptbr
 name in switch_mm
Message-ID: <20190813164257.GA10019@lst.de>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-3-hch@lst.de> <alpine.DEB.2.21.9999.1908130935310.30024@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1908130935310.30024@viisi.sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 09:36:23AM -0700, Paul Walmsley wrote:
> On Tue, 13 Aug 2019, Christoph Hellwig wrote:
> 
> > Switch to our own constant for the satp register instead of using
> > the old name from a legacy version of the privileged spec.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Atish Patra <atish.patra@wdc.com>
> 
> Didn't you want us to replace this with Bin Meng's patch?
> 
> https://lore.kernel.org/linux-riscv/20190807151316.GB16432@infradead.org/
> 
> If so, probably best just to drop this one and state a dependency.

Either way is fine with me.  But until you have a branch with
either one applied I'm going to keep resending my patch, as random
dependencies on uncommitted patches don't work.
