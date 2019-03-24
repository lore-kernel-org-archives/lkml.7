Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2BEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA492133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553452823;
	bh=lWXJnLCAon4LmxYa7HAf9SF50uFb39xoC258CdWi/Uo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RmZ0XgY8VpyZYnri/ZD4Wwebj8ZkrIwARjosbiiMvdmdNJCvS1MhKEzcedlSeaBAT
	 FxPukk1Zj4tJ1/TWfVRi6KsywhhuNPJjk9a0Kvl7D6DMM4OJCss3q+UMNOsJjQrMtu
	 4EUsmJmq02pqmaw5NhLWx+Ju867nLtfNPBF6CaHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfCXSkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbfCXSkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:40:14 -0400
Subject: Re: [GIT pull] x86 updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553452814;
        bh=lWXJnLCAon4LmxYa7HAf9SF50uFb39xoC258CdWi/Uo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lE0veXd0XQJBPx92r7OCSlyHrZFu73qNEG4kT07CZG+CXAeZpkQbv3HroFVfHiKBu
         drR2VBUEvZU98MD+Og7bvoZghM1WmWxXLfnHII2ZG4sny7UiGrXJloRzxhCwhtxzlJ
         qYP7gmQyLy7Iwv4xCxw6fuwPlee/Ji9qfMaRNN0o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155343674152.28403.17446642093501773007.tglx@nanos.tec.linutronix.de>
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
 <155343674152.28403.17446642093501773007.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155343674152.28403.17446642093501773007.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: ffc8599aa9763f39f6736a79da4d1575e7006f9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19caf581ba441659f1a71e9a5baed032fdcfceef
Message-Id: <155345281441.5356.14781573356638657387.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Mar 2019 18:40:14 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Mar 2019 14:12:21 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19caf581ba441659f1a71e9a5baed032fdcfceef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
