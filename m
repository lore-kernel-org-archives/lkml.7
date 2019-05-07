Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7625EC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4703B206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557249605;
	bh=gWwe0zFb3P+pIl4cNVlAWOBbo7Fxyfh4BDTraeJSBXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l/E2cc23FlewCMYYiA0ePHQgVBrQu+y6boWL3hB1AAoLR+HcI+/jTOO6+sxfIHNjz
	 g7Vt1bPg8L3XRzLfYk1e8zgrIodVL8k4gMaMU44HNSgx+OC2SEdpKJdW1zjLOHywet
	 AY0jkuS8RpMRXA1l7BtMXWCPo7N+2FEdBZOQMB9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfEGRUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfEGRUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:20:04 -0400
Subject: Re: [GIT PULL] i3c: Changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557249603;
        bh=gWwe0zFb3P+pIl4cNVlAWOBbo7Fxyfh4BDTraeJSBXs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Z63emYpAUv+3pQ2Gja0JVsX9cPFnGv6lEBfWlYmiMthk1LRhNBdj02vZjF4Ezk1bm
         U6mcNWU6yNimyIwvqwGutzEtb4xW++8QOlj9zJCO+uP47sK8M3/U07/w8VObz2CH2M
         xGuY8SzXdcp5FhtIq0qiE3SLNDfyXAEpQtTFS9i8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506085835.61688fd2@collabora.com>
References: <20190506085835.61688fd2@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506085835.61688fd2@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.2
X-PR-Tracked-Commit-Id: 476c7e1d34f2a03b1aa5a924c50703053fe5f77c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80104bb06b17497b570b11a187131dca7d445b40
Message-Id: <155724960355.23705.11213415373851030230.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 17:20:03 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 08:58:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80104bb06b17497b570b11a187131dca7d445b40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
