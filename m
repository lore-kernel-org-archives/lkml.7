Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A758C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7F22173C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554048016;
	bh=TIiMXe51y2NdFeII4MapkYNH30ZpJzvclyMqBMrkAh8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pjHB5ebmGlEDlHYt+LV/132yzTaLRsG/yWdRAw1Ukku/9VlzFO/8sIPejhll3HqfU
	 /n/a+iqoEPLXZ57jGqz1WYeO3Wfuu0gdaCB4fPDhYzxBS6nE/scNJWujYG5kVSz+zy
	 YakDMOsy/Wr+YgKZBRMQl330P++69YzbRyRz78ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbfCaQAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:00:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731177AbfCaQAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:00:13 -0400
Subject: Re: [GIT pull] x86 updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554048012;
        bh=TIiMXe51y2NdFeII4MapkYNH30ZpJzvclyMqBMrkAh8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=U1hazP3g+6coOk1ApFoHv6IWDIkxuN2/3DjMKIJEXyDttQ43CoocZQKgot5dynnmd
         EED38rVQmbyec+6i4MsQRdSrOo4BAQT1YmijYZk5ZtB7xUhVHRKdlHbzoWJBefUlRk
         BrffLg0fO3jyH+6eJi+V1SEznNWdS0ZZNZOPu5O4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155402878327.25983.8123182893406429117.tglx@nanos.tec.linutronix.de>
References: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
 <155402878327.25983.8123182893406429117.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155402878327.25983.8123182893406429117.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: f560bd19d2fe0e54851d706b72acbc6f2eed3567
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 915ee0da5ecb7ac7fd023ae36f01c47ce47a45d1
Message-Id: <155404801260.15219.10594336649700756820.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Mar 2019 16:00:12 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Mar 2019 10:39:43 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/915ee0da5ecb7ac7fd023ae36f01c47ce47a45d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
