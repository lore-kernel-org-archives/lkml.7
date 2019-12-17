Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C752DC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A310621582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLQV5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:57:30 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43410 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLQV5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:57:30 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C3082146D0405;
        Tue, 17 Dec 2019 13:57:29 -0800 (PST)
Date:   Tue, 17 Dec 2019 13:57:29 -0800 (PST)
Message-Id: <20191217.135729.173497629676380262.davem@davemloft.net>
To:     radhey.shyam.pandey@xilinx.com
Cc:     michal.simek@xilinx.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com
Subject: Re: [PATCH net-next 1/3] net: emaclite: Fix coding style
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1576498090-1277-2-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1576498090-1277-1-git-send-email-radhey.shyam.pandey@xilinx.com>
        <1576498090-1277-2-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 17 Dec 2019 13:57:30 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Date: Mon, 16 Dec 2019 17:38:08 +0530

> -	spinlock_t reset_lock;
> +	spinlock_t reset_lock; /* lock used for synchronization */

If you're just going to put the comment there to shut up the warnings,
I'm not applying your patches.

You have to write a thoughtful comment which explains what this lock
actually protects.
