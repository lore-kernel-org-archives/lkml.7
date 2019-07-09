Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1551C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBCE7214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562695567;
	bh=1ImSBlk9PKc83va/CGXbBoIBeqhloWdlvQ7uMZXWMy8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lFeN6tVH7oe9IEYghAUscvRcpqRqR9iLFVc+sS5kjjtDnV+4yCJFj2Nh8B3xdd3Oa
	 bFtSuZaZyMxeYfHAMqXhbVup/z3NaakKJXDZ9rL1sQ05VDKxZ9fpbXioH2RvRxkTM3
	 TkvWXPi9xdU7rLMCSMt8Kw3vTzC0YkCJSKTPhEYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfGISGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:06:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbfGISFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:09 -0400
Subject: Re: [GIT PULL] regmap updates for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695509;
        bh=1ImSBlk9PKc83va/CGXbBoIBeqhloWdlvQ7uMZXWMy8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lFnGAUabxLKzyGxOaY9ihDPeW3OkvS+gsXo1/gSAGvaRHHRFLsL3T2j7TgQX5go3Q
         77wBg/OhzUCGSLWVVKSF3FqaHras9j6t+0IaOIcaihSPzS8HDQ/W7w+b75nLjR/k7W
         qFoPvTPdMTaAGn4Vw3vB3QNzPnQc1uuGs0VzJHBA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190708103707.GB8576@sirena.org.uk>
References: <20190708103707.GB8576@sirena.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190708103707.GB8576@sirena.org.uk>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 regmap-v5.3
X-PR-Tracked-Commit-Id: aaccf3863ce22108ae1d3bac82604eec9d8ae44c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12a5146bda2f21728bdd475f10e5785fc62c9c29
Message-Id: <156269550915.14383.16594852234153849543.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:09 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 11:37:07 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git regmap-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12a5146bda2f21728bdd475f10e5785fc62c9c29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
