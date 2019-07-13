Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A0EC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903ED217D6
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 00:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562978414;
	bh=TXsKEjoyPcEzIhqKMz4iKUFUjg9pRr3RvRnxuJ7n/zc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=jFdf15d8c7wPbbvPfrYJz+8zcVTQvb9MR05cAW4kwV0C0BUlhLnGjX+xdyX3KSirx
	 CJ+o61GU5LAsn+hXzpMacnd4RVKKcAdxCnuKO1TQm0t+YIiDhGDMxbHHPyEag4jimL
	 OFsV4tHXXsx3ToJrX2S5GM4ovcLzW4ZJ/m0iVWFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfGMAkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 20:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727577AbfGMAkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:40:12 -0400
Subject: Re: [GIT PULL] f2fs for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562978412;
        bh=TXsKEjoyPcEzIhqKMz4iKUFUjg9pRr3RvRnxuJ7n/zc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R+xOtmTKsZDqhSEOIeh84R78A6Xkr7XfL3aPmFpLS96tI54TXzOWdBN5ZzfNvGGhZ
         9WmbYQBLWuonmFvDhHCMVUybbEGL3Vm2KCs7wck+aQ0iC8eq1L++Kzm6rE+Jm0OlvQ
         1gyXaQLtZJwSm6Ihu4JOq0Mm6pNSbUADh4fdSe4s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190711171336.GA66396@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190711171336.GA66396@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190711171336.GA66396@jaegeuk-macbookpro.roam.corp.google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 tags/f2fs-for-5.3
X-PR-Tracked-Commit-Id: 2d008835ec2fcf6eef3285e41e62a5eabd1fe76b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a641a88e5d6864f20b2608cb01165c756794e645
Message-Id: <156297841209.30815.16710657427970608487.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 00:40:12 +0000
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Jul 2019 10:13:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a641a88e5d6864f20b2608cb01165c756794e645

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
