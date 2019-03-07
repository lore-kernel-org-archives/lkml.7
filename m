Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E75C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF3620851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551981054;
	bh=ICb6jOy4yZJk4++BmXDv5UqzzJHhNk9sZdFh+Zu5iVc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=femN4niGerGVj0fa6R9KmvF5Gkzj672NDG0M+XTejTvwWu8HAZSxcHJxh5kobXLcK
	 s6t2kxjSA6jU1d+nKhIiHszBqtnNOTkQMD7ybdgLHiXJo6il0hGWO8qPBL9kx/vNUR
	 7gCTEFqgMQq3nk6RvEasWFQnACeQH2mbaGyVFFt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfCGRuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfCGRuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:50:04 -0500
Subject: Re: [GIT PULL] Fanotify changes for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551981003;
        bh=ICb6jOy4yZJk4++BmXDv5UqzzJHhNk9sZdFh+Zu5iVc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HOBmXLrsYKJf0rpzMjTKUADOaVHSpw6VTfO/0hjJa6aLBw6ckXtq102jpfz7bfGxo
         xPp/ReGNOsofDiiAZoiqZa5GJ2AZcRG3h2DNC6se4xTOflvqv0M4c3YAIEqZ1iADLm
         wtaitlH0LqUbJh4AwsPbPAPfgeZ0tW769rvEDcxY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190301151300.GB15758@quack2.suse.cz>
References: <20190301151300.GB15758@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190301151300.GB15758@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.1-rc1
X-PR-Tracked-Commit-Id: b51905798195eeb427c873643b3ada0d7bd991a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0556161ff9069c938ca5409e1e102ac6f371a1c8
Message-Id: <155198100394.21542.12140201204878480145.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 17:50:03 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Mar 2019 16:13:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0556161ff9069c938ca5409e1e102ac6f371a1c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
