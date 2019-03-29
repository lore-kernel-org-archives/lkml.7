Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10362C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AE8218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553897713;
	bh=ln5g1zbiheFhMDMOLfxjtZAYTxO63xtHyB+tBUMazzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=azAwCiLnciBYn18Z34zIb6YuUJ5ArqDLIV6+5zK8gTtFT5qrEXLvaPRKZkgcB/MFB
	 CZIw7pJVvQHIzzx2cKEFJYfyCADaARn0unhKZoYnEglnyPegFkRnloN5Q7Gx/cWk6n
	 ZNG5G77g0x4ll7Cl3HHOHxMYVFbxut6x8BGSpfjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfC2WPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbfC2WPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:15:12 -0400
Subject: Re: [GIT PULL] sound fixes for 5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553897711;
        bh=ln5g1zbiheFhMDMOLfxjtZAYTxO63xtHyB+tBUMazzc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W/labdgnso2o50ZVpQ6X2wOuP0gJhH0fcMHxSsJPGCMIijOmb6+mUJMRA+F07r1VZ
         0TRVLiR8ToTHYzXPv7VyWU81GOVnYf7f7ttZJZf2aZDSDJtTz7dx8POhfZmJmSLQ5J
         rki3uAARzFB1lAXr+YbTKlHoQogoUOKQwCg+vXAg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hzhpdk9ac.wl-tiwai@suse.de>
References: <s5hzhpdk9ac.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hzhpdk9ac.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.1-rc3
X-PR-Tracked-Commit-Id: e2a829b3da01b9b32c4d0291d042b8a6e2a98ca3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a4a6f0dc1eaa7b5e4a834b13596faeb0d4b7ac3
Message-Id: <155389771153.19616.11282930630671691807.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 22:15:11 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 16:08:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a4a6f0dc1eaa7b5e4a834b13596faeb0d4b7ac3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
