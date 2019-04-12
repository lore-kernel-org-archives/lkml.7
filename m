Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CFCC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C7B2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083020;
	bh=+QyPNb3sXlDRAS+1V/GZSp2RnqQPJTkxHR3Fzg5VKYE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=eX31F73F62BzfU4VZXPtkbfuD/kxfgWWmEVQM+3361kATIcyV3AL8iyRmUOOY/uIu
	 Xr1FfZW4fNr+sRwLdgxxhBpEKe1+m2SLEe3qf0xowL1KIXBe2SSj4IVjRXY3DuE5Ej
	 0L04C0Ej7o2t1C8ziWzZ0fIz0mSQ22upW5PuEmJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfDLPaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbfDLPaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:30:06 -0400
Subject: Re: [GIT PULL] sound fixes for 5.1-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555083006;
        bh=+QyPNb3sXlDRAS+1V/GZSp2RnqQPJTkxHR3Fzg5VKYE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A4vbS5vNNtgqlMpjxq/hPEvcY8dJVvq221S2aGuZGhaMGGBixvjQGUPVO5CghQZsz
         8eUX62a+20wkhCZJOHrcajn6563onyxBmFCmxHBXErwXhuu96udnhNsxB6o4tpSCUM
         5SSYsiZ5JxAfeK+tPyCYLLwxuaqAsUqR2p5Jsrrc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hr2a7pqv1.wl-tiwai@suse.de>
References: <s5hr2a7pqv1.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hr2a7pqv1.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.1-rc5
X-PR-Tracked-Commit-Id: 9b0dcd0e5a27958b57e3e390f63c098d63a055da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 372686e60c84b01efefd4fed3ec00123d9effd0c
Message-Id: <155508300635.31973.14710101855092617856.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Apr 2019 15:30:06 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Apr 2019 10:30:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/372686e60c84b01efefd4fed3ec00123d9effd0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
