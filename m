Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4C1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B0F2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551911113;
	bh=3WR/qmIMmu/ify6ZSnMWLGJTPERoeSM+Ii34It+pDcI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oJ8NKbP4wX3IAL7gBbvlODkuFBaU4w2RuVBrXh/MlxQosLTrXWZ0jb+in2Np3pS14
	 O69Y7e0ZriIcAEcmAluJf17MKUQKTIpVIDgOAcLFvI2pYWUq6xhWhuEC80oDoUPbXx
	 BpE07VA8SCDOB4Eb9nWDOGeyo+mYJJqpjkENIWVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfCFWZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:25:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:49202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbfCFWZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:25:11 -0500
Subject: Re: [GIT PULL] sound updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551911111;
        bh=3WR/qmIMmu/ify6ZSnMWLGJTPERoeSM+Ii34It+pDcI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KekEq/cluHoaat2/cpN1G4RMN1jROMWLB1EF14A9foPW9OLlkR5rdKMkKyUlNnojg
         z18r4mnY0vniDBr2hGR8fVV3uu8zLamqRTl735YXgIiYzxjzgGV1+95klLBZGJcwIq
         +eoGz+2SZ/yT2MDY6NcaM2OIrEUZRdn/qLNq7LLY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hk1hhhcto.wl-tiwai@suse.de>
References: <s5hk1hhhcto.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hk1hhhcto.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
 tags/sound-5.1-rc1
X-PR-Tracked-Commit-Id: a634090a0f242caa8ebc91967b118995a80eb13b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da2577fe63f865cd9dc785a42c29c0071f567a35
Message-Id: <155191111136.2142.17385065193983313283.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 22:25:11 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 02 Mar 2019 09:58:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da2577fe63f865cd9dc785a42c29c0071f567a35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
