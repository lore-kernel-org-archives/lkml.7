Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA752C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EAC2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563306030;
	bh=MpAJwyHWGPoouvRLRcLMg7pbu2uGboHoGtQFcH1xfp8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=cT7Qrv/LJU6sCgoXP3Bv+V14mXYXYT13KxLJGg6mRYyMDBDAAb1TDd+NSm7oclGYN
	 anNHJQaBpTyBE0CbsR6jVeR0xJjFiPf42EsVR6iW2U1CsWRJb0iF2JcwJ2WZ8PyKkG
	 nNGKVvjf+DhjyeEW7kuCC/krrpE9iF0v6PkZAG/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbfGPTk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388665AbfGPTkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:40:20 -0400
Subject: Re: [PULL 0/7] xtensa updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563306019;
        bh=MpAJwyHWGPoouvRLRcLMg7pbu2uGboHoGtQFcH1xfp8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UF1tzOctqUK7EOhSu0HpQqjENPoojIezdo77QLNSXPHId7yuaY0peSWR25cF2x6AG
         NKhT54q0ITVqjFQDoGCULkSDvoFFvb3pcxwkW1LpnzwT3TrR5WTk3X9cURE68OwyhB
         PLvYjPnxpMMqNL+YSzBuB1JDB6I7wvdndHfdtmNQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190715174427.6144-1-jcmvbkbc@gmail.com>
References: <20190715174427.6144-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190715174427.6144-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git
 tags/xtensa-20190715
X-PR-Tracked-Commit-Id: 775f1f7eacede583ec25ed56e58c4483f2b29265
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e859477a1db52a0435d06a55fdb54f62d69c292
Message-Id: <156330601962.24987.9049907305742976536.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 19:40:19 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 10:44:27 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20190715

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e859477a1db52a0435d06a55fdb54f62d69c292

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
