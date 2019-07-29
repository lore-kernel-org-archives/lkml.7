Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B7DC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE1D2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfG2SMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:12:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37132 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfG2SMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:12:40 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E7B31140505AC;
        Mon, 29 Jul 2019 11:12:39 -0700 (PDT)
Date:   Mon, 29 Jul 2019 11:12:39 -0700 (PDT)
Message-Id: <20190729.111239.1804738626565032234.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     dougmill@linux.ibm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        keescook@chromium.org
Subject: Re: [PATCH] net: ehea: Mark expected switch fall-through
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190729003009.GA25425@embeddedor>
References: <20190729003009.GA25425@embeddedor>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 29 Jul 2019 11:12:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sun, 28 Jul 2019 19:30:09 -0500

> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/net/ethernet/ibm/ehea/ehea_main.c: In function 'ehea_mem_notifier':
> include/linux/printk.h:311:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/ibm/ehea/ehea_main.c:3253:3: note: in expansion of macro 'pr_info'
>    pr_info("memory offlining canceled");
>    ^~~~~~~
> drivers/net/ethernet/ibm/ehea/ehea_main.c:3256:2: note: here
>   case MEM_ONLINE:
>   ^~~~
> 
> Notice that, in this particular case, the code comment is
> modified in accordance with what GCC is expecting to find.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
