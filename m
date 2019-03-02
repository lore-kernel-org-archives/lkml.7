Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF8EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5822083E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551486026;
	bh=/yeb9If6MwaR17cV19O4DjRFnahGJAAV/VAnxajxbzY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=LA1tCyIq81Bv1NIXL2vApygXytTGh6DvovwViLtTSf/r0NwWuOTdQ6dqZlgphw8MZ
	 ZcT+Hv/LfQUyAKVK0r9YqfCn/95d0/QVh2TSYDBC7orPiHMNL3Ai625VXMpjFriseA
	 lD+1Y3+OsRt06VJ6Rlcgtd5Cjd0yMdls+OtPEz7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfCBAUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCBAUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 19:20:04 -0500
Subject: Re: [GIT PULL] MIPS fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551486003;
        bh=/yeb9If6MwaR17cV19O4DjRFnahGJAAV/VAnxajxbzY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1HdkBQIK/ALNaU+K7m/KzoPmx6HG2WCeHeCNSSXIwf/NaCm1AZ9rdNw9ld4WRcdUA
         AojQnPHlvx4bDuOiFEYFBeukpkqSkeneZPgNbbDe6uxG1MSM4pdr2VLcP1XK20IVmz
         nm0hBt/T1NhOJJFHa/EWj5AIPUJzOOg/MJWeZa+g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190301005650.nzsntehn3hpbgcey@pburton-laptop>
References: <20190301005650.nzsntehn3hpbgcey@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190301005650.nzsntehn3hpbgcey@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
 tags/mips_fixes_5.0_4
X-PR-Tracked-Commit-Id: e0bf304e4a00d66d90904a6c5b93141f177cf6d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf23aba19456207c12aad4d841adf7ff40ede2d7
Message-Id: <155148600393.30240.6759664386863831963.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Mar 2019 00:20:03 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Mar 2019 00:56:52 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.0_4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf23aba19456207c12aad4d841adf7ff40ede2d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
