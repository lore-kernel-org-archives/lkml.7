Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61631C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4F621841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DVAkqE5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDKG4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:56:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKG4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vrmtcjQScp6fAmyVbSoFn9t+viXPYH97PlQ82QhFnrc=; b=DVAkqE5CdVe6lw/wPHpl6AUql
        vDYysXKIfbzQeoSnHL1VDFJTU74Yl4kmOaWjBWx+i8KwEvbl1Xs0P6ZaZfYwkjoiDUThF2CsbPvlv
        0CdLOch9hD2os8E7cUBUbgQvna3QXY9d1A+C+omdhwIjPREH47fbOQG4HbEAhaLFuQAyvZ0Fue0zB
        xcyQmClXPsMevG0h3BrMGlzFfO+HrOzPxbqpkcUKT9kZKoSyTb3QR7dOlCnHS7JzZ0Q5h0Z3Y84qk
        ZLkPyvs5CcwSvyfCzI1YJhJ8XoqUvDbpOvSY4BNKNqCJXj7C9xsmYamzmXlwMidMuYR2YTIleyXKO
        DKFJj6ZGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hETdC-0001Jo-3t; Thu, 11 Apr 2019 06:56:18 +0000
Date:   Wed, 10 Apr 2019 23:56:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Borislav Petkov <bp@alien8.de>, Gary Guo <gary@garyguo.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-riscv@lists.infradead.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [1/3] x86: Update DEBUG_TLBFLUSH options description.
Message-ID: <20190411065617.GA29422@infradead.org>
References: <20190410224449.10877-1-atish.patra@wdc.com>
 <20190410224449.10877-2-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410224449.10877-2-atish.patra@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that this option enables generic code (which you reuse for RISC-V
later in this series) please also move the config option to
mm/Kconfig, proabbly keyed off another ARCH_HAVE_DEBUG_TLBFLUSH
symbol that the architecture can select.
