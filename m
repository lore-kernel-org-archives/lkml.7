Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D340C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9F620869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 04:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555128314;
	bh=VPDu5pXC+odZrD6AgPJKTYBXHUflOPUT9YIjIoooylU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yVjbIJ93D+1x3Ku1g4bIS5xd5xoo9PXahr4aFZxUZm1uQqoNuwd3rE533NF4Hqw5a
	 KVo14I091SruBuOmC5Bewz25UBparPk3v8BgLEH53nKwfKYmNXTNirEGOhH7PIPHCZ
	 PaZJMODkGXu0UvRa+gWj2vC2Cfad+TCWwlfWf6Q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfDMEFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 00:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfDMEFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 00:05:05 -0400
Subject: Re: [GIT PULL] IRQ fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555128305;
        bh=VPDu5pXC+odZrD6AgPJKTYBXHUflOPUT9YIjIoooylU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VPCqMrC9lfGiqnslDwrfkgcw7Hsl837Sd4nnarGFU5e0FzgccMxXbKskmD/xE+XBE
         CGdlvck8FxDIP+dapl3YzHJvCctf+GKOLsHmJRJdWBAXb/Xj7ZUt7Mcp56No6Adv2D
         pjobgbp5xovt0aJdo4k4CSZ4EkibLRcos86+JGNk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190412115219.GA20767@gmail.com>
References: <20190412115219.GA20767@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190412115219.GA20767@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: 325aa19598e410672175ed50982f902d4e3f31c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a022984c3feda8cc7d2d8c028b429715d0af531
Message-Id: <155512830498.12181.16211493984389195244.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 04:05:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 13:52:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a022984c3feda8cc7d2d8c028b429715d0af531

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
