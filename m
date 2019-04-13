Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EDFC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D317120869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555128320;
	bh=jZ1MjkckQdXuWt3vVUKW2abc7AvLdz525me5eKvUafY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=2n19KyDmq0V48hR3Tphp1umot5pXuouXhvF1jEwvqwk2eO6vTmU3QKVbkYq+0o1aX
	 /MZ8gWyY/YT8nP5lhGBa5sIXDwQmlJ23mStHFHdemoUoXd7vj8HMvMVbHxiw4ySZvN
	 Uma6DPiDnbq7OvcF4bWae7KCwojZR24iDHMYGKuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfDMEFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 00:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfDMEFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 00:05:06 -0400
Subject: Re: [GIT PULL] timer fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555128306;
        bh=jZ1MjkckQdXuWt3vVUKW2abc7AvLdz525me5eKvUafY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=drNI7rJnmNgjLwD4HVwneLhPnSzHjHZdnf3akgN8rdFvHQEzvtGknwXAum/9TpXgK
         K/SWmOtd7mUshPjRHvAq3CrBbNRDCig0TysYvmzBvBguqjhuaTuvpN1Dg2rOWnKcDe
         zlnsDGbdbMv3JhN/FN8Au159kuxzOBeS9yc05W6c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412130919.GA23112@gmail.com>
References: <20190412130919.GA23112@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412130919.GA23112@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 07d7e12091f4ab869cc6a4bb276399057e73b0b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 122c215bfae884f10a189e6754d9603a06b981c3
Message-Id: <155512830638.12181.15635166236597827641.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 04:05:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 15:09:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/122c215bfae884f10a189e6754d9603a06b981c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
