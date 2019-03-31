Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F09C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872B720856
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554048032;
	bh=t8SHNx02Ym1516xQQ0aLjc06qRd7KiEZ/NoNhKEmeR8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xR9u/So3/bXn4p33iAPLpTe+pnviTXr/ZB5iHsmoK87mOTahFr4WJDecXZUh6asB2
	 ZdAmTpExLTr6M7KBm54pMml8aYVPSIwhRS7U6DOOP4pIj2oXTzX69CiVTgpBwHdbzp
	 vMV4EDTlot0yYBl58kruKiJXTYuZ1PeTjO3y6A8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbfCaQAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:44542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731387AbfCaQAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:00:14 -0400
Subject: Re: [GIT pull] core updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554048013;
        bh=t8SHNx02Ym1516xQQ0aLjc06qRd7KiEZ/NoNhKEmeR8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EDBzl0VtQtvK7t3ZUN8rmxZC9iH7CZdEyCQI7DFJJ5qXXTtlqFP9rm0y3GsXJZyrj
         DslGElzw2Xx8DrdSk9bX9uxsCkt4mr1pnyce1JI8S1lAD2Y7xBWnu1rPmRAnumk2aS
         wZzIB0IK+ovpIj15/lkYQEJDl5JUe5fL2eoLAgtQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
References: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-for-linus
X-PR-Tracked-Commit-Id: 7dd47617114921fdd8c095509e5e7b4373cc44a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f78b5be2a5d08709177963df17b8df42e690a652
Message-Id: <155404801368.15219.13889039103690683971.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Mar 2019 16:00:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Mar 2019 10:39:43 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f78b5be2a5d08709177963df17b8df42e690a652

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
