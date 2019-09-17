Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CFDC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C4321881
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568751332;
	bh=fmm1mdqnUtzyeE8pdxMt/q8UNb9M0TYV9rKEVUVKMcg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HyPSIHJvfEizONNKxMEPlETy6LQAXhV/GcEpktJGPLYPzDNPnCWm/Ormt0VD/omPp
	 6hNOb9YtEMgdRZgxpY/Io+rVzW8kXvkQ8X0wSvu4onu4avL+x+D/9X2vLwoMjMD/hA
	 TogJnhK1A6WSB8bnikgY+AXuZV12bRvsB4V+P9u4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfIQUPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728710AbfIQUPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:23 -0400
Subject: Re: [GIT pull] timers/core for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751323;
        bh=fmm1mdqnUtzyeE8pdxMt/q8UNb9M0TYV9rKEVUVKMcg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qabaf1f94LYnnpT7WOdo064dris9ylElJUKz7yLEQiRnAVo+pFT8g5OPd6XzH2RbD
         VkxeZclkcmX8O0WeSJioKrLpY0ZoG4l8501Yn8pqbxmjlyFcepIhbhyj9hwDhUXF87
         6VSwovmA5MTHPFaca9h2kc9+erKNXbNUppa6lrpY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062018.3407.15816124333744004374.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062018.3407.15816124333744004374.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062018.3407.15816124333744004374.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-core-for-linus
X-PR-Tracked-Commit-Id: 77b4b5420422fc037d00b8f3f0e89b2262e4ae29
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f2444d38f6bbfa12bc15e2533d8f9daa85ca02b
Message-Id: <156875132328.8483.6430458411807166031.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f2444d38f6bbfa12bc15e2533d8f9daa85ca02b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
