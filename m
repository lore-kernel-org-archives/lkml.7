Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70968C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D852077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eNqP4p7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfLISdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:33:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55824 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLISdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8zgmO8yIumpWTktN/WLnCjKv5dav9LhhmBQXS3TWUg8=; b=eNqP4p7owxWNWsbfq6onLxwlig
        lmiOYyGS8vCUjkzr+ed5MFL4EZw8QPfltFoMQAMkTBGeglMNlCLuOkhY9HqyAN4GSkY0Vgva0cjJh
        dmWKgQJXVQkyShp0GMPCz88nmEUCKdZIw7nghIelP7W3hYTXFI5RcPOmgPuyskrv8V8XxTaSPrVxg
        LrdyC0smjo6V5/ylW+B1b70NTBYQWYdajHbKZGXMMJ2827jh/pnwREcdhyW7upbnOzab/uwTty5dV
        MP3jnbgpGMQS4xifzcHuAgqGSySIt3EjNsS+HfsYY2ijlI/clx0qtibK0EJC9SjDZmwf9XRjOKTAi
        rvapDXwg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieNqg-0000pS-2A; Mon, 09 Dec 2019 18:33:34 +0000
Date:   Mon, 9 Dec 2019 10:33:33 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: add support for folded p4d page tables
Message-ID: <20191209183333.GG32169@bombadil.infradead.org>
References: <20191209150908.6207-1-rppt@kernel.org>
 <7f4c038d-e971-b61f-3d3a-60a5faddfc0a@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f4c038d-e971-b61f-3d3a-60a5faddfc0a@c-s.fr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 06:46:36PM +0100, Christophe Leroy wrote:
> 
> 
> Le 09/12/2019 à 16:09, Mike Rapoport a écrit :
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Implement primitives necessary for the 4th level folding, add walks of p4d
> > level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Tested on 8xx and 83xx, no problem observed (ie book3s/32 and nohash/32)
> 
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Christophe

Did you add anything else to the next 1100 lines that you didn't bother
to snip?  I can't be arsed to scroll through them all looking.
