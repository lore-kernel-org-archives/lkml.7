Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12FBC76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAF22183E
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 18:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563648039;
	bh=D8CxufH+ZLCxOcmkYjiiBFGD4DaPIRsv2t52bC0YZLU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=sF0ojYJdLLOaAhKOdoQ1c95G7M14EOKPgEyk+poSBBjMLTIS7T9/GZUj2wTX7E8hU
	 oc/PC6pK65HuPF1MXVy7lmal6wEbMJVuEUYX1H9HhCq3xZJD7kTCDtt0mt+0+QxoyL
	 IfEJJAsTIRazYmOa39upBtbjNH5UlFQn4yVv0+5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbfGTSki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 14:40:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbfGTSk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 14:40:29 -0400
Subject: Re: [GIT pull] x86/urgent for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563648028;
        bh=D8CxufH+ZLCxOcmkYjiiBFGD4DaPIRsv2t52bC0YZLU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D2HKySVPhM3FL4EqVHtfzT7nAj149BQBpKx33SsagPtq+zSdiEGeCqZIHptHTQpNI
         ZkRiSOwpqCXUIbnTcXV4oJvY4ArhXo4xmEPbMx1YDeHjkfE8JNdCia4y/XO495MsUG
         Z4pKJXn911eMlYKNkFWygcANbHlzYckXlGvyHW8M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156362700019.18624.7822425287291380783.tglx@nanos.tec.linutronix.de>
References: <156362700018.18624.18097992605540415098.tglx@nanos.tec.linutronix.de>
 <156362700019.18624.7822425287291380783.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156362700019.18624.7822425287291380783.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 6879298bd0673840cadd1fb36d7225485504ceb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6dd78fcb8eefa15dd861889e0f59d301cb5230c
Message-Id: <156364802893.20023.15834093863755103206.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Jul 2019 18:40:28 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Jul 2019 12:50:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6dd78fcb8eefa15dd861889e0f59d301cb5230c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
