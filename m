Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887D9CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CC821721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572294017;
	bh=0GVnVRNGBGu6Hx5mWyqIxPrEiVxA80/tdLfm/CA0CKo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AbUUb4VMVbZwaEQ9yPO0FRZf55jzZZAIW0xbrYkcQWOA6tuVnLjGjym2DdStdBgf+
	 3SuenaoN6p7YIrJWg6vHvBmSZHErwvYOhWusB3AQDBpHkE4wuBuRts0kxcjuE6H7Pq
	 VZvoOow3Nf4x9NJF0c5up/nLZEPcHVxQpCBnXni0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbfJ1UUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 16:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbfJ1UUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 16:20:15 -0400
Subject: Re: [GIT PULL] ARC updates for 5.4-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572294011;
        bh=0GVnVRNGBGu6Hx5mWyqIxPrEiVxA80/tdLfm/CA0CKo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dRuGmvtE8Vlj5Bvi9Vy88KijkiyWpKLjpbw2kaW7kwnr8Q/a543vTV1KGkPvVq3Ib
         /b6/gpP7x5sKCjXHrbwiIcr+ACastFj25h+oxDAhBDZw6bG0Fn35ZumpGSWT8qQvvl
         wUjiN180cWNwT+PS28g+5sJBRU9YPbjpB8NYAjS8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7ad0416c-af35-48e9-2d79-479d4a9d3e85@synopsys.com>
References: <7ad0416c-af35-48e9-2d79-479d4a9d3e85@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <7ad0416c-af35-48e9-2d79-479d4a9d3e85@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/
 tags/arc-5.4-rc6
X-PR-Tracked-Commit-Id: 5effc09c4907901f0e71e68e5f2e14211d9a203f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8005803a2ca0af49f36f6e9329b5ecda3df27347
Message-Id: <157229400538.20529.9540881766939671045.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Oct 2019 20:20:05 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Oct 2019 17:13:18 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8005803a2ca0af49f36f6e9329b5ecda3df27347

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
