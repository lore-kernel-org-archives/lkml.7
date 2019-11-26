Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8D7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E375220870
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 19:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574796614;
	bh=H9BbHDwq9ZHyO7r9QqF7wYvXoTNpCq7zEyfeNbb3c6k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EenDv6bDp8FkKQI30ru3YNGKHpxUWskXSselBxLcX4ryJ+0oEE2c+5f6xBMeDw1uE
	 z+8GNUZr7U1sNV8xtCTP4KIm9L33eq7DlObG6dcgTTX3V1lyGaJLvF5JEt3+b2JG6M
	 q0lKglR55gf45sz0VDy4YQi1M3CI6OORJIqfDXtY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfKZTaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 14:30:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbfKZTaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:30:07 -0500
Subject: Re: [GIT PULL] x86/apic changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574796607;
        bh=H9BbHDwq9ZHyO7r9QqF7wYvXoTNpCq7zEyfeNbb3c6k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fS07zH0L/BcWwQIWX8HwKQKn7mV1J17Dg7tQalN6dzOr3R6vR4baUj/leqcSSA6KC
         bFVj3fq5tc4/sNEPpQIns5/6SD3ggmwG+Wvtcbe7eoCAk+e3olB3StnGGi1CC9YjFX
         XLL8Xwh+1FZvG4Gm0hYYo+coRfq8AsKysLafTn6Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125131729.GA79722@gmail.com>
References: <20191125131729.GA79722@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125131729.GA79722@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus
X-PR-Tracked-Commit-Id: 2579a4eefc04d1c23eef8f3f0db3309f955e5792
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd2615908dfd0586ea40692a99c44e34b7e869bc
Message-Id: <157479660745.2359.9661423418098183544.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 19:30:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 14:17:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd2615908dfd0586ea40692a99c44e34b7e869bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
