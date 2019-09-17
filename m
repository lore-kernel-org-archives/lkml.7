Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CE2C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8656221928
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568751323;
	bh=10wBVDWzdic9WYdUHVtNKyZPwQmRYkU4WC0YxIrFyB8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ekbo0jsBWkT53Tq6u7vP8J7iXlh/2kPrh9wZjKwQY/7JWOH1kSRyGwN6EF1goofvE
	 v9oN8ndThPMOkcJBGFWMYih98OzM7tWyR/zESvZ3+V0cFG239Ug3rvehJQxQVb0mLz
	 LLdlGNdJwYJoMnKP/rCuZNYsC6T5R+gQexjjEPWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfIQUPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfIQUPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:15:20 -0400
Subject: Re: [GIT pull] smp/hotplug for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568751320;
        bh=10wBVDWzdic9WYdUHVtNKyZPwQmRYkU4WC0YxIrFyB8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TLt9wOeKxEfUmdX4q9tOkJnBJ0e5DneDExxgEW3c37oWDt8GSW7q4xqInI521/Xqo
         Oeaojn3n5zs8esL0rE7WJ8ff7X7G9EfOYKTxCTIU96d6CyEMp9BEAxjI+ppZIdgjxg
         XMq4GR7hQjWLiDhyWW9hXElXZpI0cCQtERFdB+jc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <156864062018.3407.12735658875708933630.tglx@nanos.tec.linutronix.de>
References: <156864062018.3407.16580572772546914005.tglx@nanos.tec.linutronix.de>
 <156864062018.3407.12735658875708933630.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <156864062018.3407.12735658875708933630.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-hotplug-for-linus
X-PR-Tracked-Commit-Id: 0c09ab96fc820109d63097a2adcbbd20836b655f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3cd0462230d806077c709e44af8733795eaa712c
Message-Id: <156875132004.8483.2176103209473894474.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Sep 2019 20:15:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 13:30:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-hotplug-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3cd0462230d806077c709e44af8733795eaa712c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
