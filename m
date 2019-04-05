Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDC12186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554480912;
	bh=plUQlTQPYkaqkLeaXJBwftjiVOKWe9aVbiuiD5rdM4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0QC1WULKzzxYyGqJE4uTvUuA3IC1+sM8uOT3lp5pdZW2FQl1gNo9G5sBP+NqteUNo
	 +VDT2LP2p0Yt3KXtYE8KkkiEEUgr4ZP2oZKORFTleRndOsfNyU/+CjO0MoegI/yw50
	 iOmBB3MWt0EhEwRfysLbnVt6bsyqJgXtqaFg3CtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbfDEQPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDEQPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:15:08 -0400
Subject: Re: [GIT PULL] mm/compaction functional fixes for v5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554480907;
        bh=plUQlTQPYkaqkLeaXJBwftjiVOKWe9aVbiuiD5rdM4Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Xm4IYvShdWdMhzq0+R0HleCMvmyq+vnL9fsYFAIBE+8ywjzPQBfSAMJMJilt+8ShO
         oIbko7FmwrreH66p9d3r68HBbjWsf2763H6N4LsBgjyAVDHHtJAz9U5IlQgl3GLUfl
         +u9F4dJ7mULWS+Ij773H37UYyz5+RI/Wp64t5Ses=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190405135120.27532-1-mgorman@techsingularity.net>
References: <20190405135120.27532-1-mgorman@techsingularity.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190405135120.27532-1-mgorman@techsingularity.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
 tags/mm-compaction-5.1-rc4
X-PR-Tracked-Commit-Id: 5b56d996dd50a9d2ca87c25ebb50c07b255b7e04
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f46774c6480174eb869a3c15167eafac467a6af
Message-Id: <155448090790.31003.17803897978234402483.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Apr 2019 16:15:07 +0000
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  5 Apr 2019 14:51:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git tags/mm-compaction-5.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f46774c6480174eb869a3c15167eafac467a6af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
