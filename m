Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE23C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F7B229F3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564177224;
	bh=VBlbRVTdDM9X5wUuccB0nWAXEEoTBnPckG68xFCQ+lg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=U1DWVt8xoJVVVJ8fIT36oLN164tFPU2dZpa9pDGLyoTbapqMmawWhzVrN5lmSNsZ4
	 cvm8JQIXglNps+GAGhN4A0NbW4sourXmNAdYSRndOFNDkdAqBooGy1tBWBDwF3mbZw
	 iYHMm3LiYs8Le7HghMdB6C9L85AFNeblu3BhHDGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfGZVkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbfGZVkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:40:20 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564177220;
        bh=VBlbRVTdDM9X5wUuccB0nWAXEEoTBnPckG68xFCQ+lg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bc+BcKiJiz1mi/tpO366FUzu4CCbWdIMYS0MeE+TUxtAQp14i+maqRaOnxhi4AcD5
         09YSHLdNlW45mHfCoiXtfBqsbwI590TRGQjPaXZohrWSWz+ng0WOke5O5cLKUPsFKg
         dwICbUSLzCpEIxu6GPNDENcHfOIZNiekcCvFLo0E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1564171685.9950.14.camel@HansenPartnership.com>
References: <1564171685.9950.14.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1564171685.9950.14.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 20122994e38aef0ae50555884d287adde6641c94
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a689838913670765f7754bb1ba749acac9541626
Message-Id: <156417722011.826.16480120807211637212.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 21:40:20 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 13:08:05 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a689838913670765f7754bb1ba749acac9541626

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
