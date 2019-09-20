Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FF4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA20920C01
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569006626;
	bh=uyNAdBCu5CbKsqLeXTyFFz8TOheWev6oBYpTbWZIkmw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tJ/NlRiDLpMCsTaV2qggPnimt4oqbt8bW+3cxhrL/pPVzmHHuuoaVpxahLRmgeDIa
	 Vl4i1DOT5vavC3I5bxcbMfZGBm32L+2Xby8HkEr4RYBH4iGL/yKM6J0TDzMkNGJpJs
	 Dip4HKYjPXFxaeOCm9Uw1pe3dYZavS1m56Mp2jlM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406835AbfITTKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406793AbfITTKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:10:25 -0400
Subject: Re: [GIT PULL] kgdb changes v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569006624;
        bh=uyNAdBCu5CbKsqLeXTyFFz8TOheWev6oBYpTbWZIkmw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gDjRVbEdCJqF78opSQwtFIEF9SvuRIDH9IcT1QyOKIUR3FBUjJh1g+0aKdIyK4gAR
         Lcq1SH80hniCdIqRVAhfavRpvJPV8Svsg0vVNdh/1Xxwvd0zKPTVVZSsacwzAXiBJN
         MK6bxxVByhTOkLegRkJzFXTSZwIiic65rDwRXDV8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919155946.htzamn3s3ovw7ujh@holly.lan>
References: <20190919155946.htzamn3s3ovw7ujh@holly.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919155946.htzamn3s3ovw7ujh@holly.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/
 tags/kgdb-5.4-rc1
X-PR-Tracked-Commit-Id: d8a050f5a3e8242242df6430d5980c142350e461
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3207598ab00e0fb06c8d73c9ae567afa4847e70e
Message-Id: <156900662464.23740.6086724197373122353.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Sep 2019 19:10:24 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Nadav Amit <namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 16:59:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3207598ab00e0fb06c8d73c9ae567afa4847e70e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
