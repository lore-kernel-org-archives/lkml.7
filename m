Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67531C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380652089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 22:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570919713;
	bh=sxteCh0WB0+0CfG93mkx2d/i7sDBr8ku4nNPcRsYCro=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sYPN23s/Q6HC2o/mHjObJ50NKwH1dKhvxBDEvZRgQGACbj4k3D7WIhNdRwdOswQko
	 KOxTKTa6uMPApQTDDWos2ZqbzU9YGHcEXQXJt+Eaw2tTBXSMgCtiG8YTlTZUtmzG87
	 rnioDlh2+9hmK1NP89rmeSksxt2uJQwthSVrJBt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfJLWfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 18:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbfJLWfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 18:35:06 -0400
Subject: Re: [GIT PULL] scheduler fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570919706;
        bh=sxteCh0WB0+0CfG93mkx2d/i7sDBr8ku4nNPcRsYCro=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FBf5vUScX+ISJv2IU6tWrS+sPIYkVIS8wyF0kY0YFP0UpzLB40Chz5ahGW58c3g6U
         FmL+KU+tYta+oVMUpzX+n5ew8HNz0SaQJSsa7/199nHBlsId8xD6Yo0cbYOHtm9uCO
         ZjrzkOzv4i5Hm/vssJSWB2aTEuwRCxyHNh9whjYc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191012145836.GA15662@gmail.com>
References: <20191012145836.GA15662@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191012145836.GA15662@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: 68e7a4d66b0ce04bf18ff2ffded5596ab3618585
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 328fefadd9cfa15cd6ab746553d9ef13303c11a6
Message-Id: <157091970604.17047.5711431875513693007.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Oct 2019 22:35:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 16:58:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/328fefadd9cfa15cd6ab746553d9ef13303c11a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
