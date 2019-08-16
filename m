Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DA3C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46A021721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 22:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfHPW65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:58:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41790 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727676AbfHPW65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 18:58:57 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 38B901412C5B8;
        Fri, 16 Aug 2019 15:58:56 -0700 (PDT)
Date:   Fri, 16 Aug 2019 15:58:50 -0700 (PDT)
Message-Id: <20190816.155850.2109072192517591348.davem@davemloft.net>
To:     wsommerfeld@google.com
Cc:     petrm@mellanox.com, jiri@mellanox.com, idosch@mellanox.com,
        daniel@iogearbox.net, yuehaibing@huawei.com, tglx@linutronix.de,
        linmiaohe@huawei.com, edumazet@google.com, maheshb@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipvlan: set hw_enc_features like macvlan
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190815001043.153874-1-wsommerfeld@google.com>
References: <20190815001043.153874-1-wsommerfeld@google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Aug 2019 15:58:56 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Sommerfeld <wsommerfeld@google.com>
Date: Wed, 14 Aug 2019 17:10:43 -0700

> Allow encapsulated packets sent to tunnels layered over ipvlan to use
> offloads rather than forcing SW fallbacks.
> 
> Since commit f21e5077010acda73a60 ("macvlan: add offload features for
> encapsulation"), macvlan has set dev->hw_enc_features to include
> everything in dev->features; do likewise in ipvlan.
> 
> Signed-off-by: Bill Sommerfeld <wsommerfeld@google.com>

Applied to net-next.
