Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E260AC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BA421855
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 23:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555717206;
	bh=8MHeUMfNhaamVhwKpkE86pp6Nrmo2Y2tVEannri4s9k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=NPm04reREowMmkgvKY+bURcKq1wTPqWQ//Ph8iWp0D33uJrbfcYJzlJV+8Ww3mWca
	 nrcnvPlhLeCkM38nxyT5oQbrpUJq60u3b3rL++uFkLrjA+UO/uJbcwmLxCFnp7xjLv
	 y4DmvixF0pdl4niRdJWtXJ3861+Zba3utfinnPjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfDSXkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 19:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfDSXkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 19:40:05 -0400
Subject: Re: [GIT PULL] percpu changes for v5.1-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555717204;
        bh=8MHeUMfNhaamVhwKpkE86pp6Nrmo2Y2tVEannri4s9k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pHcGh1hFAdiWeYS/E17TBhuz1tnj4kFCgfc7duMasn+QdYwA18VjfjjychaDsiPGe
         c9/a28qt5jADFx/a25zLej9rWxPCz5STctg+jtqHEbsORglYh9/TXf3SPwfDIhpY+I
         Lc99fJ+NeVLQGeICzlnlPs+JpTsDU8WlykZv/eaY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190419212918.GA12787@dennisz-mbp.dhcp.thefacebook.com>
References: <20190419212918.GA12787@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190419212918.GA12787@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.1-fixes
X-PR-Tracked-Commit-Id: 00206a69ee32f03e6f40837684dcbe475ea02266
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c3f49ae1306c05e91211c06feddfd0a4a57fabd
Message-Id: <155571720448.18635.3393828777776980334.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Apr 2019 23:40:04 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Apr 2019 17:29:18 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c3f49ae1306c05e91211c06feddfd0a4a57fabd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
