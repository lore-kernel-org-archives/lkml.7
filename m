Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99D1C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE8B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186018;
	bh=4IjNN10d33zUyJqJSnZ2MgUg2B5Q60TZIhX7PR0427c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xBDPddPyeLlKdyWTYsE9rTJVHvbWPu5SS0Pfom74GNxv0A/pA0akMYdIoOqDT6UUA
	 eE0rSWn0a1e0BKdHBdoX+C0zBwERNXHKf2FAV9FSeMy7hxwPyZVlUDQDN0np8HcKYa
	 yYUv4egAG8zUPnkbOxjyCwVzppvDobs3GvrnxBzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEFXkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbfEFXkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:13 -0400
Subject: Re: [GIT PULL] x86/kdump changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186012;
        bh=4IjNN10d33zUyJqJSnZ2MgUg2B5Q60TZIhX7PR0427c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NDvMo/KwW0EvhT30xdGefHxIjlUwgSWkt1+pxxho1/hXTndFdnLv8AkF+Z6FnlQl8
         uer/uV04ZOXYbo72Rb0OKdmLSbIU2xCZc35oktPE2MRoD6rBp7Au4zbbbla26x1XfF
         +siiWo0TzM2nbueHKEP6mJt9wX6HLV+MZdXN9jCY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506103209.GA124678@gmail.com>
References: <20190506103209.GA124678@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506103209.GA124678@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus
X-PR-Tracked-Commit-Id: b9ac3849af412fd3887d7652bdbabf29d2aecc16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e913c4a4c21cd83317fafe63bfdc9d34d2910114
Message-Id: <155718601259.9113.1293832054520715853.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:12 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 12:32:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-kdump-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e913c4a4c21cd83317fafe63bfdc9d34d2910114

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
