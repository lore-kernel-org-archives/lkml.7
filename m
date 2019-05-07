Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E956BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD5020656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557262222;
	bh=W7GO06W9Y64TBqyrHqpSRkPObg5RZfDahqDI64mQUeA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=w4CcmR3ctodyMcLOpkH/gK3qL09+TTG9riTji8g4VLfj5j/FmCYwoiE6VXLL6TSuS
	 Zy1JOylO3KIZJeW/4HyL6ZxgiryH6i6BuchBGdgby9kkyOC7q6TjABCuOnixOYs1sY
	 Z50GFyOy5He06e5HglIhdrv4AYNQX0utKPfP3TLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfEGUuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfEGUuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:50:16 -0400
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.2-rc1 - part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557262216;
        bh=W7GO06W9Y64TBqyrHqpSRkPObg5RZfDahqDI64mQUeA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=voRTfxMaOsg7+w+qyVk7X2eAVpXQLSvxCbj5gYFxxaQbAUbSRo/O/fA2bU3ZGml2O
         2ThUeEGq8txMCpB1O4JC3L7yw/w/iUa0BZo2hzQZ1wLjty/gYCnta5xmeqPsL6jToh
         ACB9SMhIUF5GhnjdNP0RDHM2sLM5xz8SBeMW9U84=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507180001.GB11857@kroah.com>
References: <20190507180001.GB11857@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507180001.GB11857@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.2-rc1-part2
X-PR-Tracked-Commit-Id: aad14ad3cf3a63bd258b65e18d49c3eb8472d344
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f678d6da749983791850876e3421e7c48a0a7127
Message-Id: <155726221608.25781.2411969637109326992.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 20:50:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 20:00:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.2-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f678d6da749983791850876e3421e7c48a0a7127

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
