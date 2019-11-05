Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12ABC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80F721925
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572980708;
	bh=ExLIsxZ9XZ/yP3aRH72tp0VxpEpuivnzsowuENnLwDQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ofj7/6yqSuBpfzDdpBp3ukPiDEiJZrUdFLFDFqGZ7ZePInDSMoY6F11KZzwEX3I8p
	 YLa/ltOrq9tPdNr2GV/y/tTY1vvayCbvr+84SI3t1PVzhHeHIkklzPshtvQhaHFwZ8
	 nSApZjeWQrys4YGjjtpHxH3KXgWofAZ0++8L/pbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390831AbfKETFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:05:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390514AbfKETFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:05:05 -0500
Subject: Re: [GIT PULL] GPIO fixes for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572980704;
        bh=ExLIsxZ9XZ/yP3aRH72tp0VxpEpuivnzsowuENnLwDQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kiV+lHrl4FEHRKKW9chhdGJPc/cJFmXWbYna8RrG5fwZE3QyyE9JrK05vFDWrKmyk
         t8qczFhSDyt2sPtFKwrxL3ozzt0dBQvCBvBBNle8sHet88Sb1RzpnGFOniLRac5uQw
         YtQXAJ2dCnAdJ3lf1AyLFboH6dZ0cuR1ie5gV+3g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZrum7MrNCMS9jaLb0OEMEjHu+xZaL9AbsqyLEz+m97YA@mail.gmail.com>
References: <CACRpkdZrum7MrNCMS9jaLb0OEMEjHu+xZaL9AbsqyLEz+m97YA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZrum7MrNCMS9jaLb0OEMEjHu+xZaL9AbsqyLEz+m97YA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
 tags/gpio-v5.4-4
X-PR-Tracked-Commit-Id: 1173c3c28abfc3d7b7665db502280ba9322320e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7111fa1151e3c66cde3a94250bda72d7144419ff
Message-Id: <157298070437.13819.5219173279870399946.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Nov 2019 19:05:04 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Nov 2019 16:00:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git tags/gpio-v5.4-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7111fa1151e3c66cde3a94250bda72d7144419ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
