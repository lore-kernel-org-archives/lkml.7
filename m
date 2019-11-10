Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC27C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3702077C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 21:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573419623;
	bh=HwMbOB/WC0mPfFWUy/COnP0ySwYWrQG0hBhCyHK80DQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KDkbTb54vPn9newzDm03QiklKqv1YShUPMiHeaLb7dikvPWycytbq7Uu6xg6GFgB8
	 p/hwqcWN51gNDAdetaQtDV8RlUL8Ji5zxycV9c4HaHsDO4TjI3VyJFUG10HA8VzJOm
	 IMNdchBdMQ/HIspLe2qZo3ZFUQAGroeicNsIRztM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfKJVAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 16:00:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfKJVAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 16:00:10 -0500
Subject: Re: [GIT pull] timers/urgent for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573419610;
        bh=HwMbOB/WC0mPfFWUy/COnP0ySwYWrQG0hBhCyHK80DQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xsGQWMT7HgN2IxihiZwERTS1WexgJSoW2B8udPi/BRDZnzPRL53/hdCozf8ueriLn
         NP2ef69EN/Fn7+9SLkDpE1yhvE1Hcv7I/yeKOMT7IIJBhWsykBvAaQhnfZfxP9EpcA
         2GcCVKBVX4kqsQdgnJe+QbGbvDOWT8zrCT222V2g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157338131324.14789.9347520189915553665.tglx@nanos.tec.linutronix.de>
References: <157338131323.14789.2179255265964358886.tglx@nanos.tec.linutronix.de>
 <157338131324.14789.9347520189915553665.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157338131324.14789.9347520189915553665.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 52338415cf4d4064ae6b8dd972dadbda841da4fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 621084cd3d8cb31aa43a3e4cc37e27e3ddaab561
Message-Id: <157341960998.30887.12298700896809310314.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Nov 2019 21:00:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Nov 2019 10:21:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/621084cd3d8cb31aa43a3e4cc37e27e3ddaab561

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
