Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FF9C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0314D20843
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 09:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZAos9dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfF0JA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:00:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0JA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zrHV6KHe28+i3EYX5+rFKA0r8nGhuoIze6MqjtpUnFk=; b=LZAos9dJVUl+0ktP2UgVYRbby
        7ZqvPzRchEcX66vfyDlNi+r2GUIswIF88v/DrR9hg7CHl90NCZJLMg9C36qf313KeF/uQGv5IyW20
        c6ClZOj1+C6r6gUZQGHDE08TpN1338sxtp1FoVPnb8v/PNId8+aCdwObT8Xh4fAtVMduoeFg8xBNN
        42EBUjXa2UYyy/EkUg3pTfjbaglxtLZmXIeLXVD648k8uEueX3h7tVFXQ3fs8YYqVs5fYnMPHxTV1
        l8PrmQn8VvOI1a6LgKFuq+Z6o+TFrUL3lNAk2NGgr1aUIsyo3zmb7fQeg5bTKRzV7KXnPNRMr5t1D
        bLdZWHuLw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgQH1-0007YL-OM; Thu, 27 Jun 2019 09:00:55 +0000
Date:   Thu, 27 Jun 2019 02:00:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, x86@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: Remove gate area stubs
Message-ID: <20190627090055.GA23838@infradead.org>
References: <d7f5a3b26eb4f7a41a24baf89ad70b3f37894a6e.1561610736.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7f5a3b26eb4f7a41a24baf89ad70b3f37894a6e.1561610736.git.luto@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:46:18PM -0700, Andy Lutomirski wrote:
> Since commit a6c19dfe3994 ("arm64,ia64,ppc,s390,sh,tile,um,x86,mm:
> remove default gate area"), which predates riscv's inclusion in
> Linux by almost three years, the default behavior wrt the gate area
> is sane.  Remove riscv's gate area stubs.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
