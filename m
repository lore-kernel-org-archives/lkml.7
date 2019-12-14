Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4C5C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8752073D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576361106;
	bh=xaEz0wG9LqQH4MFeGeCSjdcLemRVij0FnfDoiI4yI/o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EMZ7jCYA7lK2sRr1EgbTz+81whqmyuF4tU5npTuDn+PbBDit++np0l7PmUr2iUXjo
	 hZrrWm753eAVdYV2HHrq7NQejQcHx4OBCJJm6xMq/WxcJMm5ljIicSIF1iIBjAowTm
	 CyJSj+l1TH1tHIS5v0qhwb9gLDew5Gvn82TQhhUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfLNWFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfLNWFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:05:04 -0500
Subject: Re: [GIT PULL] overlayfs fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576361103;
        bh=xaEz0wG9LqQH4MFeGeCSjdcLemRVij0FnfDoiI4yI/o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZSrO7KN0pigfQZn7u/RSxmBS1HArjG3hawvQG227foejItZ1gz5nFn41HqOyYQ0a0
         zfdyiYxdWe1LESiBiRkzHBQ9sVvPncoDXUqPa7dogAHOgJoXvq32Hhu2nOACdCvtjG
         1QDDuujPCllhusxFXJazqKY0VEjQirtyAZoHq2Y4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191213162612.GA5081@miu.piliscsaba.redhat.com>
References: <20191213162612.GA5081@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191213162612.GA5081@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-fixes-5.5-rc2
X-PR-Tracked-Commit-Id: 35c6cb41686c4de03d738fd95617a0cf7441bbe1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81c64b0bd0900405b4e55f3d48a2fc7dd5e1676c
Message-Id: <157636110364.10255.10989126071445906206.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Dec 2019 22:05:03 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Dec 2019 17:26:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81c64b0bd0900405b4e55f3d48a2fc7dd5e1676c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
