Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A7EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70555206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566754819;
	bh=GN8oguaMM0Og+EoJnx3TF/88WSIno3UU2PGGMBlGZKw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Hv2snEu8ej66sJNP2If3OCrzoCe1e1L7eNibqPixD8D1MhI8mv5h2JXG5iE3EUvEp
	 0AUIjU3k518rVirmE84CSVtbx93bki6wphlfgfN3x5Riseip7OukW0WqpZbz+pTYTx
	 BEsNugb9tu7+PmRjYL5FbTi+RQfBmMuaLcgCSYwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfHYRkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 13:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfHYRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:40:07 -0400
Subject: Re: [GIT pull] timers/urgent for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566754807;
        bh=GN8oguaMM0Og+EoJnx3TF/88WSIno3UU2PGGMBlGZKw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RaUGpOMuMo4L1twmQmK0rpVCbMbGo4UShYZ9qWdlU5WIX48Y9pF9cEkrd6Yqc2RZe
         YjxA3lLvt0Ybc8m7KldmRdFrWePY1KhtUc4kwb74VZWwtIbH3wTEecefPr5vSU112E
         urc4t45Go5py6Dz1iUBAAE0DMTvYQpD6IizxTWtQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156672618029.19810.11392026209249158095.tglx@nanos.tec.linutronix.de>
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.11392026209249158095.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156672618029.19810.11392026209249158095.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: b99328a60a482108f5195b4d611f90992ca016ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a13fc3d8ba00b786056e6fd3612b5102590992f
Message-Id: <156675480701.29384.16236142489342664488.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Aug 2019 17:40:07 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Aug 2019 09:43:00 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a13fc3d8ba00b786056e6fd3612b5102590992f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
