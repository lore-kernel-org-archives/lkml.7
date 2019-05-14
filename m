Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48014C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1916920879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557853505;
	bh=gW4ODTSZ9gWxZPFs+wds3sb/89m4vZDdtK+HsK9r1Mo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VQJ/otxlrwtbMgtfXtGeMLx8Rkj8ItrPw/jFiRFFKiKfMJUWBMvR90cmxExUe429D
	 ABett986hJZNuSnHped4GMFSG0O2ayzFVDBJce54lBGwDW2zOf1uF6Mu4trC1X2esA
	 N9X8OqJhvSar3ldP1VE8kbUvC4k+qNCumEy33LwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfENRFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:05:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfENRFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:05:03 -0400
Subject: Re: [GIT PULL] fuse update for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557853502;
        bh=gW4ODTSZ9gWxZPFs+wds3sb/89m4vZDdtK+HsK9r1Mo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E3VuLJBbgyWQbLFVFU6tRWHyxFokHT2eukEva1UgJMV0jXcBLJy+wXWJy7GAq2Umg
         /F+abVpXAGvmDqjbhh/v0rMnXM+UM9aO7TJg4YqcWT4dI/9LKUN5ZGNcyU4ijTzI+V
         gW/ktc8+MMYtZ7I8Ut0tTqSdfriOf0yOsmGd0KTc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190514075136.GA7850@veci.piliscsaba.redhat.com>
References: <20190514075136.GA7850@veci.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190514075136.GA7850@veci.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-update-5.2
X-PR-Tracked-Commit-Id: 9031a69cf9f024a3040c0ed8b8ab01aecd196388
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4856118f4953627e9a087253766b9e7361f5f4a0
Message-Id: <155785350294.31213.11114554884607214967.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 17:05:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 May 2019 09:51:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4856118f4953627e9a087253766b9e7361f5f4a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
