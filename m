Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4D2C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FC2217F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562636711;
	bh=3pQxoa4wxE1fHPq0aY4N0GeNMezeaWKpp8y9zbbC7uk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vOPdog6k9Lz3ctVoXt+UQodJQsb7jkBFoZb2FpWq9NaiyP51SZ5KKgKwxaJIPQSCJ
	 v3s/On+8DnZ5hzwAa5w4DA1dFYc3LnUGFbyXK5FPjNAKs4oNwJFcbAjwxHih9Jm7H0
	 3c7UT7ZrhjWekwOvCqf/FmMixDltHUJBM/Ck7Uac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfGIBpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:45:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfGIBpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:45:07 -0400
Subject: Re: [GIT PULL] scheduler changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562636706;
        bh=3pQxoa4wxE1fHPq0aY4N0GeNMezeaWKpp8y9zbbC7uk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=w45foDUICgleUpcUXLfcB3pDOOVAY0JQ0FJNF28/Ljsoj3BgoYvy0msIU5YtVlBL7
         zTk8u0+hhBcr7N8LrO5aipf48k6Xv4G8yNNqkxw8gQh9YdXNDREkElIgZM5DNK4MeG
         yMcYJkxcsHGv93u7y/CrdYjetDjkFmOZjZLXuaWM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708115349.GA14779@gmail.com>
References: <20190708115349.GA14779@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708115349.GA14779@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-core-for-linus
X-PR-Tracked-Commit-Id: af24bde8df2029f067dc46aff0393c8f18ff6e2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dad1c12ed831a7a89cc01e5582cd0b81a4be7f19
Message-Id: <156263670684.17382.3495666365946701708.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 01:45:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 13:53:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dad1c12ed831a7a89cc01e5582cd0b81a4be7f19

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
