Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE4CC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBD0208C2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 22:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557094204;
	bh=B51JwvzAS8KjLbX2+CvQYy1DE8ma31YveSrYcGQ8Blc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kQNjnvf5OBxjBd/XELqXAp4+d00CpLq7cTPB5duiqdVL23MobhEflrQogTkqhh/ob
	 DAFBCThNXM5vpTKSLumzD7/Ia/Y7UaIrAbNKNCJF+aFyBqnIuMq9PB5/Ytzt2xAMU8
	 GIZYOV1Ijj85gvtcAD7gFdj0jROv83RedbOFw6i4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfEEWKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 18:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfEEWKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 18:10:02 -0400
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557094202;
        bh=B51JwvzAS8KjLbX2+CvQYy1DE8ma31YveSrYcGQ8Blc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kXmMdUkRZ708+6Dxuw5AQnoN2G03rr3b63aEsYDBC314/7bZ8F9jHyr5LAzfuLWhu
         4BpbpebhtgoDTwuPXbWUbZCoGoR4n3ljPjvyPjYXt+DOAzetAWtwI2P+kwRMfngbq6
         Lbxxq0xIQcBlJzbYT4U8EC/duBkHR+2CKaKC+13U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190505021841.GZ23075@ZenIV.linux.org.uk>
References: <20190505021841.GZ23075@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190505021841.GZ23075@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 4e9036042fedaffcd868d7f7aa948756c48c637d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51987affd626b8e4ce9f4c65e1950cb9159f0f58
Message-Id: <155709420201.22198.11773671266787398222.pr-tracker-bot@kernel.org>
Date:   Sun, 05 May 2019 22:10:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 May 2019 03:18:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51987affd626b8e4ce9f4c65e1950cb9159f0f58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
