Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4FFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76755206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tZPEhtNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbfDXGUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:20:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfDXGUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AZYvIvzwpu1jsgX20cUu89IdJc8KumO2IG1It1Q5bmQ=; b=tZPEhtNblm5F9Re4Y1WuHWbA7
        IvENlC0w46yjIpaLGPqzViNLAeg8C3G8pqiPTg4v7PJa3dVAAPBozMr67gpJ23eRs5Rquom9Q5P11
        P+dICzcNXWq3dm+8UHKUganQ0YkaCrpmXksMHiA62+MDbKNNN5Hn9Vx9L3jl0TxxVOvTYEMewYTvD
        4e2U5K+k4L7iplN6khkkGUCQfBT+ILJTfh42YRtv3THACPWdZtSCvDaVTjcu6Jgyu/NTHGXYqzxFQ
        BCHz97vTfYQR6pa4FosZ5fHTv45kxB7NEOR5yIQb6uUs+kT8W57RIMSrG4LOeSXUnnYzerawSF9QV
        WMeV4bqKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJBGW-0002E0-TA; Wed, 24 Apr 2019 06:20:20 +0000
Date:   Tue, 23 Apr 2019 23:20:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-riscv@lists.infradead.org,
        Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH] riscv: vdso: drop unnecessary cc-ldoption
Message-ID: <20190424062020.GA3902@infradead.org>
References: <20190423212254.9504-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423212254.9504-1-ndesaulniers@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 02:22:53PM -0700, Nick Desaulniers wrote:
> Towards the goal of removing cc-ldoption, it seems that --hash-style=
> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
