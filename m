Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF6C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CCCE206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552257018;
	bh=8269LDPKh/6jz21e+5l8FXmDmnerk+CEznzKhttjpOs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r+YAocR8yYptsj25TH72TiXIN01e0ERtO7bVI9Bp20Uoa89yby5YXH1eB0pwjgoMq
	 wEbhl/3XBMq3DEjMUKk0z+2lh9n+yZqOzeA+FvpRiBfO+A+B0JtcVIZErwnBPBzDgC
	 BeqmVdSrh2NQBWN4hIXIQvY3y8Hej0RuL8cDex44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfCJWaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbfCJWaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:30:16 -0400
Subject: Re: [git pull] IOMMU Updates for Linux v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552257015;
        bh=8269LDPKh/6jz21e+5l8FXmDmnerk+CEznzKhttjpOs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r0UT+3KkS/shkYgObhtJAxKHafV+Zkuub4RtDEsJGYYkw+mPUSyrPpQBuc6xntcjF
         fWPXrCuhoJzWjvjeXEapj1Tv/d0DKopnOgWJM34291+FogEx3o/GCzpdl6EJ2bq2R8
         yEXN0o1s5NCuZlYWhiOwJyijlUKO8Ec45gLw62Os=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190308093422.GA14090@8bytes.org>
References: <20190308093422.GA14090@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190308093422.GA14090@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-updates-v5.1
X-PR-Tracked-Commit-Id: d05e4c8600c36084ce9de6249bb972c9bdd75b7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb97be23db2a296c5f8b8b4c40feb0435b068c5e
Message-Id: <155225701554.14748.6541516577685397615.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 22:30:15 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Mar 2019 10:34:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb97be23db2a296c5f8b8b4c40feb0435b068c5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
