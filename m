Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB43C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413D8206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566147325;
	bh=+x4q2gn3Z6Yp69+R9xPluiAlMYRJUajb7IORtx1Mg8U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qZtYaIEVXmVzLv36+b/HK6fsvL6MxXbsawjFuRvkFRWUrA7pbeYQs/BVYgbz4E3Il
	 PakMoa/3QaeAHHEsQ1fFyaYfHByEWIK9ILtaaCZae5hDFR5ULxQjFMvH9nTHTKFsmP
	 ndaAoGh9Zhe0K1LiJldL216szYG6AYCHV+PcKnnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfHRQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 12:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRQzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:55:09 -0400
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566147308;
        bh=+x4q2gn3Z6Yp69+R9xPluiAlMYRJUajb7IORtx1Mg8U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E7QHdeZ1hPHNTUvg9lckiyEoT2ILOe6xD1Fvd6qLrA2B2oS6VrWLpSqtp4HnsHaA5
         e4DgdM7cFwGiyWDmFo9LfH91HYi0zizxmFBU0/T4VfMITNK5sAu5dsguNb8W2GHQ0o
         4e/IlBAxUGnP7NJRzLD3VGHAmIxu9fPjEbe3lxW4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156612809428.21323.8140671080028731011.tglx@nanos.tec.linutronix.de>
References: <156612809428.21323.17038181425044292813.tglx@nanos.tec.linutronix.de>
 <156612809428.21323.8140671080028731011.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156612809428.21323.8140671080028731011.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: a90118c445cc7f07781de26a9684d4ec58bfcfd1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c332f3a70e7a094e4a60d68a2c4c6f051ed7f04d
Message-Id: <156614730874.21549.14426438978328963694.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Aug 2019 16:55:08 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Aug 2019 11:34:54 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c332f3a70e7a094e4a60d68a2c4c6f051ed7f04d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
