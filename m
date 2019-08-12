Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E7BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B955208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6nxYfkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfHLPCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:02:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbfHLPCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dx70YMOccAP+68h0VusNP4nP5/2AxWdL74DYMWN3IK8=; b=E6nxYfkjBgZ7uIwrVVGbjLAde
        rEqxSE2QHXWwUaBdV2PxbjP5PlbHhbAETuCfVGfXm3uddB8PoF+Hk1TIolLTr9Ynug/Y+PYO7ddKP
        3FoWHmgKcgGWfUI0zNhMXft29w0ZhdVsbSmJoMn0SLyAmeM2FrOflkwB/Ex7YwRqIg+LO7JzirMCC
        OmL+9OSH+ktKl73aREPJUGDYz4XpulM0MwGu1spI8jx2+ke/2V2pgA3O4VSMxhQ4OmpewveugAOM0
        lDN7Pum1WeolxQNu/xyAp4CTk7YihMPUpoy43wZ0C37Hh4H2l8sgYTbzo2EG8KnZZrmhKOGldra1T
        GhC8dXZxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hxBqP-0005fO-Ce; Mon, 12 Aug 2019 15:02:45 +0000
Date:   Mon, 12 Aug 2019 08:02:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andreas Schwab <schwab@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] riscv: Using CSR numbers to access CSRs
Message-ID: <20190812150245.GG26897@infradead.org>
References: <1565184656-4282-1-git-send-email-bmeng.cn@gmail.com>
 <1565194418-9672-1-git-send-email-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565194418-9672-1-git-send-email-bmeng.cn@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 09:13:38AM -0700, Bin Meng wrote:
> Since commit a3182c91ef4e ("RISC-V: Access CSRs using CSR numbers"),
> we should prefer accessing CSRs using their CSR numbers, but there
> are several leftovers like sstatus / sptbr we missed.
> 
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
