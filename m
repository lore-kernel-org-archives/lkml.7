Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240B924D40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 06:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XZ6u6YnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFDGl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 02:41:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfFDGl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 02:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Vjr/lmR6UJzzcnF6AXERDVYqsON61Ko2MaI3KpSTt5c=; b=XZ6u6YnPtLoNWs9ZeAtKQum0G
        k+/MlF1yNO7EFFL+CtlKMftrX7z3fzu0NgNgDX46NPDqNj6W6pfoQLe9WenZ8D/6h56L/bXfajvfD
        g7WkpYuQX9su8Wb+9IOWUa2WHzXQyNMjakFCzb8B/4Bpx0Zca+3WyxD1EWSvSNYfhrTcBepdyFvnV
        wt5Ik9at1h3vH62p+nlMh5wW8smJzdnGOLBDROHxyrTIJPtXYb4V+RvJTToHI8VVXKwnunS5d5Bnu
        6gqF5LVA4AbVAF7T1HnzH5FAMJjPOWRrnljPajuDhW4d6hu6n5BJ18CvzppL66PXrTD4AqpgXIOHf
        eSbMm7o4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hY38t-0005fV-57; Tue, 04 Jun 2019 06:41:55 +0000
Date:   Mon, 3 Jun 2019 23:41:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Anup.Patel@wdc.com, aou@eecs.berkeley.edu, schwab@suse.de,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>, anup@brainfault.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: defconfig: Enable NO_HZ_IDLE and HIGH_RES_TIMERS
Message-ID: <20190604064155.GA21667@infradead.org>
References: <mhng-faba08ec-69a7-43b1-b2d7-c2e996751506@palmer-si-x1c4>
 <alpine.DEB.2.21.9999.1906030944170.9338@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.9999.1906030944170.9338@viisi.sifive.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:44:44AM -0700, Paul Walmsley wrote:
> > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> 
> Thanks, queued for v5.3.

Where do you apply these patches to?  Is there a chance we could just
set up a multi commiter riscv tree insted of growing the number of
trees?
