Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F25C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA9F2168B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557865521;
	bh=A6fiEnYdDCi78K1DxHBJDGYP/5uOIDMwYaB1drqygN0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=hRFab1xz2qriy/oeHrBHRXUCNr7CSZDU+A0P3Eoq4Y6XoYkd77EUlOHWHYDBY1ugi
	 rxHlM0rwKUEMXRUzk3e8yY7qhHIRAysAfxRIzqHrAjj7upMEZwSLlUCpuSOqfJ+Jct
	 tarzR8Uq2K+yiA/Pap1iXkmenQwJjQth8DJp0Uk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfENUZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfENUZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:25:17 -0400
Subject: Re: [GIT PULL] kgdb changes v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557865517;
        bh=A6fiEnYdDCi78K1DxHBJDGYP/5uOIDMwYaB1drqygN0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gvnbjacm3jE6Lzqoi/TJAyJjCGnkYiu9kRz+2cu3Y+vu/vd8UWOuceGQaFM0qtFj1
         t9qqY2vf9O1boUKfD8bzbvO9O4Bc2vHQ18z2CS7f5bvZ6uY4ooeR9YSX2/wtpB7HNH
         hh2nxguV/kUCRZlcSPloHaGB72HtJW5DI+ZNDtyU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190514161434.4sdb4p5huqdlm7xp@holly.lan>
References: <20190514161434.4sdb4p5huqdlm7xp@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190514161434.4sdb4p5huqdlm7xp@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-5.2-rc1
X-PR-Tracked-Commit-Id: ca976bfb3154c7bc67c4651ecd144fdf67ccaee7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca4b40629f4edd3a961bedcd118e3ad05439ec71
Message-Id: <155786551714.4888.6798334131032790075.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 20:25:17 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Wenlin Kang <wenlin.kang@windriver.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Douglas Anderson <dianders@chromium.org>,
        Young Xiao <YangX92@hotmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 14 May 2019 17:14:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca4b40629f4edd3a961bedcd118e3ad05439ec71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
