Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D138C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59651217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YV/SqvL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfDYIo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:44:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37386 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYIo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EwKBPDrZpRehbnardY5hrcw0YMsDuY6ve7MEhIdr5Hg=; b=YV/SqvL7dmulFg0EKJ6vHPSQ4
        +djwk57Yv9vFqIs3odeFFWPzvLyyY6036igF9m+VxEMCWuSj2quDhk3od2DcHi7mqk0pJ2Lupn/1R
        wysmcKeYr+ZtdDDkIgxDPE1a6KJoSZW0WO5S5rLT+uL1uLJo2Ae0cOunGPii5bkGWw8OqjWDs0ZfQ
        wzKVgNfn6cbEmVP7MQAhShGUpkhkIvhAfiKGpClC3O1QCChHB90JOfXd4KCv2O24LQ5QuC/Mc7bgw
        NJCyPFuPZArGtmKyOOsVS4UcZY3qEpTFlcYwyFYJAkJ9F90aCv6i1Oz9IuSszkwloBIG0IVs9Btmu
        RjpZahnBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJZzV-0001sJ-AE; Thu, 25 Apr 2019 08:44:25 +0000
Date:   Thu, 25 Apr 2019 01:44:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] RISC-V: Fix minor checkpatch issues.
Message-ID: <20190425084425.GA7162@infradead.org>
References: <20190424214801.18880-1-atish.patra@wdc.com>
 <20190424214801.18880-5-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424214801.18880-5-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 02:48:01PM -0700, Atish Patra wrote:
> While working on the patches, I found some minor checkpatch issues.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
