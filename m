Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A5C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45DD2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575155106;
	bh=b12ZFmGiWVFFBDg0ZRtOhVaglcch9/vJdXIY6PfCqrw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mxAgeuGvMOOz76xVswp/cuiJo4wek3CgoWq7TPT/7jmshXQy9t84nn4z2+GbILNMM
	 yMCLiJdxBh1H3pt5WqF5pvWDUk9Yuu9LKt9HHAods8PFfv7rsmxIhlVMA50BWOC3Ib
	 jfmJ6sQx/xSVwoWdM+HJx640Ecw7BNEEAvBlyatw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfK3XFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 18:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfK3XFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 18:05:04 -0500
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575155104;
        bh=b12ZFmGiWVFFBDg0ZRtOhVaglcch9/vJdXIY6PfCqrw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qsm1O/682UDUS93DlfrHOnuisdui5KVwQr4xn4MF0EhiVt05yAz2GuzT3K+sFZIF1
         avN7rlI5UUofb58sSaGR8whb1G30GwHu03WLzzcN9JE5Ljk30NSDkKcdtmv/MKQQ8D
         SFDuaeC8auojERgI3knWmyoxzODCoOwvbdlotVfU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191130220520.GA12883@ls3530.fritz.box>
References: <20191130220520.GA12883@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191130220520.GA12883@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.5-1
X-PR-Tracked-Commit-Id: e9c837c6ab07127b02357efcfe1a23d030db1aca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 738d5fabff864a6b4a8b67f589a8f28f6cca808f
Message-Id: <157515510436.27985.3092447520093659366.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 23:05:04 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Nov 2019 23:05:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.5-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/738d5fabff864a6b4a8b67f589a8f28f6cca808f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
