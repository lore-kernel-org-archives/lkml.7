Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E85CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA8420657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552686353;
	bh=8bNFtcEXNQXqrbCvRQRZPhY2zARC0Fb1JHUE4GlRJ0A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=18gg+/SlPKdjOImWBa0sDl6O9inmhxxlbhmp5WRiN0Z6761Rhpiz/1yiBoZzSwblP
	 WUfvBWQKQMIaGo0fcSYrBZS081zvn8RpY/FsWrgm/yZjJHQ/i633lHbXE7bEMEnyto
	 PY+DRX5GOCXzk3SV75ZXa6IIuu5B8IDNjMJ3eeZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfCOVpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbfCOVpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:45:18 -0400
Subject: Re: [GIT PULL] sound fixes for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552686317;
        bh=8bNFtcEXNQXqrbCvRQRZPhY2zARC0Fb1JHUE4GlRJ0A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Iy+uDFuygPfK5gwYoO4aGsZxS8fe1qmkUq1MZ944NkqwcYt4dAgp4gCuMTasZIgO5
         QzbWe5xiNPf1F3Nj3gpupcYKiTzg01aKXYcgx8snSrMifCz59Dm3P9dPgzRbD6z1GF
         /2PjyyArYsN5rln+pWSegcHctGtVbzNlypwneVsg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5ho96cph6n.wl-tiwai@suse.de>
References: <s5ho96cph6n.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5ho96cph6n.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-fix-5.1-rc1
X-PR-Tracked-Commit-Id: da484d00f020af3dd7cfcc6c4b69a7f856832883
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dbb0e6c1961d823354c12bc1b66b005d1c78092
Message-Id: <155268631776.16247.11685643049036084363.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Mar 2019 21:45:17 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 11:26:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dbb0e6c1961d823354c12bc1b66b005d1c78092

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
