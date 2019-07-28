Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFD5C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020F32077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 05:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564290035;
	bh=Ks1O+mLr4QVL5hrKlJ2DUZh00pBRhVrHvmtgO4jOzOE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uOGWhHLDFFFsqHuMPsBwpUWScxAq+F91nwi/LPjOmTCiIouBIB4SqNpyaJcG4cRRv
	 T3cQCPynPd2An3S8b079cUU7FccgmjuOTNf4w8DASIUHampgJ/wzG/YnCCwGWL7oUn
	 1faOysrW8nm+oGjL6osNpdWwIqnQu+6CY0/CnXXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfG1FAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 01:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfG1FAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 01:00:20 -0400
Subject: Re: [GIT pull] x86/urgent for 5.3-rc2 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564290020;
        bh=Ks1O+mLr4QVL5hrKlJ2DUZh00pBRhVrHvmtgO4jOzOE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dahtLshSEjoqYTgt0P9750XoeOa1YctPYfrwM/DnrXwBiEntXnQIbRbiq4RWwzZ5d
         SSFfEp2dU0uLSGD2MVtyQ1m8jl2jA5NsjP67g1ixWA0p9G7/ZfNJoaUZiim8xnucuS
         yQQrGH45SGwBwPt9uFvqhQ5X9rWYQSjwH1cV7ngA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156426997428.6953.12194106548896484035.tglx@nanos.tec.linutronix.de>
References: <156426997427.6953.14728916479410000420.tglx@nanos.tec.linutronix.de>
 <156426997428.6953.12194106548896484035.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156426997428.6953.12194106548896484035.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 517c3ba00916383af6411aec99442c307c23f684
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9815a4fa2fd297cab9fa7a12161b16657290293
Message-Id: <156429001999.32180.5071989840390166523.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Jul 2019 05:00:19 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Jul 2019 23:26:14 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9815a4fa2fd297cab9fa7a12161b16657290293

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
