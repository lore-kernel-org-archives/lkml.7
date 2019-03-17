Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34737C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0553F20835
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552841130;
	bh=we3s7RWH54ovD+N5SPhDN7ENfzQp4PzHgQrRBuOrLzw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=e3ZtwsTr5htzyPAZgaSLMGvtWxpr6OSP1FPwojg83468gYizRMxtk05e1LxIIItgl
	 dwUbNWh1nA2zeK/3oErnVx4Bsn42aaqEAZrh026n5tL3ndQfc2izLqDkrWT9izgRl4
	 gHrMzAp9D9Uf4S5fEnAPISF4pN+rGJoswEYJaB7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCQQp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfCQQpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:45:16 -0400
Subject: Re: [GIT pull] perf fixes for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552841116;
        bh=we3s7RWH54ovD+N5SPhDN7ENfzQp4PzHgQrRBuOrLzw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X/JJ36gS042DoqIYRb1156oNTudp06/fQKbK1VUoPSdDVRJI7DExR8h94p2H0aR4x
         lWmmLqMk9X8s668H2plIs6K7q9seKH/nFksnD3IkxoaPvANm+1DdS6ht0zT+faeS8o
         ZuUr71zdYtgUb1s9zQfCPcbdw7NGuGqJ5YrkYLUQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.1903171523250.9068@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1903171523250.9068@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.1903171523250.9068@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-for-linus
X-PR-Tracked-Commit-Id: c634dc6bdedeb0b2c750fc611612618a85639ab2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69ebf9a16a74cf05359b851a5dc614a63f075d1a
Message-Id: <155284111625.10074.14908020847982637332.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Mar 2019 16:45:16 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Mar 2019 15:26:44 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69ebf9a16a74cf05359b851a5dc614a63f075d1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
