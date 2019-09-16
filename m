Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD60C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2E30216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568669727;
	bh=5uO4ZK+ssQUtg4QfbAuYx34TS0uHlZ66jVoKwVypizM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=u/JcickDl8wi7x+wGAXLjW35t3aI664eTcvdzzSdF6WHaLMoKswZDb5DBlckXmoIH
	 9VeFWaCF6pRlRmtySo81KQGMpg/pZPeLlrj8y1gEN1CAdvRUtmPODXKb5aKx+KKd3Y
	 52OHMlZ2jYzZU/vGJRyw+/zWKihWdyu66+n0uyEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfIPVfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfIPVfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:35:11 -0400
Subject: Re: [GIT PULL] regmap updates for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568669711;
        bh=5uO4ZK+ssQUtg4QfbAuYx34TS0uHlZ66jVoKwVypizM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=urfbB18f+VEqmEytI4Fd62GjPy8z7sn7U/mFUEaMizI5FHwAhAQEWP7js9YvbyxVN
         BAGMwcWGMM4l+t0K8R5Hpl+M8Ezp3LbVZzvauuDtjl7F1wEKUlvaCM5dMIs2xsGAN5
         +xLC5kDWZdgjlVpKC9IU5O3giF1NY6YeIrv9PV0I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190915224314.GM4352@sirena.co.uk>
References: <20190915224314.GM4352@sirena.co.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190915224314.GM4352@sirena.co.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-v5.4
X-PR-Tracked-Commit-Id: 1bd4584626a9715634d2cb91ae2ed0364c070b01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0372fd1a70c4bc0731486851abe2048993f94a8d
Message-Id: <156866971131.13102.9119921106884277411.pr-tracker-bot@kernel.org>
Date:   Mon, 16 Sep 2019 21:35:11 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Sep 2019 23:43:14 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0372fd1a70c4bc0731486851abe2048993f94a8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
