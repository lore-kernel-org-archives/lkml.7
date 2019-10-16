Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6494C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF5520854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 03:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbfJPDvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 23:51:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44190 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfJPDvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 23:51:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4D4DB12ECDD7D;
        Tue, 15 Oct 2019 20:51:04 -0700 (PDT)
Date:   Tue, 15 Oct 2019 20:51:03 -0700 (PDT)
Message-Id: <20191015.205103.1828715161134282651.davem@davemloft.net>
To:     tbogendoerfer@suse.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: i82596: fix dma_alloc_attr for sni_82596
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191015144245.11182-1-tbogendoerfer@suse.de>
References: <20191015144245.11182-1-tbogendoerfer@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Oct 2019 20:51:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Date: Tue, 15 Oct 2019 16:42:45 +0200

> Commit 7f683b920479 ("i825xx: switch to switch to dma_alloc_attrs")
> switched dma allocation over to dma_alloc_attr, but didn't convert
> the SNI part to request consistent DMA memory. This broke sni_82596
> since driver doesn't do dma_cache_sync for performance reasons.
> Fix this by using different DMA_ATTRs for lasi_82596 and sni_82596.
> 
> Fixes: 7f683b920479 ("i825xx: switch to switch to dma_alloc_attrs")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied and queued up for -stable.
