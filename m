Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE29C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 23:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19912086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565479236;
	bh=0aO9OhSY6y7Tx5h7ASu6l95K/0M1nYcMWqJEEeH5o/M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=UeUpVyFUFHTeGMRpKYynshTiS1zZf6M+s/1qQF6OMQjHQUD1uRztpGYcBHj/GGfjP
	 8yzgLHUJiW+9VtzE9jOgNy3+iEwNC5oG0CgFwa8KYnSPFuD65gbDQYENfpkYqp2Myj
	 yog1S0cMGuCM+v/JiYPRJDIIebfjc6nDACZX2h+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfHJXUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 19:20:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfHJXUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 19:20:08 -0400
Subject: Re: [GIT pull] irq/urgent for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565479207;
        bh=0aO9OhSY6y7Tx5h7ASu6l95K/0M1nYcMWqJEEeH5o/M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MT+T7jvvsriYCytR5tKO6J1KCLZHZ1/Tq36AdkJJYNYiI+Kqe4ygW1NU17Sf6eScq
         ndb40fV5VRuTidPLrb0LCZDorSNj2xMAVUmen0wZXbva+rPrRcotqUHrcU2/tntLcc
         MysWBH04g49g9RrY0Es+a72fQM129QD9g8XNWfpE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156546731194.17538.17579538052592105669.tglx@nanos.tec.linutronix.de>
References: <156546731194.17538.17422312639927927426.tglx@nanos.tec.linutronix.de>
 <156546731194.17538.17579538052592105669.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156546731194.17538.17579538052592105669.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: 491beed3b102b6e6c0e7734200661242226e3933
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed254bb54fed18549b96285cfdadd69780f52c14
Message-Id: <156547920757.21687.5791354043651618672.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Aug 2019 23:20:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Aug 2019 20:01:51 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed254bb54fed18549b96285cfdadd69780f52c14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
