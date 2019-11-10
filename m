Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857D7C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6220E215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfKJD4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 22:56:35 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35790 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfKJD4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 22:56:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 21A8D153A9CAF;
        Sat,  9 Nov 2019 19:56:34 -0800 (PST)
Date:   Sat, 09 Nov 2019 19:56:33 -0800 (PST)
Message-Id: <20191109.195633.2022092668080109840.davem@davemloft.net>
To:     tonylu@linux.alibaba.com
Cc:     edumazet@google.com, rostedt@goodmis.org, mingo@redhat.com,
        laoar.shao@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tcp: remove redundant new line from tcp_event_sk_skb
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191109104305.92898-1-tonylu@linux.alibaba.com>
References: <20191109104305.92898-1-tonylu@linux.alibaba.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 09 Nov 2019 19:56:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lu <tonylu@linux.alibaba.com>
Date: Sat,  9 Nov 2019 18:43:06 +0800

> This removes '\n' from trace event class tcp_event_sk_skb to avoid
> redundant new blank line and make output compact.
> 
> Fixes: af4325ecc24f ("tcp: expose sk_state in tcp_retransmit_skb tracepoint")
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
> v1->v2:
> - append Fixes tag

Applied and queued up for -stable, thanks.
