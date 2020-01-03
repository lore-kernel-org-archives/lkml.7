Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55BEC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B32022314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578079507;
	bh=RQg7ogAA5Z0uDirCP6aCQrHzBY1G8SgTCsaK+SsMbbc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RCqPyJe2Lomt8vgf3U7jFrstqXUc5n4+R1NLClNnPDi4Mn71a+tJ7atQKfJp0nNiC
	 dgZxGunITjFo7NPBYGo4oz8PmG0eFLTGqiiUxcYHCWPJnQ0jySCAAaIeluHp+jwNpl
	 m09ZxrupdlC6f5SriKws39OlhAfwZwfAARdXg13c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgACTZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbgACTZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:25:06 -0500
Subject: Re: [git pull] drm fixes for 5.5-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578079505;
        bh=RQg7ogAA5Z0uDirCP6aCQrHzBY1G8SgTCsaK+SsMbbc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iigZ+xXUFpDfssdL1tURaS6B9inH4xI2r/8DADwZ8IHLRT0Kg+wF7AaPq6rkesTRB
         JxjDhOIzsKkXrvKDM3KZUT+Q72Aw78xdwRWyMQS0c92d2A1hZlfFPbHjVP31/is4HY
         g09K7Wivf0UTphvOAczLVdbBbUgjoFDTGMjvRQXY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twLL0KL7zS4hwH=TgcuwVqJCpvUB276+GzkhQaa_B2vHg@mail.gmail.com>
References: <CAPM=9twLL0KL7zS4hwH=TgcuwVqJCpvUB276+GzkhQaa_B2vHg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9twLL0KL7zS4hwH=TgcuwVqJCpvUB276+GzkhQaa_B2vHg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 tags/drm-fixes-2020-01-03
X-PR-Tracked-Commit-Id: a6204fc7b83cbe3398f61cf1742b09f66f0ae220
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca78fdeb00fa656f09afee977750e85da929d259
Message-Id: <157807950558.16643.5078290428003486265.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jan 2020 19:25:05 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jan 2020 16:57:38 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-01-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca78fdeb00fa656f09afee977750e85da929d259

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
