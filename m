Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E43AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018BB206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568997328;
	bh=Pm4x8ugJEvM4AU2+xlpk8fa6S6qjlwZ6T3tqeCojBgQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HhRJQAncJtzKqbNBtWKGlAHst8lqACeCMSG4HGIv7ARH/DuZc/RSBs1zGu0Uy/biI
	 K1FDEC3Dop1xphjXb8obI6HnZLHzwuCoXKOa/nbojK3d0Poq9efSo1WrL6nfqz00si
	 0CJDEz4pRvHv06pYMFXjWVo2Af00qUn6RIec3Pu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404759AbfITQf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 12:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfITQf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 12:35:26 -0400
Subject: Re: [GIT PULL] Kbuild updates for v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568997326;
        bh=Pm4x8ugJEvM4AU2+xlpk8fa6S6qjlwZ6T3tqeCojBgQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eD6UQMA9eAtlYLyAZE4s/lU0IRXG5OkFSW1gyq5lKwyU0g15vq74LH2lS6SmMmDky
         gZLBUyKDLyaFbbhUZlVyTAz3cv6jGIGiZ1yjjbSUpT0yAvGwJpUzvt40oIHTUXNjDj
         2IkVGU+zdy4EDgx5v4KGIByyouTcfsRYwpMh/Yf0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNARsoed86dY75b_HNXXkCXRAKdMUGaEWUUca4BuGaZCwcg@mail.gmail.com>
References: <CAK7LNARsoed86dY75b_HNXXkCXRAKdMUGaEWUUca4BuGaZCwcg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNARsoed86dY75b_HNXXkCXRAKdMUGaEWUUca4BuGaZCwcg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.4
X-PR-Tracked-Commit-Id: 77564a4829ef6d309331d443ea6ceb065f3dc371
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7b0827f28ab3a4fd65864451ffefa695e3255fd
Message-Id: <156899732612.17331.14622139363462044789.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Sep 2019 16:35:26 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Sep 2019 22:27:05 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7b0827f28ab3a4fd65864451ffefa695e3255fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
