Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6104EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDCB208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551897135;
	bh=R6BcdvzhQBzZLi4Q/iMVAwtHJCjWgE6XPzFqvMic9m4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=JJp7TYB4gYZ8zZ3fylaiKyc9DZa7ZO3f7xMFok1NDW8fkN9H992pwAcq9GO+GtRX8
	 tE0msAAt4M8n+xz3C/pmB2aFoG30DPsp6/hB/TC5NHDylmsUNwPea3p6nCzkeNvErM
	 kMeZxqS15GGyv0wX+uWbNOA6D1RijxY10QbLvtY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfCFScN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:45736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727127AbfCFSaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:30:12 -0500
Subject: Re: [GIT PULL] locking changes for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551897012;
        bh=R6BcdvzhQBzZLi4Q/iMVAwtHJCjWgE6XPzFqvMic9m4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E+jTtQNmCbsX+C1rx3MdMr0sTYipHNxjr+cN6QqCqfZUaAjVLaf/zE6PJjhaJDtLe
         w/WK9if/LmLT33SLfqAv2PrtE145lOw6WEuKwsBXgzWRRVKPNHJKN9ALXjL5Czl3nI
         DrHPwdJN7v5XZWGEbkPJaL+fm9cSUabMvWcdb1Bs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305123457.GA2839@gmail.com>
References: <20190305123457.GA2839@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305123457.GA2839@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-for-linus
X-PR-Tracked-Commit-Id: 28d49e282665e2a51cc91b716937fccfa24d80e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3478588b5136966c80c571cf0006f08e9e5b8f04
Message-Id: <155189701221.14612.15663174153756228927.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 18:30:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 13:34:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3478588b5136966c80c571cf0006f08e9e5b8f04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
