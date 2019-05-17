Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2195AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82862133D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558128323;
	bh=iTJVr0+Z92ghTJkARF3jX5Reqp8kneaC5xaYepWzVfM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xnFS/RJ37qbrbzUjnVTu4Ds1CHxX2/swC54EL6hKTrZZogZdNMFmizF0qTls2tktG
	 /2m+bXPO0IcB88bkcvWCJTePlbZfSDM2VPubmDWGP4PP27nCZgEjbYQ2EupCExfUOK
	 2nXUVJHlmzOOsf6rP6+0wKyZOVX/+gGfOIbvBBkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfEQVZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727664AbfEQVZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:25:21 -0400
Subject: Re: [GIT PULL] sound fixes for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558128321;
        bh=iTJVr0+Z92ghTJkARF3jX5Reqp8kneaC5xaYepWzVfM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YntguTNlnXnBreYZou7TCviyU63i+dmEii3lhWPruJl4+s+7AaFW19WWoah1eaTDH
         2fd0X3uAf8pC4qlAjbd9RJo6pJCem8Mqj2cfEqqiwjj3+smnGVCX0CjXSeOVWC+CKQ
         nmdMpUi1bIZFwiuDLlPCqO1vn+9rnLoYrboN1sEU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hmujlfdmb.wl-tiwai@suse.de>
References: <s5hmujlfdmb.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hmujlfdmb.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.2-rc1
X-PR-Tracked-Commit-Id: 56df90b631fc027fe28b70d41352d820797239bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72cf0b07418a9c8349aa9137194b1ccba6e54a9d
Message-Id: <155812832130.2706.15644825041128394742.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 21:25:21 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 May 2019 14:51:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72cf0b07418a9c8349aa9137194b1ccba6e54a9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
