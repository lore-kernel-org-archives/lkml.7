Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62C0C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ADB2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575142825;
	bh=9UAxbB/+sQKEZhw/an7RU+qWhMVAXgU+E0K+loUGkzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FWst41PTh2btUtvxufgNsR8uKBPK0COKapc/MMFcEDsMPzjFe7eq3JaljVQoZkhZv
	 PjHfqhHmVpOgmLzcs36tCUN76zLmLcd9gM6kSz/BfBU6WttWDbEVV1NaVnn7gUPFPQ
	 mGWqrsPWSe3XM7zksAJh5mnFRh9wBbWPTzHQ7tCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfK3TkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfK3TkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:23 -0500
Subject: Re: [GIT PULL] f2fs for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142823;
        bh=9UAxbB/+sQKEZhw/an7RU+qWhMVAXgU+E0K+loUGkzc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HOPSA4MTcLjBcyz7CLWG5myXGF0Dz1uNlSC+wV9k38TRQwV/8pGsQP7xqTWo5lHuR
         lF8vdAT758dw7reOl3m/xm8iFX2QHqWNC0TDrw+rZrnUE/WSW2IPe9E9f4uAmXQ8L+
         yooDptqWugpo29mwriMozG78KdKFOdfqP3KdrsZI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191127200138.GA47793@jaegeuk-macbookpro.roam.corp.google.com>
References: <20191127200138.GA47793@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191127200138.GA47793@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.5
X-PR-Tracked-Commit-Id: 803e74be04b32f7785742dcabfc62116718fbb06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f45533e9db917147066b24903a0d03a5adb50e1
Message-Id: <157514282301.12928.2833431195207322730.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:23 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 12:01:38 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f45533e9db917147066b24903a0d03a5adb50e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
