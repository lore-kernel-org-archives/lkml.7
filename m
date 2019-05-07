Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937B2205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557241807;
	bh=Cp33axtYLXQV79kfBoQsf2nMkq84TAp1qqrLbuAeTJw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=B+wCqrBBwqKDijm1Q9dqegGKUQGvjhoQtBROhYrsSQKgaee9cZ9Xgpy29NsG4/Nb5
	 d8lYBYW8Ja8XL89UW++GwPmjY6wKMOwMEXovfy5OyNciLDgdQrPCyJGmHy/UUMW6xu
	 Q2mebeRFoZX0rEUqL7bqtfz5Y2g8eLtNZNiTRhN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfEGPKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbfEGPKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:10:04 -0400
Subject: Re: [GIT PULL] regulator updates for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557241804;
        bh=Cp33axtYLXQV79kfBoQsf2nMkq84TAp1qqrLbuAeTJw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YhcXBgm72pg5hdOI32cIueFbe+GMqG+aND4BvYoDt2PnyPaUlw0tiN6lrbycgwkma
         r6Yv0hMOkCrEPnYSkM5ufCoWO+WwtLAAf0ZXxj/X4bt5l+gxoZxMmLg2y0u67UQ3pG
         +NUsl3Og/yPY6a4vqimQ7G9/LyAXbiNdJTeGYIDg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506142352.GT14916@sirena.org.uk>
References: <20190506142352.GT14916@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506142352.GT14916@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 tags/regulator-v5.2
X-PR-Tracked-Commit-Id: e2a23affe6a6a15111ae56edd7e4f3c9673ef201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61be53f9ef37de2677cecb8f87b207e6f061e185
Message-Id: <155724180399.32029.18187349334167258076.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 15:10:03 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 23:23:52 +0900:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61be53f9ef37de2677cecb8f87b207e6f061e185

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
