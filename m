Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57255C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2414A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186078;
	bh=RhkafdhnbSajgcnFbG+mxw0hzaysraIAabcr51aBl9k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1vHH9iskotg0Xm8wEY0BibD/tcmWtPp8c84/kkT5T4KOLyOj5/84adscIS6fbhT9P
	 17DoJaTpmQbPgtQ23gw0aCmNkaFU4mqbqXYRvamRkxzdTsqKiip5+RJZDsPJpZfQgO
	 ESTqp9XOxnFMTeqOgfJqjthAW8uVsQe55iS2+Bjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfEFXlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfEFXkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:09 -0400
Subject: Re: [GIT PULL] timer updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186009;
        bh=RhkafdhnbSajgcnFbG+mxw0hzaysraIAabcr51aBl9k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LZG5uH6irETWEJbNzFn3uQBc09gOlusAYby98vmPoEmcZMW+/hLyy+peBMyxi8yAR
         JT6DimlbTwwaec2UfCw4XfZBBtny1nUAG+Er+ZBaR7wCuLBrtc6eI+8SeTKEQa5TiS
         OO7qxp2gHpyt23mwe+IgTBqJ/8ri57e9uMrXsOsg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506092459.GA86912@gmail.com>
References: <20190506092459.GA86912@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506092459.GA86912@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-core-for-linus
X-PR-Tracked-Commit-Id: 13e792a19d4e3a1c64e94197ba357685fd584ded
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0e928ed7c603a47dca8643e58db224a799ff2c5
Message-Id: <155718600897.9113.10237766595124193948.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 11:24:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0e928ed7c603a47dca8643e58db224a799ff2c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
