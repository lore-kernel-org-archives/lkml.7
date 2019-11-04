Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE2ACA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C234020869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfKDTaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:30:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50482 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfKDTap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:30:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D55BE151D4FBA;
        Mon,  4 Nov 2019 11:30:44 -0800 (PST)
Date:   Mon, 04 Nov 2019 11:30:44 -0800 (PST)
Message-Id: <20191104.113044.1639305550623277715.davem@davemloft.net>
To:     tbogendoerfer@suse.de
Cc:     ralf@linux-mips.org, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [net v3 1/5] net: sgi: ioc3-eth: don't abuse dma_direct_* calls
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191104104515.7066-1-tbogendoerfer@suse.de>
References: <20191104104515.7066-1-tbogendoerfer@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 Nov 2019 11:30:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Date: Mon,  4 Nov 2019 11:45:11 +0100

> From: Christoph Hellwig <hch@lst.de>
> 
> dma_direct_ is a low-level API that must never be used by drivers
> directly.  Switch to use the proper DMA API instead.
> 
> Fixes: ed870f6a7aa2 ("net: sgi: ioc3-eth: use dma-direct for dma allocations")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Series applied to net-next.

Please provide a proper "[PATCH v3 0/5] ..." header posting next time when you
post a patch series.

Thank you.
