Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAD5C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90DE2173B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564290024;
	bh=h7kzRa5hFyyhBnf08eI9dN4uHsAyDZnTH5eIhvBznIM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=brljfSnwl+71nd517FmloDPFfzxn3pneYFz/NsWb7mD5TqZ8HCJDZuikqH7tWhkqY
	 t2jjmlyKrbaTIvmAfOlzeOYTsvu6+BitKFcSYkwc3qYSpExAzwjLQ+b7sH0x2rGdsG
	 JD7welykIyQapyGtOxUwOTyg3AhrtN18SiEwP9Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfG1FAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 01:00:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfG1FAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 01:00:22 -0400
Subject: Re: [GIT pull] sched/urgent for 5.3-rc2 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564290021;
        bh=h7kzRa5hFyyhBnf08eI9dN4uHsAyDZnTH5eIhvBznIM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kQZxb5HjC0iskawNgJjYgToyu9CTZOWHuHSU/WsPMIz68as0QaqtFQua15/uu6E31
         VKQCfsZIE1gqeRt3Vq7CxvhiaKfu0HiU1I8SYx8x3MGq9HrX+8dmkW8ts1tgKNrpjm
         pdzfIOg52PEnYQhR596YFpbmqwSQ1btKsBBFTczM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156426997428.6953.5838322278411587557.tglx@nanos.tec.linutronix.de>
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
 <156426997428.6953.5838322278411587557.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156426997428.6953.5838322278411587557.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: cb361d8cdef69990f6b4504dc1fd9a594d983c97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e24ce84e85abe50811f33caecbf104b7d9dffb03
Message-Id: <156429002118.32180.6916834956145036803.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 05:00:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jul 2019 23:26:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e24ce84e85abe50811f33caecbf104b7d9dffb03

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
