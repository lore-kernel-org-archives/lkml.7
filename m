Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2177C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7D520652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551827718;
	bh=jK4zh61RLO/O2pXJHU0otV239VwIHdc+F3bJwZD5P1g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=joPNu/RZVlCrZOCJ5TM0FLYWPIPhLNqvnzcqfUgEH5ypM+lF3NIlOh7UPrmgMyj8y
	 7P+qmMEDvLZPMZhgnApnl5rMTPTN54LQBWCsoYd+C1zCpZAVYmWFW5ujh9jT+L0jKu
	 VWxZd1KBbXPfDGgfCEmXB7WEaclx5oSARLW0uSlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfCEXPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfCEXPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:15:06 -0500
Subject: Re: [GIT PULL] RCU updates for v5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551827706;
        bh=jK4zh61RLO/O2pXJHU0otV239VwIHdc+F3bJwZD5P1g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jYTTvkjMZdtKnWiVpxZOsnk9KyrIW4kDix20/OlkoQW9edWhhpf4J4x+HDyaH57qC
         kJPAz1qqw1IfHL34Ke1TQOOe80lc4p8J5FhjNGGy3AQkj+wzi0RrQ+CuRCRqh5J2x1
         No7qFBHXzTTTqRIdeyOldr9+QULkzlEzUbV9fNTg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305120301.GA93284@gmail.com>
References: <20190305120301.GA93284@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305120301.GA93284@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus
X-PR-Tracked-Commit-Id: cae45e1c6c541283a1bd155aa7b0a57e353b4df4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3717f613f48df0222311f974cf8a06c8a6c97bae
Message-Id: <155182770600.17926.3766476205299711928.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 23:15:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@us.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 13:03:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3717f613f48df0222311f974cf8a06c8a6c97bae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
