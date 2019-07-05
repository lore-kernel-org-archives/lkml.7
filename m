Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21766C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38C92133F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 23:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfGEXSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 19:18:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44152 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfGEXSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 19:18:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8059015043C39;
        Fri,  5 Jul 2019 16:18:08 -0700 (PDT)
Date:   Fri, 05 Jul 2019 16:18:05 -0700 (PDT)
Message-Id: <20190705.161805.2076674582891385494.davem@davemloft.net>
To:     bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, jakub.kicinski@netronome.com,
        oss-drivers@netronome.com, netdev@vger.kernel.org
Subject: Re: [PATCH 6/7] nfp: Use spinlock_t instead of struct spinlock
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190704153803.12739-7-bigeasy@linutronix.de>
References: <20190704153803.12739-1-bigeasy@linutronix.de>
        <20190704153803.12739-7-bigeasy@linutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Jul 2019 16:18:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu,  4 Jul 2019 17:38:02 +0200

> For spinlocks the type spinlock_t should be used instead of "struct
> spinlock".
> 
> Use spinlock_t for spinlock's definition.
> 
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: oss-drivers@netronome.com
> Cc: netdev@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to net-next, thanks.
