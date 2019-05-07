Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CC8C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E1A20B7C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557241805;
	bh=n5MrrmbjVQWi8Ls4d629OYCNqbeVI4PgklQ7uYwJ544=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Usssz6vhyCJPCv2sGvXPs9ncWpqu2r9jaot+j8bNtroCBN4YzWU4a5PBUbzgtjgVx
	 S0ZTGcoXuqT5PqBfT/dsDKH6t2U03oU9zPZKmsEZWcXyVUvIFrzTn5EGFI5YnzaUKp
	 FuMQ77Jb9H1z+YqUohltBIiwnm4yQX5Bde2/f+t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEGPKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfEGPKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:10:04 -0400
Subject: Re: [GIT PULL] regmap updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557241803;
        bh=n5MrrmbjVQWi8Ls4d629OYCNqbeVI4PgklQ7uYwJ544=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WRb5VnBWrAqDvIaJXwfITj1X2yvFgy3c8Tw3Ca9n4PyPMkMY73TM+HCWpW3gI/zKO
         nl0gIQAt2E2+nci/+8qP1r0yDwlMWjV/PNXxHC89M2/Yxlzy4o2AC+YrfxewL2qqMl
         1Ss9UCNlXGhhd8tf06Ub5Nuceanet6df9XCwBDRE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506141725.GS14916@sirena.org.uk>
References: <20190506141725.GS14916@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506141725.GS14916@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 tags/regmap-v5.2
X-PR-Tracked-Commit-Id: 615c4d9a50e25645646c3bafa658aedc22ab7ca9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 962d5ecca101e65175a8cdb1b91da8e1b8434d96
Message-Id: <155724180343.32029.829249019824070360.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 15:10:03 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 23:17:25 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/962d5ecca101e65175a8cdb1b91da8e1b8434d96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
