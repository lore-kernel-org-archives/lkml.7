Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE56BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 11:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8535E2067B
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572175811;
	bh=BZ7OxbI0k8+LGBOUaqEShlOJgAA+BqR0LXIarFPAJZA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=j/nI+aKLyuG5ByTeTESpBe+3xJdDfxm+9v49wIOTfXJm80WBGfC5AS1KO1pocHUUz
	 ECGksdE+rV55AlPPDzzlXKAJ1LVztpA8RusdE6hiGAmVkgmwtwvDQmDEEMegRCQOAR
	 JVoOIv+DuGzNe9Wa8deHZs+aMAoZkQtczu3UZDOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfJ0LaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 07:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfJ0LaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 07:30:06 -0400
Subject: Re: [GIT pull] perf/urgent for 5.4-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572175806;
        bh=BZ7OxbI0k8+LGBOUaqEShlOJgAA+BqR0LXIarFPAJZA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AE56+258/0g5AmkRxVlRfVXz+lFl5pqXBPlvnqhYF5LvwrVz/MxxLweTg6sy5gark
         n8g6AOEEEqa0fpU0ryTK9K9Di6sfXxyy58mwGdicVmL4OwjhqgudWk+EWX4OCIgb0D
         qQVC3O/+MlhGnxV2o8dmvHmIqTUGxny9WmdJIF38=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157215878694.13117.7140122778575612824.tglx@nanos.tec.linutronix.de>
References: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
 <157215878694.13117.7140122778575612824.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157215878694.13117.7140122778575612824.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: f3a519e4add93b7b31a6616f0b09635ff2e6a159
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8a31fdccabb244dd788090c6974784401f7c5a8
Message-Id: <157217580648.15608.958552834911102095.pr-tracker-bot@kernel.org>
Date:   Sun, 27 Oct 2019 11:30:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 27 Oct 2019 06:46:26 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8a31fdccabb244dd788090c6974784401f7c5a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
