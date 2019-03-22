Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99053C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9C821917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xu4/n/xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfCVNbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:31:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfCVNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xp54FBRdUcc5lWAq9Fru/RRjvqEO+zlB3cGLcWzkrE0=; b=Xu4/n/xp3YKbs0yvrl79jVjF2
        mBZ/B8mk5/oGbxJQs1d6zuXqs/a2B0LpZzCQpj74f9IVN1YzHPMNz24920UjcqknuqLA6y6QPpKL7
        tv11qAVf9AZJW7mS5MUaiVfej0Kapk8nEOYrMmzlfg8/RwP51UckCQRgAFOZ6VSHb/JpUf059H497
        mY3w/UWyQzwGTI5uVmT76/GCIYv/J/Z1XXdrkuiaoanDH3LMuW3OsKWdE8t+zSCJnULv4NAgoq9dW
        MUVgGZ2TdUx3UMvFHJXNCKJ35ROWnL4tUz+oYLLBpFRih3w1N1GulkkupqflCmoY9TdiRkkPn/6i8
        B1i8OKHhA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h7KGv-0001rO-UB; Fri, 22 Mar 2019 13:31:45 +0000
Date:   Fri, 22 Mar 2019 06:31:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v2 5/5] RISC-V: Fix memory reservation in setup_bootmem()
Message-ID: <20190322133145.GA32464@infradead.org>
References: <20190321094710.16552-1-anup.patel@wdc.com>
 <20190321094710.16552-6-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321094710.16552-6-anup.patel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.  Please move it to the front of the series.

Reviewed-by: Christoph Hellwig <hch@lst.de>
