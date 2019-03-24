Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A172EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E0B2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553452840;
	bh=qkTz9tOuCGbFF3YGL9j8ZC8zgyFSibg0z2Gwm1U4AkM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PyHa5entsxFxzfP8WuXamfHT28MlYvUNRsbAuQ0kJBSV/24arW5AQOLFTFjdiuLkJ
	 GdqSD+RqOvxn+w1SGf1uSzYid4A1f8aS7XRr2hjeXdZrFYYoYiHqgVyek/lcsmc9TK
	 VOG337DFN5jCxI4Xv75gMjXVDCvPnwS9jrG2BEbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfCXSkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729087AbfCXSkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:40:14 -0400
Subject: Re: [GIT pull] locking updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553452813;
        bh=qkTz9tOuCGbFF3YGL9j8ZC8zgyFSibg0z2Gwm1U4AkM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dx/IBicKDWzmm5tuEqsHgkOZ74h3gYomtr+oBKeOi6SdHQCXY23GuKjYivO56B6uD
         je0UZfc8RMuooanoEdoA/S1yzRhX0x8aBk1XxNeRO6L6mMl6UjhhDOedb7FqVgEnG7
         MKNSRxdhDjqjNDW2KF3wYhiIDmykPmLmZugPcbAk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155343674151.28403.8597495949023094608.tglx@nanos.tec.linutronix.de>
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
 <155343674151.28403.8597495949023094608.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155343674151.28403.8597495949023094608.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-for-linus
X-PR-Tracked-Commit-Id: 5a07168d8d89b00fe1760120714378175b3ef992
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6cc519b6aed437d61ca19c0e0031553925ff257
Message-Id: <155345281368.5356.16168766482307620180.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Mar 2019 18:40:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Mar 2019 14:12:21 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6cc519b6aed437d61ca19c0e0031553925ff257

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
