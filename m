Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1585AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D973420835
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186039;
	bh=d8IXytOYOpdhaZMbASJCiYeesdyJke0zUomcP5ABqCI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1YqhNrL28pMXBkjm3Lb/eWhuKI6rfm15t6sMyu7JoH+2bCwORjBmiHmeQqTvQQhVG
	 sqq4AFox3xckQvGRvW2p5jN19wW4StvF/BHPJFdPX5Aqo6MsMKmJ3ZjSPFAop7Y1z2
	 HliMhvekaJut07SO0QLwppWlmYq8SlyOiYJxu0ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfEFXkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfEFXkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:11 -0400
Subject: Re: [GIT PULL] x86/cache updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186010;
        bh=d8IXytOYOpdhaZMbASJCiYeesdyJke0zUomcP5ABqCI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MZwihGNMCfVrH8qG4e70GGMTA04v3y9PaU+mVmSJXC7boyKLQVip5wxiyPh89jRSq
         zmNwE5v0GkTQbaSFVSs6aZh8VtT0g9djgT5uXJm9JTsQH4N5FEDpz1RluoXm1nFPWn
         0XPtLHeYPbtrcUNQeBPSJgZ4YhKe1k43F4CH3ZKA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506095950.GA15822@gmail.com>
References: <20190506095950.GA15822@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506095950.GA15822@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus
X-PR-Tracked-Commit-Id: 47820e73f5b3a1fdb8ebd1219191edc96e0c85c1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82ac4043cac5d75d8cda79bc8a095f8306f35c75
Message-Id: <155718601049.9113.12841659679227918625.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:10 +0000
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

The pull request you sent on Mon, 6 May 2019 11:59:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82ac4043cac5d75d8cda79bc8a095f8306f35c75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
