Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41170C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104FC21738
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565031613;
	bh=huMwvSJffSri2HM4wfW/0xKRtkcO2R5wLi0dokv2kmo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=dZ8CS9iogFWHilO8qhUCxIG6spc9ExS/wYpmuwUG4AvnwT8crWFDI8oFoOqySS6Zz
	 K8cJvjQOVQypmV0n26y+GLjL07zlQ33iLmUSOk0DEtBlRR4BbBd4hrQE3vxKKXiDyJ
	 OiMA3nuGX/1B1IPCkGqJh8FXNI+nubzAWNyfjPSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfHETAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:00:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbfHETAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:00:11 -0400
Subject: Re: [GIT PULL] regulator fixes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565031611;
        bh=huMwvSJffSri2HM4wfW/0xKRtkcO2R5wLi0dokv2kmo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wqUcl/FpdEozKEWbMfI5PttNsekeK8pEnnpy3su52h8+X++sQ4Nw1raWQ26WL6uFd
         Hd9ylqQlfn7cD1FBYcCZ9JKPdWgDsXN1qhM1FhDePAL//BdWu8N1v1ssKYcHGT6B2c
         7GhA4hOq9v/2tZ/L+V4NBiz4GGjQnQyLLj9fRexQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190805143431.GH6432@sirena.org.uk>
References: <20190805143431.GH6432@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190805143431.GH6432@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-fix-v5.3-rc3
X-PR-Tracked-Commit-Id: 811ba489fa524ec634933cdf83aaf6c007a4c004
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df9edcba0b1146da5e4a2d1921bbc10c1a2fb55d
Message-Id: <156503161095.31890.7623032134838084743.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Aug 2019 19:00:10 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Aug 2019 15:34:31 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df9edcba0b1146da5e4a2d1921bbc10c1a2fb55d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
