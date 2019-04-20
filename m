Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F44EC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 20:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ABD2087B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555790711;
	bh=PA42XqjmnPoUAU1orQbW5A6Vo6e5c2n+x+hIszaGtI8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PEHh727SLmpEEYZZ6FDuIRfJowqPV3+Ni12fRsD6XHD9hXu5G3NWESmyRzuaHmMDI
	 IzqYeOJojA0VxUXLuC1sZ3Cfp1AEHwscsRTmdHCzNdBTyoikPLYBhoRLPjM+X/Kxw8
	 a+IGBIzgy40vTaPy9+0sIVkc6QpJhSDbG3oMM/IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfDTUFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 16:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfDTUFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 16:05:05 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555790705;
        bh=PA42XqjmnPoUAU1orQbW5A6Vo6e5c2n+x+hIszaGtI8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vqNAhae5w4FLeoYYGPXnEv7/VbO5NyXnOjWRLHwr8xAyuFBy3A3zob97Io+yVuUyJ
         f9vuR2WUsiYkuPQAqP6WKX9lSYhXKLlO0QQFx5uRi4mr81XwFUxfw5Aa51pMdhu4ze
         AM9Ur8VcQuKS6bqpiuQ1ZSs6ywgiBboXgXuF5gFY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1555786552.2830.3.camel@HansenPartnership.com>
References: <1555786552.2830.3.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1555786552.2830.3.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 144ec97493af34efdb77c5aba146e9c7de8d0a06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a06bc2f241f2e6c0c27b48e4c383d6cddd4f6464
Message-Id: <155579070518.31475.10085521552613337335.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 20:05:05 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Apr 2019 19:55:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a06bc2f241f2e6c0c27b48e4c383d6cddd4f6464

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
