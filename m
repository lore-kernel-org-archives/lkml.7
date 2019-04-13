Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1992C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35AE218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555128311;
	bh=MccVYRzIubZ/RHSHRqAoM2BaXCv59AvjY+aYH+WhrcE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jL8IpxoieBiNQs2iALuu6kjsuhLRwBzNo2bYmbWMR48rBWDjkTtQBsqat2v9ZHscI
	 UmsktR4+G0NjDwz9gl2wudnqx51l5DQfKzq1oxuHxbo8Tg2f0RdQNNYp+mW0IGMNeU
	 6F/Q5bk1xl4BP18w/QvxRqhMmYU/Yr59fE9WAZ5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDMEFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 00:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfDMEFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 00:05:06 -0400
Subject: Re: [GIT PULL] perf fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555128305;
        bh=MccVYRzIubZ/RHSHRqAoM2BaXCv59AvjY+aYH+WhrcE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IoKeP4ypTbm80lZKS9DHDIeeJdJH7aHr6BsoJTNWx1n/Ch8rErapKQYV5MoihYbmK
         sAf/0WZhkAn6Xk+hN2HyF5GXs5TLod82NMl2OqApaciUHPG6JMjf7yt3/HcqMUeA9y
         cREHcc2MHp451zox+oit1AuVgZ9JdcaMhy3Pmg7s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412130642.GA29980@gmail.com>
References: <20190412130642.GA29980@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412130642.GA29980@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 1d54ad944074010609562da5c89e4f5df2f4e5db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73fdb2c908c64a32e11c72c029d636f556859c0d
Message-Id: <155512830557.12181.16955231701323216869.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 04:05:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 15:06:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73fdb2c908c64a32e11c72c029d636f556859c0d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
