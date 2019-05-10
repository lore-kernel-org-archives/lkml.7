Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F81C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2632182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 17:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557509722;
	bh=Nt+CxcwvlJZTJMvBBI6S4qoFF8Qq5Gw7uU01tcOHhYc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hdJ/LGbcWFY+BZSprY36lfVWGFfXX2aHVx1MEgACFMYbIbLjrM+1zK6IxsERL8twd
	 zTYvV2r1F5wRwqNKJGsN4EQeyF2JbV8MthxEcUMqn5UYeZwb86BVcCRNBVCjwUy3nE
	 7pDz/Hd1gkiO30fyWmmdRwcZm5xHj0Ttt0KN6wzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfEJRfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 13:35:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfEJRfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 13:35:20 -0400
Subject: Re: [GIT PULL] fbdev changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557509720;
        bh=Nt+CxcwvlJZTJMvBBI6S4qoFF8Qq5Gw7uU01tcOHhYc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bJARNUjYNF3fR2TSd4ds4M1sHWGTNu01rqgPdVRlr27h+NWqPjWTDoDF4GHOO0EP3
         hpx/4/MUiiNDGBQOb/i07BRszoKDIIh6WFPdcnTukJElsM374tIg3giMf0MoIxzF9Q
         hafUnUoCA0tEXqw1TbsWGoQ+tQafM6Hl4QPYFHzs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <32ceb3b0-0bce-a585-8843-36e851b2a1aa@samsung.com>
References: <CGME20190510165025eucas1p1158b6d87dde378cd9986a6e89125acf1@eucas1p1.samsung.com>
 <32ceb3b0-0bce-a585-8843-36e851b2a1aa@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <32ceb3b0-0bce-a585-8843-36e851b2a1aa@samsung.com>
X-PR-Tracked-Remote: https://github.com/bzolnier/linux.git tags/fbdev-v5.2
X-PR-Tracked-Commit-Id: d4a5611743a6f5d126f8cbfdbf29e12fd8d1b73f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cccd559e98c05b669bdc37b01802f920cff1d6dd
Message-Id: <155750972027.27249.4763452749485963649.pr-tracker-bot@kernel.org>
Date:   Fri, 10 May 2019 17:35:20 +0000
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 May 2019 18:50:23 +0200:

> https://github.com/bzolnier/linux.git tags/fbdev-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cccd559e98c05b669bdc37b01802f920cff1d6dd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
