Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC835C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D982073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 17:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573839327;
	bh=uuBj0hrrRydbd5DM5jCvpp2BUh+Tc5ewx2w5lTDSYOI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=VJyZGVRuLqcwu+hcC3nyq+EDFaYUrmtCf3w1zbFeHNOQD07/DdTNWHWkMc3LP+yxu
	 hpeJpZLY4LFrzPdaKm5boFm9mL+QYCZRYewcGqRegdc66RYpRbTHLf+j3ptfDjvCm+
	 DKNZSaqteVhKbnzbxeh4Sp597/igc++yALrOXD5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfKORf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 12:35:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfKORfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 12:35:08 -0500
Subject: Re: [GIT PULL] sound fixes for 5.4-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573839308;
        bh=uuBj0hrrRydbd5DM5jCvpp2BUh+Tc5ewx2w5lTDSYOI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VaWZbCo2zxlvqBSVB7KWcxGINc693Hj7gfJ39E7YvrxMM9Xm4TTjLVlheDd5oRCLT
         QxD9CbLAfrNJyEmh8ThXcgqYBcwBGNREnorqart/02ufHJp8avBymuR90GRrCnSUsg
         OKIgxOI7cmt2QxdO+9v0Sdvmc1Z6SLDWO9hFHIk0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hmucxjtsk.wl-tiwai@suse.de>
References: <s5hmucxjtsk.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hmucxjtsk.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.4-rc8
X-PR-Tracked-Commit-Id: 976a68f06b2ea49e2ab67a5f84919a8b105db8be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11ac7cc88b48130106c42c0dcaf8ba74fc9e7978
Message-Id: <157383930809.31249.5290264274947599425.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Nov 2019 17:35:08 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Nov 2019 11:52:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.4-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11ac7cc88b48130106c42c0dcaf8ba74fc9e7978

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
