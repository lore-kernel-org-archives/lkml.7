Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3DAC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BDD214AE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 18:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563129915;
	bh=m+mY587NobP0LvjVC5+14szum03jqWdwPgs8/VIULVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=qWisza5vNIRd6CqtUeuWMGp3Fhhfcxf9Dy/aqXWa1pTlFidDD1hvrktkV2GRr1MAT
	 o5QNeWRJWBKu6ZUepJT8HQxxQFT6Gs4x5hYC5XM1yt9AjB+5EOOKJZHfh8qNJJAaXD
	 1z1v8qEb01Ga5iseOOpoGmDSQhJQHYwQzYsR+Ezs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfGNSpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 14:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728297AbfGNSpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 14:45:13 -0400
Subject: Re: [GIT PULL] scheduler fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563129913;
        bh=m+mY587NobP0LvjVC5+14szum03jqWdwPgs8/VIULVg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wT/jvKBTbujGPeDnfDc4X/emKzU6iun08Q5G5LxgN9rh7yRc49EA6RUEjlShyPtA6
         HM48i4IlUujHGV8ZvwgwWqk3FIWuo8RCkXxDd5D7A56nhQNNvmQcH0IDixhGC//h34
         52zIKOClF4sqKu6UkxN0tRfcjJiR8e3jb5LOgBh4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190714101910.GA127043@gmail.com>
References: <20190714101910.GA127043@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190714101910.GA127043@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 sched-urgent-for-linus
X-PR-Tracked-Commit-Id: e3d85487fba42206024bc3ed32e4b581c7cb46db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50ec18819cade37cccc914ffc71a8b0a2783c345
Message-Id: <156312991314.23515.15918770900638265761.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Jul 2019 18:45:13 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Jul 2019 12:19:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50ec18819cade37cccc914ffc71a8b0a2783c345

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
