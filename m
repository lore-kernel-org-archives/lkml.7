Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C9C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DFF204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfDQEwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:52:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:49250 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfDQEwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:52:45 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CB1FA13D3B828;
        Tue, 16 Apr 2019 21:52:44 -0700 (PDT)
Date:   Tue, 16 Apr 2019 21:52:44 -0700 (PDT)
Message-Id: <20190416.215244.242506869190097178.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     edumazet@google.com, willemb@google.com, deepa.kernel@gmail.com,
        laoar.shao@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] socket: fix compat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190416203143.408835-1-arnd@arndb.de>
References: <20190416203143.408835-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 16 Apr 2019 21:52:45 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Apr 2019 22:31:14 +0200

> It looks like the new socket options only work correctly
> for native execution, but in case of compat mode fall back
> to the old behavior as we ignore the 'old_timeval' flag.
> 
> Rework so we treat SO_RCVTIMEO_NEW/SO_SNDTIMEO_NEW the
> same way in compat and native 32-bit mode.
> 
> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
> Fixes: a9beb86ae6e5 ("sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
