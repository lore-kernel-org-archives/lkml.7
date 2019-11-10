Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F73C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259A421897
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573419615;
	bh=RVcMyug7TVUlPGUb5j1hyftLTRLuS+IEaN9Ut5fA29A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iimlFg5WVKvD4VZEMVFmAnafb6I3msD2mmtw8gWw6onev8tcfFWuAE6rKogrIhbfr
	 w2o/7rYStF2WHVn//AviVvAWhAEAa2P4XXOkKb2TezlZxHKJklcRW94X9GOtSZba8J
	 Nv2y3x98SOlt1NC2VxG0vrTgyuC3zaDbPlFXh6DI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfKJVAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbfKJVAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:00:11 -0500
Subject: Re: [GIT pull] x86/urgent for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573419610;
        bh=RVcMyug7TVUlPGUb5j1hyftLTRLuS+IEaN9Ut5fA29A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V+aPWa5dMpclsZw5LfisvcMWQTKUR4aUtBOaXZBcLj5EYLkW4EDrvQFMHI4I8afH2
         I2nhkYpjDq7pmGxQ6o+UzRcijwTuP7nqcewokJaknb6xh1d0ZEIZJl5TaJmHPoY8db
         YUvbSLRjwmGn+VTxHh68eF9kwMgFdIZe37A2YzG8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157338131324.14789.8363441947094006311.tglx@nanos.tec.linutronix.de>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
 <157338131324.14789.8363441947094006311.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157338131324.14789.8363441947094006311.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 63ec58b44fcc05efd1542045abd7faf056ac27d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9805a68371ce01eee3d8491ee2d93f1aa4a4da52
Message-Id: <157341961084.30887.5537671346645797981.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:00:10 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 10:21:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9805a68371ce01eee3d8491ee2d93f1aa4a4da52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
