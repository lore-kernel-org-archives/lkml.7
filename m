Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632F7C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385FD2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKVSLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:11:49 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38552 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKVSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:11:49 -0500
Received: from localhost (c-73-35-209-67.hsd1.wa.comcast.net [73.35.209.67])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1DF0E15282F8B;
        Fri, 22 Nov 2019 10:11:48 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:11:47 -0800 (PST)
Message-Id: <20191122.101147.1112820693050959325.davem@davemloft.net>
To:     guillaume.tucker@collabora.com
Cc:     hulkci@huawei.com, tomeu.vizoso@collabora.com, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com, yuehaibing@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com
Subject: Re: net-next/master bisection: boot on beaglebone-black
From:   David Miller <davem@davemloft.net>
In-Reply-To: <bfe5e987-e0b5-6c89-f193-6666be203532@collabora.com>
References: <5dd7d181.1c69fb81.64fbc.cd8a@mx.google.com>
        <20191122.093657.95680289541075120.davem@davemloft.net>
        <bfe5e987-e0b5-6c89-f193-6666be203532@collabora.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 Nov 2019 10:11:48 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guillaume Tucker <guillaume.tucker@collabora.com>
Date: Fri, 22 Nov 2019 18:02:06 +0000

> As far as I can tell, it's the first time someone replies to say
> this issue is already fixed.  Sorry if I've missed an email.

I saw the first one and just ignored it hoping that since I had
the fix in 'net' these emails would simply stop.

> Also, it's apparently not fixed in the net-next tree which
> explains why it was reported again.  I guess we need to disable
> bisections in net-next until it gets rebased and includes the
> fix, and add a way to mark issues fixed somewhere else in
> KernelCI to avoid this situation in the future.

If you're not combining the net and the net-next tree, as Stephen
Rothwell's tree is doing, then you're going to run into this problem
every single day and spam us with these messages.

What is being done right now doesn't work.  You can't just wait for
net integration into net-next, that doesn't cut it.
