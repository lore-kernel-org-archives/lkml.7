Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664E2C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D6420835
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186103;
	bh=IpI7Bpc79gKJ5b4Bp6rfHLVPCBAo9Yw4jxLTl9FA+To=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=T7whYAjKwdVNiVtkB4b1sPZ5w0rqJWvOQNoO3hiJz7mM+NNWOv5/rjg/bZtMmsAVw
	 K7A6Ppb9xWjsQmkDXIMvauYd75sswQhurPoJIExSdcsovOINOHceJcgSuVAhvTGTLO
	 NgEt2yiEeHA87Y3ZDBVttnz/rOterfRT8gAn8bVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfEFXlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfEFXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:08 -0400
Subject: Re: [GIT PULL] locking changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186007;
        bh=IpI7Bpc79gKJ5b4Bp6rfHLVPCBAo9Yw4jxLTl9FA+To=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dZP5+NxLhRO8UbmrEx9cyCwpc6NRIzzyK39HOsj8a/XO3Qt5HViApSoK1bo6miMNf
         tbpoANIhTFiQ4un9TnzSCZbxtRsFS4uEiHU0pp5iP2Jsj1xft933CLcgU5GW5VTMFs
         tMTMBmVqOWP/kTjAw/7RizB2d17TgRFJncS7Fink=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506085014.GA130963@gmail.com>
References: <20190506085014.GA130963@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506085014.GA130963@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-for-linus
X-PR-Tracked-Commit-Id: d671002be6bdd7f77a771e23bf3e95d1f16775e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 007dc78fea62610bf06829e38f1d8c69b6ea5af6
Message-Id: <155718600752.9113.9839179997460745552.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:07 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 10:50:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/007dc78fea62610bf06829e38f1d8c69b6ea5af6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
