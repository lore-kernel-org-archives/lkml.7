Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5979AC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C6021783
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569369925;
	bh=qRxEzXlEBtalKZuXKuvnGDLBT+hKNkBkjvfjq4nsnRo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=rztp5zOt4+eO6wyKuNJ1OYtbaA4txsSYBol0xPYSeWrj7LBrNFSaj27Hy8wUj9jkf
	 ANfO2wC+fnP8WzJ3rsDuhNGd4tGaZ/a0XRtYRlnuTN7YSpr7EbIP+zxUyedsOP3WGU
	 4PAk266qYnR8Htf+s0W2yH0OtvT88eTLfxfxzRVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390091AbfIYAFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 20:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfIYAFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:05:23 -0400
Subject: Re: [GIT PULL] sound fixes for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569369923;
        bh=qRxEzXlEBtalKZuXKuvnGDLBT+hKNkBkjvfjq4nsnRo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EbMKXNPZA+CjDJmT8Dj/egNa+iYVdGKUkjQheFWHC6DadqL40Zx07FwzoRBpxdyiH
         rTxmDrehXv3ebU8unAAime9IgxWH8iVUD3ei321fKmAsxpjNQUDtM/kxKvsvBEYPyW
         Po0VwjUY4GpVg7savctZFO0mGaz7/1Rni5PkmKMU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hblv9kid0.wl-tiwai@suse.de>
References: <s5hblv9kid0.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hblv9kid0.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.4-rc1
X-PR-Tracked-Commit-Id: f41f900568d9ffd896cc941db7021eb14bd55910
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cf7487c5de713b706ca2e1f66ec5f9b27fe265a
Message-Id: <156936992314.955.13581615350699122660.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Sep 2019 00:05:23 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 14:07:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cf7487c5de713b706ca2e1f66ec5f9b27fe265a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
