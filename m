Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE007C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 22:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C84820C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 22:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557699917;
	bh=p4U116jkf3QKKLRcOcQHnj+XhJa1Q6UE86Y+4vfZHMc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OQMe/i8yqafqYHASLXmqf5wKwICtO1YN50FlkvBRQxdfqbgN4mRYbl44DKJWg0bRG
	 1yziCC/y7M7YLfDyvqCB/CS5GQs53CYloQ7cIbyNvXvVUAJHmt8+NvcIL1YimDmcbZ
	 TScdWKDl3oPSWDvKEGJ3AOjswuaGPIPxsUCW4cxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfELWZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 18:25:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfELWZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 18:25:15 -0400
Subject: Re: [GIT PULL] MTD changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557699914;
        bh=p4U116jkf3QKKLRcOcQHnj+XhJa1Q6UE86Y+4vfZHMc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jUxWlwMTAxLp923P7Znv7P1v0WPiDixQbtaB6m59DB6jsF89GMT3l7xCDgR9LWGC+
         YcaNJgY53BBw/iyfs6sYnjpBoIrZ6bzhdoznWOiSit58L8KQT84PeqOffUx56eAU2d
         EgDnM61lifqke9dVqXA495T291NqGYmHEekExjbw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <789478679.56056.1557697327425.JavaMail.zimbra@nod.at>
References: <789478679.56056.1557697327425.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <789478679.56056.1557697327425.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.2
X-PR-Tracked-Commit-Id: 3008ba87093852f3756c5d33f584602e5e2a4aa4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dbf09fea60d158e60a30c419e0cfa1ea138dd57
Message-Id: <155769991458.32032.14628300238313883821.pr-tracker-bot@kernel.org>
Date:   Sun, 12 May 2019 22:25:14 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com, marek.vasut@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 May 2019 23:42:07 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dbf09fea60d158e60a30c419e0cfa1ea138dd57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
