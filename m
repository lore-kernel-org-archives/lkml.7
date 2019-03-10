Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E99EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE22D206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 22:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552257053;
	bh=iXuPbvAQq2xCy8L2B7QZWSAn5QB1nxv0ZFaVVTmzn1k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nQJNg02Hy6tgB2MojLtpMw2xvPbMUmY28GX1mr/G43yjw9rpQGwbA1vdMQCzFFlDW
	 DAzrSIq49cfthP7GY16b/YkQFZnFC0ub8C1wsZawVUaXueqHjCjEGXswozzlOjOVSf
	 0/7O2vNukSAb9QH5OkNaDme8edudiYMldd8WOi7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfCJWau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 18:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfCJWaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 18:30:20 -0400
Subject: Re: [GIT pull] locking fixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552257020;
        bh=iXuPbvAQq2xCy8L2B7QZWSAn5QB1nxv0ZFaVVTmzn1k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cn3vGU5+B9L8GxzNB1itUzLEASiJa5bromnhEeP1N/uFYYYppcWoTilCAxBZGy1Ro
         e8pvSf97CBFRTwbKbjRuZtj3XhbBdOwzhv6uV3ijovxWVmLWahAUcdRx9O10yV/xym
         H2w1/LTJ5ByU1f6j046oHiNAEyo6xOHQx49Td8h4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155221755096.13878.17210891228269439774.tglx@nanos.tec.linutronix.de>
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755096.13878.17210891228269439774.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155221755096.13878.17210891228269439774.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: 69a106c00e8554a7e6b3f4bb2967332670f89337
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e55f87c0e3b3db11f52834222f881094eb97205
Message-Id: <155225702010.14748.15575193413801960751.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Mar 2019 22:30:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Mar 2019 12:33:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e55f87c0e3b3db11f52834222f881094eb97205

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
