Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF5C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B338820835
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186050;
	bh=uwRnA4I4+be4Xl6U+DVW6PPtdA8Ac/1gAYGTw+aevwI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=C7+Ad+nB39/mqjFhP//135ag0FJ1xu0+2u6lAbuNY4mgwwirSB7JzHlm1EWZg8AM7
	 b2qUllFUXZkFsu926E3JyVXIGlzaypsQ931TDyh/tP+29Oprri8+Q6+/iWHKCsRH21
	 2kaO+xg6OwgGF/k178MhXclvJ3vNSHnILMlPyjU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfEFXkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfEFXkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:10 -0400
Subject: Re: [GIT PULL] x86/asm changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186009;
        bh=uwRnA4I4+be4Xl6U+DVW6PPtdA8Ac/1gAYGTw+aevwI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vGXBEou2YSvmGDcsrsnDH7aFGO+ZJhCGSGfXmmyCy2THpmQJBZixyuoRf6QFr7phm
         bLtN7vUw68OKu/NZfGF+P5CAA1xhCuEc2zeQmPkPRpajkt/p6hncNDybOZfnDIeHMm
         0LzQ5epju1sQgzeoFrVAVKEmyV9+Bf+h+MsgT5rc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506093503.GA55099@gmail.com>
References: <20190506093503.GA55099@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506093503.GA55099@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus
X-PR-Tracked-Commit-Id: 3855f11d54a07256cc4a6fb85c692000208a73a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f725492dd16f516c2b67d7cee90b8619d09fd534
Message-Id: <155718600985.9113.333747498404919302.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:09 +0000
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

The pull request you sent on Mon, 6 May 2019 11:35:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f725492dd16f516c2b67d7cee90b8619d09fd534

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
