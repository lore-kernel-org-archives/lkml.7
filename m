Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF2AC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708BE2077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575595205;
	bh=fwK3BcHo1+dVZkoSSxwpYLxOqYRZgUM2EgpjJ9piv9s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EOI71FN8zTjGqqIZbkwDwsNzGzigbeASNcM7YJL8Ksj9vzr1Lg51VUPEJfNVjQUXq
	 rJ6Czzmfw0od2+Q0UPtbTOOIUuOSXs9MzQhT9EMnxGc4fW20zTLT82NHIqkw/QjS8s
	 wndXDfLm1BMtLa4VWiqtI/KooLnfpyn+SMyawveU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfLFBUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfLFBUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:20:04 -0500
Subject: Re: [git pull] vfs.git autofs-related stuff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575595203;
        bh=fwK3BcHo1+dVZkoSSxwpYLxOqYRZgUM2EgpjJ9piv9s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fvbPOF6UvqJZCwUgb2Nnjkl+RZbJFRTKKLKxzhJ6VnHPGKUyI1LOZ0vw2aCJf1Gzq
         KQHgNVCObcglbknqnfsiZc/uMcCVkyiJG20vOFFGTphlleWLxVcC3sfBhoitKyXI0b
         prHGypj3RUkKkGCrKw5VDTIGVivnNQIxi/gJGoLI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206005853.GK4203@ZenIV.linux.org.uk>
References: <20191206005853.GK4203@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206005853.GK4203@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git next.autofs
X-PR-Tracked-Commit-Id: 850d71acd52cd331474116fbd60cf8b3f3ded93e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0d4beaa5a4b7d31070c41c2e50740304a3f1138
Message-Id: <157559520361.10034.8784267850677909678.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 01:20:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Kent <raven@themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 00:58:53 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git next.autofs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0d4beaa5a4b7d31070c41c2e50740304a3f1138

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
