Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F464C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536DA20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLJEcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:32:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39824 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfLJEcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:32:04 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 48685154F0CD6;
        Mon,  9 Dec 2019 20:32:03 -0800 (PST)
Date:   Mon, 09 Dec 2019 20:32:02 -0800 (PST)
Message-Id: <20191209.203202.180894312618501297.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] net: smc911x: Adjust indentation in
 smc911x_phy_configure
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191209215027.10222-1-natechancellor@gmail.com>
References: <20191209215027.10222-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Dec 2019 20:32:03 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon,  9 Dec 2019 14:50:27 -0700

> Clang warns:
> 
> ../drivers/net/ethernet/smsc/smc911x.c:939:3: warning: misleading
> indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>          if (!lp->ctl_rfduplx)
>          ^
> ../drivers/net/ethernet/smsc/smc911x.c:936:2: note: previous statement
> is here
>         if (lp->ctl_rspeed != 100)
>         ^
> 1 warning generated.
> 
> This warning occurs because there is a space after the tab on this line.
> Remove it so that the indentation is consistent with the Linux kernel
> coding style and clang no longer warns.
> 
> Fixes: 0a0c72c9118c ("[PATCH] RE: [PATCH 1/1] net driver: Add support for SMSC LAN911x line of ethernet chips")
> Link: https://github.com/ClangBuiltLinux/linux/issues/796
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
