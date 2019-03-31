Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6735AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359A22173C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554048045;
	bh=EMQ7Fqt5nxHxJJnflBMEcGDNWQDHp6qb4szkKcOYjig=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Yml+Ivwx76DdT4tebxfuesfZ5sDiJvHajCYJsO49hmZzQuHrb5Y3scDenjIrPM6ik
	 a/Qr9k3L55sB/wNMfwrKyzfz0hxgZTtHKe2XgoDgqyDwhvmVXgEgRzx5Y77SAxRjC8
	 X2grmN4cXNBHb5y7quIyn06/o3B1CoNDKq0lZQpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbfCaQAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:00:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbfCaQAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:00:12 -0400
Subject: Re: [GIT pull] locking updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554048011;
        bh=EMQ7Fqt5nxHxJJnflBMEcGDNWQDHp6qb4szkKcOYjig=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cypnUOzefUXs+QCCDUP+WVYLCvXswnYy23o8WXld09wvAK0Gju5/eOtIdOSklIXNM
         p72pK+j+QAdmrajZ9huuOEyxkmCIeVqsMrXWyRFG6uAEXB9/Z+/HP+s6p0ZeBViCRA
         e2sglVyEV7pV4JkXNLVCh2ls//X3IbeuH/Wuw+d4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155402878327.25983.1164070553362328875.tglx@nanos.tec.linutronix.de>
References: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
 <155402878327.25983.1164070553362328875.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155402878327.25983.1164070553362328875.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: 93a64ee71d10abc5787de7d4a00027e2c6469c3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 573efdc5ea953fdbedb9cfe2d2c2f5d23d60ca8f
Message-Id: <155404801150.15219.8762153284152232889.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Mar 2019 16:00:11 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Mar 2019 10:39:43 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/573efdc5ea953fdbedb9cfe2d2c2f5d23d60ca8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
