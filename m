Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2640AC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA092208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557251706;
	bh=Y1LA9D+kG+wN2ClShGRqO+2LDd+9PEchv/ivXPGwT6s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eQx0HXalbsFXrp9wPB6zpny832s02sBi/eXzy17DnqvB7GmXTIN5YaSMPluk8ZdR0
	 mBaDsm8h7ltvuwZEf87Z4qW+SGi89q7lSQkZ0dMHTE7/s4mYZibX1xg3W+tWa/rvAY
	 aAzlOuxtkM5yOkniy3fLjg6r2y+/QXVOTbR/i5BM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfEGRzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbfEGRzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:55:04 -0400
Subject: Re: [GIT PULL] ktest: Updates for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557251703;
        bh=Y1LA9D+kG+wN2ClShGRqO+2LDd+9PEchv/ivXPGwT6s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YkQl4Wx5ctNQz1m0BldPV1DkpK2MV9UafrzIe6vK9VuS+SgX3Yi4ujmQhspSjNgZU
         8lDlFQE216/RsAesOpGSNvfdtBaHmf0IsD2JArVR+IVN5a+dp89Y7UBX1t5fau3+Ez
         pC8SkKxHw9RyUMu3dhotaddtYJRPl3iirhguQlYI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506133837.55832171@gandalf.local.home>
References: <20190506133837.55832171@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506133837.55832171@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
 ktest-v5.1
X-PR-Tracked-Commit-Id: 37e1677330bdc2e96e70f18701e589876f054c67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68253e718c2778427db451e39a8366aa49982b71
Message-Id: <155725170376.24816.6389425639250250116.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 17:55:03 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 13:38:37 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git ktest-v5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68253e718c2778427db451e39a8366aa49982b71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
