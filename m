Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C037C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A442184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552841123;
	bh=tmTBw9GMwh/WTyS2z2o+ogEnBmLBDNDcAYa9997BzV8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tspqJxUU5i7375Jo5fiMQ61DjTgGpP3G/zdIKMAWbuLIkm57EfSL/NZtvN56tOpqI
	 r8wTIHnLMdSgMoXT1y2kNESySIqlnSddZSiql/zhz9z/KkBS+Q30KROsnHafQ2tIGQ
	 73xnlrMdjBvg78Yfw/gwCrWi9MRK0sRf2MCLakIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCQQpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfCQQpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:45:17 -0400
Subject: Re: [GIT pull] x86/asm update for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552841117;
        bh=tmTBw9GMwh/WTyS2z2o+ogEnBmLBDNDcAYa9997BzV8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=foU7gIX7keBpysgPeixQGUDjEblAt9eLu9HC7h7H6u55x5Sc34QRWK4UJn3q19ZAV
         SDb8Ttoj8CTzY/edD3upFErQa31YU4h2otjGGaR1eM3iO3r9Ddgkc0oB5K7bBGv1/k
         4mGAx2QdpIh6KlYaHapCiUW8SRFtoO221MbR9wrk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.1903171527010.9068@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903171527010.9068@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.1903171527010.9068@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus
X-PR-Tracked-Commit-Id: 2e905c7abdcd5ff09b9df33d25eb7148c85bed2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80b98e92ebcb4433b86fd32b5d82ec6b0d75cf59
Message-Id: <155284111725.10074.7889967220897926155.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Mar 2019 16:45:17 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Mar 2019 15:29:47 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80b98e92ebcb4433b86fd32b5d82ec6b0d75cf59

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
