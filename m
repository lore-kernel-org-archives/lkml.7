Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A03C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7F62087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564245319;
	bh=kQHybOH+KZUF4RS9gJUshF+9AlizwSnN3pGz0hzMgFY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=s2YwWVqWlOaENXtJeGhigOeRJeJP2aOfM67gbLQt5sNFVpX5h32jKl06iHHr6Hr3T
	 K1Evi/44QdqMkWpJbkmh4i4yCbscS611Wyfpmle38pTdj6mv8EIVDP4AiORhVR1B0r
	 2GphNd4M95NZLxyyxQfPUe/7JpN08uNPDANTVsDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfG0QfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbfG0QfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:35:17 -0400
Subject: Re: [GIT PULL] libnvdimm fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564245316;
        bh=kQHybOH+KZUF4RS9gJUshF+9AlizwSnN3pGz0hzMgFY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RyBVuIUKorBvWPcPemozSsOpVYjdAmxWUYTHE4SsoTIDXStCIS/RMZJ6fMmzHHyJv
         wi+I4Y9Lggh/SZbGwKnzWpAVsVKIQixZeiE8RJCjP/IGh2waaC2IqbxyGfuHb8lETf
         OAhgG2zg8GurZFsjR98PYknMNOZ/eeQ/OhEhwkX8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4gqE6zOoSibTgjbWWHE3VVQ0wSJN-NxwF288nTe2Z3yzA@mail.gmail.com>
References: <CAPcyv4gqE6zOoSibTgjbWWHE3VVQ0wSJN-NxwF288nTe2Z3yzA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4gqE6zOoSibTgjbWWHE3VVQ0wSJN-NxwF288nTe2Z3yzA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fixes-5.3-rc2
X-PR-Tracked-Commit-Id: 87a30e1f05d73a34e6d1895065541369131aaf1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 523634db145a22cd5562714d4c59ea74686afe38
Message-Id: <156424531666.2399.2050042384173075795.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jul 2019 16:35:16 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 15:53:47 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/523634db145a22cd5562714d4c59ea74686afe38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
