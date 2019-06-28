Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A71FC5B576
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7153A2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 00:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561683313;
	bh=hZRNN/e3IlRR97IKDnuhzU3r8NY2c8+yi1pnLBOwPSo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZUFHyJSFgf6SRmHj9zuGV8en9EwpimWm67MiLmMTX0evabpWI5Wh7PXwNxCriJlfg
	 mnkrolnDpahGg3mNVNdCX+08h6jmgXFny+TmqVAh6UQ2XWlPVzmbeWdAFO8kGMoO9C
	 0YyQUEOUJH2RSNMeyCTbV1a3eE8Wq+OTFcT2tuXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfF1AzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 20:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbfF1AzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 20:55:04 -0400
Subject: Re: [GIT PULL] fixes for v5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561683303;
        bh=hZRNN/e3IlRR97IKDnuhzU3r8NY2c8+yi1pnLBOwPSo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E6fq+2vXFGFwyB2t9uOLGrR1Touu57GWuea0rsFXEoT1JPQOVt3Y+AA37jhf4UCZb
         AoWUpTuoz7XuEt2nwSiZSFrtOFkEVym/a4vTyhNy/NUm2aYCEJvpnJkxR9FhNUmigx
         QyZzGhI9nh1qsaZUng0kACGi97ytvOawoXqhaCbA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190626140733.21538-1-christian@brauner.io>
References: <20190626140733.21538-1-christian@brauner.io>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190626140733.21538-1-christian@brauner.io>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-20190626
X-PR-Tracked-Commit-Id: bee19cd8f241ab3cd1bf79e03884e5371f9ef514
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fd2fe494b17bf2dec37b610d23a43a72b16923a
Message-Id: <156168330344.8716.6668536902844524251.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:55:03 +0000
To:     Christian Brauner <christian@brauner.io>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ldv@altlinux.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 26 Jun 2019 16:07:33 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190626

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fd2fe494b17bf2dec37b610d23a43a72b16923a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
