Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5C3218D0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553452814;
	bh=+tjmRUa8U7QBUhiIo4bwpzqGH+0iZ8gTBqgVJPSu7Co=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZQbdJ8NDIxbHizYIFaMpRDeYAkmDwTUObiTJpr+irg1eh0Z/ZaxEM1agszbP43ZkJ
	 znRHD0FoDsZJrY+tIXo2xBAd+ecgtSBfTVPD4mj5GV9P2idGU2XtbDj01hxuoCzUHA
	 9PpyO1zAdTTDcjJ1U+cdw89sbbN2oaqR0Wwb3uNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfCXSkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfCXSkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:40:12 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553452811;
        bh=+tjmRUa8U7QBUhiIo4bwpzqGH+0iZ8gTBqgVJPSu7Co=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cLiG6Wq2EKK3GmJTcHj4w/rzTmkN7rZtUnKp4UvtILnVvukTMMFBypn0YbnrpHEtP
         gMeWcZyYR3UktyEvmC3UehEhCbWHhfCdQ+V3LFJky9s8zcGXq9Ua1MBAcEee22sxZk
         XuZXyNJIRHoSzhny3cfu7SbOU2gx0KHxNCaaDffc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1553357813.3120.4.camel@HansenPartnership.com>
References: <1553357813.3120.4.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1553357813.3120.4.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 7f5203c13ba8a7b7f9f6ecfe5a4d5567188d7835
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fa8109f9a47804a180c93194b6261324f9dc647
Message-Id: <155345281156.5356.13112122875539427250.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Mar 2019 18:40:11 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Mar 2019 09:16:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fa8109f9a47804a180c93194b6261324f9dc647

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
