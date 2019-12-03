Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBF3C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222CC20705
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575336621;
	bh=t0492yjQtzcuOnpNEzTssNPJaZmkH18aG64RsUtFj+M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=IocSZ8Qzr/sDA/8FTBbOAn6tdxN5isYWa/HE1uVI40NKqWgQbabvrtoEzy+J2KQIV
	 3qJaoXLxL2GNoNMvZyJxFdB4fcWLe2hL+eDimLHyPPG/pC0Yc5jioIFPqEe/1sZtAV
	 TE1A1IyBg+2SuUaHu+mZI9ApkP/tYeaK+HWpGKs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfLCBaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbfLCBaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:30:18 -0500
Subject: Re: [GIT PULL] UBI/UBIFS/JFFS2 changes for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575336618;
        bh=t0492yjQtzcuOnpNEzTssNPJaZmkH18aG64RsUtFj+M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hyD3chR9f+ve08UXF5blHs5WYigCEmCMA6mNFKa8sQyTm6tg/lT7EKhxk/7eLVBEi
         uMpNN5zkJDZpbf1BLWo/liWZfgr62cb/w9KexVJlmtfr2xbloAgv/YqWczP9pbQ8kB
         kCyVD4Z0g/5OuGxvzkSYp3cX309gZKJ7VpcwrRlk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1044415561.103245.1575231527451.JavaMail.zimbra@nod.at>
References: <1044415561.103245.1575231527451.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1044415561.103245.1575231527451.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git
 tags/upstream-5.5-rc1
X-PR-Tracked-Commit-Id: 6e78c01fde9023e0701f3af880c1fd9de6e4e8e3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e3a251e366e1a007c7ce7b2809b67f4dece6b17c
Message-Id: <157533661816.4888.1012998876032231528.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 01:30:18 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Dec 2019 21:18:47 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e3a251e366e1a007c7ce7b2809b67f4dece6b17c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
