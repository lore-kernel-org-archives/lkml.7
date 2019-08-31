Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2588CC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE45623717
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfHaCVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:21:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45304 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfHaCU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:20:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A03E71550AC01;
        Fri, 30 Aug 2019 19:20:58 -0700 (PDT)
Date:   Fri, 30 Aug 2019 19:20:49 -0700 (PDT)
Message-Id: <20190830.192049.1447010488040109227.davem@davemloft.net>
To:     cpaasch@apple.com
Cc:     jonathan.lemon@gmail.com, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, tim.froidcoeur@tessares.net,
        matthieu.baerts@tessares.net, aprout@ll.mit.edu,
        edumazet@google.com, jtl@netflix.com, linux-kernel@vger.kernel.org,
        mkubecek@suse.cz, ncardwell@google.com, sashal@kernel.org,
        ycheng@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH 4.14] tcp: fix tcp_rtx_queue_tail in case of empty
 retransmit queue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190830232657.GL45416@MacBook-Pro-64.local>
References: <20190824060351.3776-1-tim.froidcoeur@tessares.net>
        <400C4757-E7AD-4CCF-8077-79563EA869B1@gmail.com>
        <20190830232657.GL45416@MacBook-Pro-64.local>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 30 Aug 2019 19:20:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Paasch <cpaasch@apple.com>
Date: Fri, 30 Aug 2019 16:26:57 -0700

> (I don't see it in the stable-queue)

I don't handle any stable branch before the most recent two, so this isn't
my territory.
