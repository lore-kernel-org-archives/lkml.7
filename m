Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0169C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE7B206BB
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556474706;
	bh=3rbooFoZh7yUJL6ZgLXgyWcgqhriibYiwYKmo95LBPc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZSyxzsnXOnlIpnH3MO9XNQYw4vxsrB7f2EFht+gXL/XWtNxVHxZjxyJ8hGNaNaWZF
	 abAoQooKPm8FGPHQQLgMoHyUQ3nxKrzTFcCBrRhVSd3wdFoGSR5fb12ALdLPdA342i
	 n7QwaN6melfRFgVXs8FyBJ0rT8qP5bN9EG1taUks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfD1SFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 14:05:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfD1SFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 14:05:05 -0400
Subject: Re: [git pull] Input updates for v5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556474704;
        bh=3rbooFoZh7yUJL6ZgLXgyWcgqhriibYiwYKmo95LBPc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jLWoadLA1h6i6pxzdyeaZ/AbEamrABNvev3+A09MDVlE9rNnsu1BDLkztHtnKE6DW
         e3j3vfBmrZgvKG2iqHdJCHEfkKAuiMcvtvXTjkjSzqoNb/9BOwWNZqvIs9QjHqK5R9
         oBqZ8YxQ2stVibKi5MQ8U3yKZiFsc9zkPnqzXG+U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190427223854.GA97206@dtor-ws>
References: <20190427223854.GA97206@dtor-ws>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190427223854.GA97206@dtor-ws>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
X-PR-Tracked-Commit-Id: 3a349763cf11e63534b8f2d302f2d0c790566497
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25cce03b1d06e4b742f6dafdda2f4d80c13bdc18
Message-Id: <155647470441.13942.8221776669979952197.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Apr 2019 18:05:04 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Apr 2019 15:38:54 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25cce03b1d06e4b742f6dafdda2f4d80c13bdc18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
