Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F9C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A7A21850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563468624;
	bh=kYwUc7H92PsudVECq4mHUyluC1VcRyqDzW3fRYa/hvY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EOWd9QLqfY2mJNF6tCmoQOubMvZFoVTQ+VqsTMasnzFhaoKTN6h6/AUcG0ePb2TAr
	 0V0muQUVX3q5BEUskIC2ZO9G/1PalrbCx/UT54J78XanCd1VzJbo5UdteqTu58y5cj
	 C7yHXtjZYTcuMJGxs8x3yjXSTextQ6d4MCM3pMgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390856AbfGRQuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfGRQuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:50:17 -0400
Subject: Re: [GIT PULL] More power management updates for v5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563468616;
        bh=kYwUc7H92PsudVECq4mHUyluC1VcRyqDzW3fRYa/hvY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ylus85Fc0o04qFLZx9LmFWXZlBlUtCVItLcKUyDytG5n/h3wGlOB5I+CliqmLd50b
         jIJJ4BmM9X/ixCzIxIzo+x63wGjPE730b9vluxW3od+sKBNVwV/lBBY8jopiKJ9xlL
         9fAEkUtbW2RQCEnvZLBAepORKDhFroEgThSOv8zM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0irbFa5E=UZ+1XiiuoXC9zD0qc7vx3NtTCmB88h3_U4hw@mail.gmail.com>
References: <CAJZ5v0irbFa5E=UZ+1XiiuoXC9zD0qc7vx3NtTCmB88h3_U4hw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0irbFa5E=UZ+1XiiuoXC9zD0qc7vx3NtTCmB88h3_U4hw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.3-rc1-2
X-PR-Tracked-Commit-Id: 918e162e6a71e924a343b41f71789ad14e1e3229
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0411ec8ca6b98061023873e334323ef102100cc
Message-Id: <156346861620.19804.11274811882223588044.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 16:50:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 11:06:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.3-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0411ec8ca6b98061023873e334323ef102100cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
