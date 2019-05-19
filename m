Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FACC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 19:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712D7205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558293336;
	bh=cdoS4jhaSaN2PKHWUIgEcVvEzctc6XllgRQPoE5L9+Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=toqH7ULZMfzlncmKLI1NwOqjM2BqzZx3wAPCXZ6zc47YGEu9Cg0dyrYiv7h0W8XE4
	 dP9zlJozi7pxmvz8/6ePDprsfj46BNybR5QhpO8ANqwhCa6SD3MMY3BUSO3zhIkIvE
	 5btP/Y6f9qXeGwUPl5iDntLovMrciSGMYJ1EHcFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfESTPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 15:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfESTPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 15:15:22 -0400
Subject: Re: [PULL REQUEST] i2c for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558293321;
        bh=cdoS4jhaSaN2PKHWUIgEcVvEzctc6XllgRQPoE5L9+Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cSYBugrvxY3RKzu4cPpEh0fgjA9y8M0UDoDnqSsCVCUKe0G59VcEBoGEGmNo17hyr
         ssYU3kSMuOjUy64BKtjrS+vNKzrZ95T+rQmoL0MCsovlTTFspmqEW7ad8NHjrjgGZ8
         hpSY9aDeCJ/LJo6UNJVicF2DpHQebiZGnjzty3lA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190518110057.GA8674@kunai>
References: <20190518110057.GA8674@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190518110057.GA8674@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
X-PR-Tracked-Commit-Id: b8f5fe3bc5b9318d95770a09a480c31aced20cd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f23d8719e76fd32828ae6f1b55e4659144467742
Message-Id: <155829332175.24875.6358770579395958283.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 19:15:21 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 May 2019 13:01:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f23d8719e76fd32828ae6f1b55e4659144467742

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
