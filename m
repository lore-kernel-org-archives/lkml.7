Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701EEC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C95B20659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564519228;
	bh=ugWXpsFhigfjuYJ4dltnK0ERMdeDSNvAi6z+BURK244=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l/z1klaxda4pHrMbLmQSNSVB4cOs33bSZhXoivTdIOlFlCKLAuI4UsCeFEb4cfI8s
	 bi4rLIJgFcQAlbnkwrQMvmVSiabnmAJ9zej7kyC5OHrbQcUr+ckRW+f20YrekodzYi
	 BDF4Xv1qwcNSvQdCFUkANMSNa5hboFjb7YZlvw5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387495AbfG3Uk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 16:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387448AbfG3UkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:40:22 -0400
Subject: Re: [GIT PULL] f2fs-for-5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564519221;
        bh=ugWXpsFhigfjuYJ4dltnK0ERMdeDSNvAi6z+BURK244=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZibkTTH+jISGoqZ2U9iBBmZy2zBTY3VYqfjjEQvkvTc+nWgPhdQSfhV5+hZqo4m+0
         tddt/6HH5/HbJbMwAuSYCJT6CjdkdqWdSjMAeoOhDVo/yN0kmRc8bFQU8e73POhhV4
         DNriAnArnvWrHxpo2PA2K4AlcYfViy9iC4ecOJtc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190730174653.GA76478@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190730174653.GA76478@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190730174653.GA76478@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.4-rc3
X-PR-Tracked-Commit-Id: 38fb6d0ea34299d97b031ed64fe994158b6f8eb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0572d7668a58794059030b88945f78dfb94e3325
Message-Id: <156451922159.18459.4858636766003450241.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Jul 2019 20:40:21 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 Jul 2019 10:46:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0572d7668a58794059030b88945f78dfb94e3325

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
