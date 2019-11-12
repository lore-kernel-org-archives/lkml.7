Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9651BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677002184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573518608;
	bh=RqZ58pXyTwOBoreggkJiERbkQNHXSvU7CH9wxsfwQYo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tVutyDPUMnWTwHL18HHEznKqkAFn7dFFx/PtNEIxI5vl2MD4jKR31r8OnhEGSmrWs
	 GCeXdXPqI20jvWWzVx1bAM0AhMWQGY0BvzuWfiuEXu6hKU58G1JY54sUrWgLyNb++B
	 Q1JKgu7bqWCQ3kakGeO7nE6wH2LaN+EylBDAsUOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfKLAaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfKLAaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:30:07 -0500
Subject: Re: [GIT PULL] cgroup fixes for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573518606;
        bh=RqZ58pXyTwOBoreggkJiERbkQNHXSvU7CH9wxsfwQYo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lEeqwWbXl5oXSc9BMUnLxt8yjiQprQB515FX3ut2zjLsghw+7DnzQlm/oeQWtGhzn
         YgpHHJKQcmDxp7E8EdJZ9+WoOi/0V6TjI3RhNuh0dQsgRaLTLQKhnbG0+emca+8omD
         HYivfRXngFjobYr2ZJL0Fxm08h60k6euLZj5FVtI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191111202203.GC4163745@devbig004.ftw2.facebook.com>
References: <20191111202203.GC4163745@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191111202203.GC4163745@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.4-fixes
X-PR-Tracked-Commit-Id: 937c6b27c73e02cd4114f95f5c37ba2c29fadba1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de620fb99ef2bd52b2c5bc52656e89dcfc0e223a
Message-Id: <157351860653.22410.73967541645460298.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Nov 2019 00:30:06 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Nov 2019 12:22:03 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de620fb99ef2bd52b2c5bc52656e89dcfc0e223a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
