Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F458C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1F620652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551827714;
	bh=aUJKWO+UEnWhk591B+Ka7k+Z/KEzONqajtB1NX27sbU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=W0YYI9Maq1zIqDTHLuuwyT3ERRgy5Py4A/j5QS6obhlTEAt+AvSCAmLk7sWfeoD6U
	 8wHKQJ10+u8ehKFgHqdfROEg1EiVfJ64q35A8UB3PhAo4t6luz2cn6n5gIoC0iScO2
	 JJQbpMCNyvqDANP12GbMow6UmYvFydq10WhDLy+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfCEXPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfCEXPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:15:05 -0500
Subject: Re: [GIT pull] irq core updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551827705;
        bh=aUJKWO+UEnWhk591B+Ka7k+Z/KEzONqajtB1NX27sbU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MHsJET7/1z9EqnHeqGzqJo0t+HTFeMxNpwyaoxkwm4glYP2PjRnvD6uJ5DpWQl4zv
         EVBc0TbxgDZcFuaVvj8e6l2mA36RX08+EkVi2kdZHhhTdLWv12qXZDgFDgBcQ7rusq
         WLxYLtg/4AwaIYjwtcHcjhMOgvX6yMHN8SIOIjrA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155178637782.3906.3253567963332039739.tglx@nanos.tec.linutronix.de>
References: <155178637782.3906.3253567963332039739.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155178637782.3906.3253567963332039739.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus
X-PR-Tracked-Commit-Id: a324ca9cad4736252c33c1e28cffe1d87f262d03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78f860135433a8bba406352fbdcea8e8980583bf
Message-Id: <155182770514.17926.7650735736608048802.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 23:15:05 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 05 Mar 2019 12:49:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78f860135433a8bba406352fbdcea8e8980583bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
