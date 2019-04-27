Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6530BC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340F62077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556390714;
	bh=YH+9pMpD4g/FJot4jzbQOLlp81V9Emo5oMTvEy+ncW4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rwGkUHWbPE2NAX4j2OWoC5GKgJT+he7e2ky3ihrc4732MgxzmL09x8bqNlvfxhw1x
	 1dVck+b8zXkqKx88f/HaE/Z/fLcvX/xeXrX/HBhUIIH+PCxlTwk2tw+YCBZsC11JBT
	 RuXYDhYqKbR148iJ8GCxWuCDguXN+l0BZsRnCd9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfD0SpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0SpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:45:04 -0400
Subject: Re: [GIT PULL] perf fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556390703;
        bh=YH+9pMpD4g/FJot4jzbQOLlp81V9Emo5oMTvEy+ncW4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hWhKhRW9rY7TD3m4/UOm/tkUu1iUfU88JPXJZ2MmR/YjAaru1xzrNrhSL+aRY/GDP
         GppbGb1s3cDpe+BoaBYzMAyr0n1vSCVNoyabMJe85Wxh6SvfMJ2yozvCJKQE5QNrQW
         WnF5cazewqCWnUpyArvGPcKm0VqOBT5Hk5rkIfCg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190427143818.GA8253@gmail.com>
References: <20190427143818.GA8253@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190427143818.GA8253@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: 82c99f7a81f28f8c1be5f701c8377d14c4075b10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5084991663650a238dd9d1981e09eef00a90594c
Message-Id: <155639070360.28176.12214363277376039628.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Apr 2019 18:45:03 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Apr 2019 16:38:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5084991663650a238dd9d1981e09eef00a90594c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
