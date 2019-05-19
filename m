Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1BFC072AD
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 19:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF15206BF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558293336;
	bh=yudOjcFWjiOEa8j0mhUxsek7D3/8fLSgOcfaQwRphh4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=czX6cUCTRjlF83BmA9vBsKhL2Ya94+yskKBKLlKMgCpqpxYIMpiSlErAgZMZ3dQ51
	 ovgmJwUcrWl8v9Nu3my7mMayo//ItTyLW25BIeOguI6lIBzYxGxWkaSBg6Z2my3Jcb
	 arSLmiFMmLJTH8p8wAobT3m7o3mq0Ap7CjJ4Mo+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfESTP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 15:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfESTPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 15:15:22 -0400
Subject: Re: [GIT PULL] more Kbuild updates for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558293322;
        bh=yudOjcFWjiOEa8j0mhUxsek7D3/8fLSgOcfaQwRphh4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=poruBRk8VKbkQKbFViYrYD9mDeiNMAR5gNBNEAbj22jIhdQ0n8dqVK8yRMDLC8Le7
         0Gze1PLZAtCfQozQEk/OxNLnJ9VZJwIUQZ2ORkoIeZJqgRPtTjpK4Lgk20SNp1NoRd
         ZvJB3TTxKv7Iy1AtzbkwW1wnjnzYIMCTlNEA+xFM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATmYHZoF5WYVY6mWet76Teb5YMyVDUuEGJRJdRiqETROQ@mail.gmail.com>
References: <CAK7LNATmYHZoF5WYVY6mWet76Teb5YMyVDUuEGJRJdRiqETROQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATmYHZoF5WYVY6mWet76Teb5YMyVDUuEGJRJdRiqETROQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
 tags/kbuild-v5.2-2
X-PR-Tracked-Commit-Id: fc2694ec1ab7c805505bef2752aca56977a22abd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff8583d6e4e33fe3856a609095c683d5dbe39120
Message-Id: <155829332225.24875.7298412529057695345.pr-tracker-bot@kernel.org>
Date:   Sun, 19 May 2019 19:15:22 +0000
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 May 2019 10:06:52 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v5.2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff8583d6e4e33fe3856a609095c683d5dbe39120

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
