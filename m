Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EE4C2D0D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FC1206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577041823;
	bh=YfWTIYVK56PIbIPGF3Bmjaep887Bz+cN6kG0zc76fUk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=yVp4gM709kkttQXQPwxGNEhoGxpIy/UrCVR9rHaZSAmxpIDsdUKAEhRUInHCPuwDS
	 sPQB3ddNChatNh61cXwy99/KH3mWeqxTIDRAyyzry5lXWb4KDEnEezdMvlAC1jbGRX
	 41J22/a1qKmL1Teg6LDvVsoQSyqh/pYTvxIjQXMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfLVTKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 14:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbfLVTKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 14:10:10 -0500
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577041810;
        bh=YfWTIYVK56PIbIPGF3Bmjaep887Bz+cN6kG0zc76fUk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=y5kJylr3GC6pE9akhHFz5iy681LBzim/zyo7744doxAj2rF7lBU1feBt/fM1G338H
         UONURQCTi1JLp4mTG3t4wZ9iRm7sAhY3KbhI18ngNHOv2a5C5YRitN7SIPjdns1Kgg
         3gkWezhBTHuFYMXOPzLfLufh+K09BimqYDAprCUY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191221.180914.601367701836089009.davem@davemloft.net>
References: <20191221.180914.601367701836089009.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191221.180914.601367701836089009.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
 refs/heads/master
X-PR-Tracked-Commit-Id: 4bfeadfc0712bbc8a6556eef6d47cbae1099dea3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78bac77b521b032f96077c21241cc5d5668482c5
Message-Id: <157704181018.1067.8027416307442100041.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Dec 2019 19:10:10 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 18:09:14 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78bac77b521b032f96077c21241cc5d5668482c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
