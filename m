Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAE8C33C99
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 03:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64FA2465B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 03:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578195307;
	bh=8buG9x7VmsXIQ+mAK/WzJv+HcLtCcwwzexe8iZQY32A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mgolPHAwcHYOURU3LYd4Qaih4ZMv5Kw32tfZn+TtCL5TIfKMUWzgcb5ynOd4OzoSq
	 fsL04KuQYCMUfo4uFQZhZvNCxMGYwsS/rbf1Qs5oROcd21vgPscVqDiiwyH9/xuf8t
	 GeskGnIvWVaqSmAv2Pw1FQwET+PxI1Yt8gVUtIsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgAEDfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 22:35:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgAEDfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 22:35:06 -0500
Subject: Re: [GIT PULL] apparmor bug fixes for v5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578195305;
        bh=8buG9x7VmsXIQ+mAK/WzJv+HcLtCcwwzexe8iZQY32A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GZh4IXtNsMxJPqt/tKDGV/S1Zj8i/CzIZsDBiadQQRl19Lox0VUin7hyHbgdZV2rF
         e3PQPTToE9mv+z+lq4dTwBu6YQXDNu9y4+afzoMIrTRFr2wLrnThLMn77pYbUFnnON
         r/QIICqrmxk+aLVX9+G7l/FDKB9qOINa7XZiPBTc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cbec7335-39b8-6b7d-402b-a6dd467b492b@canonical.com>
References: <cbec7335-39b8-6b7d-402b-a6dd467b492b@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cbec7335-39b8-6b7d-402b-a6dd467b492b@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
 tags/apparmor-pr-2020-01-04
X-PR-Tracked-Commit-Id: 8c62ed27a12c00e3db1c9f04bc0f272bdbb06734
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a125bcda2d0aee1d98b51c167aca60fb312572aa
Message-Id: <157819530587.6178.12338966789047644717.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jan 2020 03:35:05 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Jan 2020 17:36:48 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2020-01-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a125bcda2d0aee1d98b51c167aca60fb312572aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
