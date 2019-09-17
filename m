Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E653E21897
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568751340;
	bh=MTGjywujn4jBUeC9tJYg5XHoTzUvDzUa5mjDoWKOkXc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wa+rsC0LRmlYle93bbLXybWlMxMeusBdTI2kGcji0CD21rp9zVsx5mD8qV+N+4oPd
	 8NDRuaSQnopoSb4YiBhL89ov5CIRMh9VIMNORR6sIwEM9Q5MVs/IRsmLh0eSOAvPN+
	 kDUL2Qni7yapxN0MRF+CARNUKF+1Wp9FR6KfyLQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfIQUPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727794AbfIQUPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:18 -0400
Subject: Re: [GIT pull] x86/pti for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751318;
        bh=MTGjywujn4jBUeC9tJYg5XHoTzUvDzUa5mjDoWKOkXc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=H9JzpeoT4KjPNjt1zdEs5hYk+LrWm3ImqQIeSpmKhRA5LxLAanYfTWzlQZ8wvSIVU
         QWzCV5DVwZ7wYvU4ybadEXSe0NsFTgk9+NG7vSFHJVtfk/HwoSUOl8zluw1OUOoH66
         Q6YSov0oQ0MLj/aYKDg1qF/HHo/j6Y5hI1Ahtw8w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus
X-PR-Tracked-Commit-Id: 990784b57731192b7d90c8d4049e6318d81e887d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3fb7f3a6ed8666f45ff45124988173758cc7b011
Message-Id: <156875131805.8483.13756585942900572653.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:18 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3fb7f3a6ed8666f45ff45124988173758cc7b011

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
