Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84FAC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED7D21019
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551827707;
	bh=o+MmnSNI6MrfQa5nhj8jMhSgEgLBrhnYeePjGevPKZA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=bEQxGcCgdqeZsoWeWNevgTh+ds3tmt11UnBjeuiRBUmg2yyjjru+IcaKtTuMrNQFQ
	 +OyItLufly+L2ny5Ep7woOhNMBbTtMn8Srea7InIYBsmRK3ZW45cc+RVKL5SRjGKmW
	 pXj3/bpQbqcTl5xsvWF6DzpIFXZjNBD7dfFAdZ1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfCEXPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:15:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfCEXPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:15:05 -0500
Subject: Re: [GIT pull] x86/pti update for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551827704;
        bh=o+MmnSNI6MrfQa5nhj8jMhSgEgLBrhnYeePjGevPKZA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fyKwAY9DXpDnGcGkh3deWl/KrnN3OddBR9NztGuUEkT5THgEwA9mHm4NcfHXADpvJ
         RgXlmKkQJLTPHI+9ARDVg1niF9buukIt15y7fbJE5VGh8YGgJf7qTrwL20MvdMojd3
         VCIndGhcuDiXwy8GRLQGfJYS9lcydGiqM00spDg8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155178637783.3906.11930692733129846637.tglx@nanos.tec.linutronix.de>
References: <155178637782.3906.3253567963332039739.tglx@nanos.tec.linutronix.de>
 <155178637783.3906.11930692733129846637.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155178637783.3906.11930692733129846637.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus
X-PR-Tracked-Commit-Id: 71368af9027f18fe5d1c6f372cfdff7e4bde8b48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edaed168e135f8ec87b27b567a367cbb041f2243
Message-Id: <155182770467.17926.16844947156286895892.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 23:15:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 05 Mar 2019 12:49:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edaed168e135f8ec87b27b567a367cbb041f2243

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
