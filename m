Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F134C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D1C2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 19:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555788314;
	bh=DvJ6iL0TZUjWiV3hXfk7ezE6ZUGgl9zR0uDZF9dVJSE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jBwrndyR9Y+LJObVFZDNTbgiq+vjleWrL9XrTj7IaJmWPkLOm8UoSza2q6PE/tj0O
	 fwA4vF8Zo94gIfNLJ+6LAEYy0JtpWEQBz/GVEKaoIrYNSMPyQQxrhbDrbMZE5L+ei/
	 2rpg/ME8YnPHngbCIa7gOD76UZHDN4Q6zX96wDnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfDTTZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 15:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727743AbfDTTZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 15:25:07 -0400
Subject: Re: [GIT PULL] timer fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555788306;
        bh=DvJ6iL0TZUjWiV3hXfk7ezE6ZUGgl9zR0uDZF9dVJSE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dzqqu2jzmeRT1po0+tORk+BHgAEqHB6tjnLYi5C5YzMN66ctovhXvAlt00LzrZcA1
         LsmN72P5arErKuZXsQhLsooU4U9V6vQpfsuw/ChfRESJ9CIEVJn3HlxX7MFqBsb4Cz
         qXPxOfQDfMk4FnmBUoBGe4BB+3A5EGJ4j1AO9vY0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190420074550.GA24140@gmail.com>
References: <20190420074550.GA24140@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190420074550.GA24140@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 3f2552f7e9c5abef2775c53f7af66532f8bf65bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e899cc3b3d9813f795c039c0f3c689861d6836da
Message-Id: <155578830661.28386.14867873612596469098.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 19:25:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Apr 2019 09:45:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e899cc3b3d9813f795c039c0f3c689861d6836da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
