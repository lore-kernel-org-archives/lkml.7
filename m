Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2157EC282DC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A0F2799A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFCAtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 20:49:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50420 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFCAtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 20:49:40 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8C148133E98DF;
        Sun,  2 Jun 2019 17:49:39 -0700 (PDT)
Date:   Sun, 02 Jun 2019 17:49:33 -0700 (PDT)
Message-Id: <20190602.174933.1545607185118348010.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, greg@kroah.com,
        devel@driverdev.osuosl.org, isdn@linux-pingi.de,
        isdn4linux@listserv.isdn4linux.de, pebolle@tiscali.nl,
        holgerschurig@googlemail.com, tilman@imap.cc,
        gigaset307x-common@lists.sourceforge.net,
        thomas.jarosch@intra2net.com, WIMPy@yeti.dk
Subject: Re: [GIT PULL net-next, resend] isdn: deprecate non-mISDN drivers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAK8P3a1JvZNQ7oTLkAe8hA5qkU4=_Jwch=dqUgk2Qe1vR1SAsg@mail.gmail.com>
References: <CAK8P3a1JvZNQ7oTLkAe8hA5qkU4=_Jwch=dqUgk2Qe1vR1SAsg@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Jun 2019 17:49:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2019 14:32:52 +0200

> [resending, rebased on top of today's net-next]
> 
> The following changes since commit 7b3ed2a137b077bc0967352088b0adb6049eed20:
> 
>   Merge branch '100GbE' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue
> (2019-05-30 15:17:05 -0700)
> 
> are available in the Git repository at:
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> tags/isdn-removal
> 
> for you to fetch changes up to 6d97985072dc270032dc7a08631080bfd6253e82:
> 
>   isdn: move capi drivers to staging (2019-05-31 11:17:41 +0200)

Pulled, thanks Arnd.
