Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990DBC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBB720862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557853517;
	bh=pq/RxXYpWB1X4gKKNPp0P5P26ha5ACHS4BHT23x3oBA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wOr4nizWbmFH+VK36U4FPm5tiwfsGalvTzHwon2h90icFotCxULGa2BE7835pFlh1
	 IG52IJwh3uCG4TH9vIxXVQUFKKrxSbmPUL9snfjW4iAVPdoDapiA274bz1gq0/Ujyg
	 Rkq8P+P8nUNxa65AVzWt6NnZqxKsgEaLOgiY+iAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfENRFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfENRFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:05:15 -0400
Subject: Re: [GIT PULL] f2fs-for-5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557853514;
        bh=pq/RxXYpWB1X4gKKNPp0P5P26ha5ACHS4BHT23x3oBA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gVIKapJdGhvyAmhK+AOBEX/oha51bxg9VQvtkh2w/kHU5lyAgo2L0jb3vWO77yKm6
         r1XxO4Fvy1Buox2MDhzB+YLtDKdIQ9EkhKPYB86pxUwjfo0UVtYeEUjKYXLSqIXsPq
         XrtUh/RXtZelLSOMk3cZ2uIXRIQY49Az2o7oGO3k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513233818.GA33287@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190513233818.GA33287@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513233818.GA33287@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-v5.2-rc1
X-PR-Tracked-Commit-Id: 2777e654371dd4207a3a7f4fb5fa39550053a080
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d28544117fa9dcd0d202aeb4459bb15f42bb7de
Message-Id: <155785351467.31213.16662192776100044634.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 17:05:14 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 16:38:18 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-v5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d28544117fa9dcd0d202aeb4459bb15f42bb7de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
