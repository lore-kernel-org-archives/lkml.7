Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D90C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4A7218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfDXBeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:34:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47466 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfDXBeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:34:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 378B214013FD5;
        Tue, 23 Apr 2019 18:34:05 -0700 (PDT)
Date:   Tue, 23 Apr 2019 18:34:04 -0700 (PDT)
Message-Id: <20190423.183404.989691820513976369.davem@davemloft.net>
To:     huangfq.daxian@gmail.com
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn:mISDN: fix misuse of %x in hfcpci.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190423025623.17419-1-huangfq.daxian@gmail.com>
References: <20190423025623.17419-1-huangfq.daxian@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Apr 2019 18:34:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fuqian Huang <huangfq.daxian@gmail.com>
Date: Tue, 23 Apr 2019 10:56:23 +0800

> Pointers should be printed with %p or %px rather than
> cast to (u_long) and printed with %lx.
> Change %lx to %p to print the pointer.
> Change %lx to %pad to print the dma_addr_t.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Applied.
