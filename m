Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7AFC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1B620869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555128318;
	bh=wedXUTdm7RvAZxsAaQwgVMYYB20vxCZuk5pyUVYyS5g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wnq9wRxtOf+n//J/OjFQs2raMtL6EhsxLCzmASl+JQXvI7T7k0ZoCwHSDYpRG2lI1
	 Jh8GjV41m7r8ZEVJHpzHTcJ0exV6AFLjmhyH+B/ptTfSghiUVvJNJNBkWu/bwKGZnk
	 pyrKmJj3idmK6inoLjpCp0UyN09pb0KdR5yO3u8w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfDMEFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 00:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbfDMEFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 00:05:07 -0400
Subject: Re: [GIT PULL] x86 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555128306;
        bh=wedXUTdm7RvAZxsAaQwgVMYYB20vxCZuk5pyUVYyS5g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X0C8onorpjSy7n3U2DB/txzEdGwq0DJPKHUgZ/yKw+bVlL1HJG77ChsMpYXqWeQ4Y
         RMoR1aKpingZY48DCZVIjm474KjNwXYjUi2ZmKj42XmJG9ulGRBT0xY0IlWuj8jq13
         /NaB7W2nbTbniwgLaPB/jHL78WrAWAJEGr4me1sY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412131042.GA52595@gmail.com>
References: <20190412131042.GA52595@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412131042.GA52595@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 5b77e95dd7790ff6c8fbf1cd8d0104ebed818a03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d0a598489ca687e1ebac37eef546526eca41347
Message-Id: <155512830690.12181.2303722183603697397.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 04:05:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 15:10:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d0a598489ca687e1ebac37eef546526eca41347

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
