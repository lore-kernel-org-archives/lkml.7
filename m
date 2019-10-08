Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A1A20640
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfJHH3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:29:54 -0400
Received: from verein.lst.de ([213.95.11.211]:44431 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730171AbfJHH3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:29:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0560A68B20; Tue,  8 Oct 2019 09:29:50 +0200 (CEST)
Date:   Tue, 8 Oct 2019 09:29:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191008072949.GA9452@lst.de>
References: <20191007022454.GA5270@rani.riverdale.lan> <20191007073448.GA882@lst.de> <20191007175430.GA32537@rani.riverdale.lan> <20191007175528.GA21857@lst.de> <20191007175630.GA28861@infradead.org> <20191007175856.GA42018@rani.riverdale.lan> <20191007183206.GA13589@rani.riverdale.lan> <20191007184754.GB31345@lst.de> <20191007221054.GA409402@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007221054.GA409402@rani.riverdale.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 06:10:55PM -0400, Arvind Sankar wrote:
> > Acked-by: Christoph Hellwig <hch@lst.de>
> 
> Do you want me to resend the patch as its own mail, or do you just take
> it with a Tested-by: from me? If the former, I assume you're ok with me
> adding your Signed-off-by?

Either way is fine with me.  The original patch was from me, but you
actually did all the work of reporting it, fixing it and testing it so
I'm perfectly fine with you sending it under your name.
