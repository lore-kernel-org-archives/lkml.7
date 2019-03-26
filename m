Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A136AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB8F2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pbvPG1TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbfCZLhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:37:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfCZLhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bv5G3/eS21umtZDY99PXXbaStFpJ80Xzj5R3U428fsc=; b=pbvPG1TFAf9dyNpJIgt8xAfrh
        /Jp5p+bEr9ZP/xKdSIYbZGtXXuL2Hd/wDs78rTMcR2beiOKqEY+2qF+fsuixMDsjKP0gOaZEvWTqj
        RXoAEL7hcsC3Ir0HxvJ2HJix2KKgUWWNJnaQTGdqEJAy4radoDP1yxhNaEAuUshBa9D4r758xGGpT
        m2Q3BzSebFUcKC/B2aXXgyRZkx6HyWC0VDRpNSjSC9vmc9TXBESbW5FXClTwzjexbXDXE/1T0ed4K
        QHXaMe3JcNLJ5cvcgh5Jy2f04T47Rk4QHi/wEwNB3TyNYLlOQXJGxwSvGKTxjHPOzsLNFWVzAA++O
        0UuNcj38Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h8kO1-0004SA-8v; Tue, 26 Mar 2019 11:36:57 +0000
Date:   Tue, 26 Mar 2019 04:36:57 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Print map for total physical and virtual memory
Message-ID: <20190326113657.GL10344@bombadil.infradead.org>
References: <SG2PR02MB3098F980E1EB299853AC46E6E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR02MB3098F980E1EB299853AC46E6E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 08:34:20AM +0000, Pankaj Suryawanshi wrote:
> Hello,
> 
> 1. Is there any way to print whole physical and virtual memory map in kernel/user space ?
> 
> 2. Is there any way to print map of cma area reserved memory and movable pages of cma area.
> 
> 3. Is there any way to know who pinned the pages from cma reserved area ?

You probably want tools/vm/page-types.c
