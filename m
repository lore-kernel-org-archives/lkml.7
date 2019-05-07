Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142F5C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4BB20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557262218;
	bh=bFYzCulKnlQaktJgLx6OcN5O3WW2oSEEryMfMcDBkrg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AK+Wr/PFerUiPnyIAeDWOj7e9Lc2gEotP4iP732uAZ9ZO6lCOb+R/J2M2KMkFrOlA
	 o6wL7ZNZnSgnjCYZ3Wyh+WjX1QgTtBHHMP5VkxWmrgdnTVQoqi6eaZKBZ/hW1C6z2Y
	 vVP7ODQuLTL8Oo3sdc3qF6hWAeZEeJnutXfcmtGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfEGUuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfEGUuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:50:15 -0400
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.2-rc1 - part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557262214;
        bh=bFYzCulKnlQaktJgLx6OcN5O3WW2oSEEryMfMcDBkrg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x8w9wnMsarjCz0AxWFl6PZPAeAGam12PO21RaUAPZa6jD2srCsokPJGbkKHHZW2Z7
         jGtEqk7g/tiINS6oizgcLHxWP+BwyOT3mUQvL7AMDswGo7YYdm3ctdS/6F9BeJqrRN
         8FiJeL9Z/QvlGwDlaLrrTho2KwzvB67v7wtqux90=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507175947.GA11857@kroah.com>
References: <20190507175947.GA11857@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507175947.GA11857@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.2-rc1-part1
X-PR-Tracked-Commit-Id: 24f1bc280bcedbde1c05bec2d9f7fbef4a7579ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2310673c3c12e4b7f8a31c41f67f701d24b0de86
Message-Id: <155726221491.25781.5137340056482589695.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 20:50:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 19:59:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.2-rc1-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2310673c3c12e4b7f8a31c41f67f701d24b0de86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
