Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B566BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 00:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8497F222D9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575245417;
	bh=iqq6lXJBg3gll30hOu8A7AbbrXvqRaMX0FdwYnExI4E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=q80wVywndSKAV2c53UKgpz1JxliEXXO/M7kFZbBlsXSoPSw30kSw2SwDPXO5t1Mo6
	 Vd1ilFadkPGcGtdFfhkSoPyFY9ZKOesueJiJLDJUbD13FgXaOeJlYHnhErM4JSdUt3
	 k70DCzYQwKc9RyNDhlIeqdPpfB9LhdTEYMv+74t8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLBAKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 19:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfLBAKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 19:10:16 -0500
Subject: Re: [GIT PULL] y2038: syscall implementation cleanups
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575245415;
        bh=iqq6lXJBg3gll30hOu8A7AbbrXvqRaMX0FdwYnExI4E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GucPhqCDjnhKjZxtLEBJJpMAIv4XkqH/zUBiXM2apvnPV57uNwTqs11tTUQwkdD8/
         ndLB4RwV+UpKbRPqyulG6MA5xJiEXlm/jEjqGiGeWPiD+uhPbcfyefxFGuvkeFtqet
         1/ZnWnbMZCgTY2MnwLrWm4aTWxSKiDKuP9/sSqcQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a38Q_yhiyODpFd6ZqLv=QyKRmCm8FOMuSr4RPvGtWNPYw@mail.gmail.com>
References: <CAK8P3a38Q_yhiyODpFd6ZqLv=QyKRmCm8FOMuSr4RPvGtWNPYw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a38Q_yhiyODpFd6ZqLv=QyKRmCm8FOMuSr4RPvGtWNPYw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
 tags/y2038-cleanups-5.5
X-PR-Tracked-Commit-Id: b111df8447acdeb4b9220f99d5d4b28f83eb56ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ceb307474506f888e8f16dab183405ff01dffa08
Message-Id: <157524541577.21884.12235201329343796550.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 00:10:15 +0000
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux API <linux-api@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Nov 2019 14:36:16 +0100:

> git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git tags/y2038-cleanups-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ceb307474506f888e8f16dab183405ff01dffa08

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
