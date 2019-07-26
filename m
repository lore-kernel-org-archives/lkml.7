Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEC7C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11374218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564165541;
	bh=F6p1/heSac+7vu16SkIv9/ELvNLQDsloVhSvb810nkk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Kf6GIZWLbSnQ1+KzBNvPt99jvsvmtqH9IR10WSl4+2rCaB7YNaQSkLMzfCAQhL82I
	 kMXmO0t58Nhbnb6FWjb32xUe494uIShtOKJe8OdVLvyOAiDavfzRmpwegn6NYPpUN2
	 APxlSkAEnTYo8X1sAuKGLiPgG5KNn7PCT+8ZFM0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfGZSZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:25:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387533AbfGZSZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:25 -0400
Subject: Re: [GIT PULL] sound fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165524;
        bh=F6p1/heSac+7vu16SkIv9/ELvNLQDsloVhSvb810nkk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c3cCybC7N9lOMRrordZnj5Ioy823B7fZ51lBYW7MduiXdSLje8OaKfSt1oy98jf8i
         oLU/GjZXLeAPRQXGSXtwIPwLJZLKB+B8aPDYcEqegxY8MJsbPx+uButU95PTC6uIRt
         yVG/FulmspvlI3sthO/hQI5v7T1zmpNFVzfIgbvs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hd0hxynmh.wl-tiwai@suse.de>
References: <s5hd0hxynmh.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hd0hxynmh.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.3-rc2
X-PR-Tracked-Commit-Id: 3f8809499bf02ef7874254c5e23fc764a47a21a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 750c930b085ba56cfac3649e8e0dff72a8c5f8a5
Message-Id: <156416552431.19332.4448523357223769224.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:24 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 14:41:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/750c930b085ba56cfac3649e8e0dff72a8c5f8a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
