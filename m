Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72186C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7FF2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553452830;
	bh=fZX4FpyIFTPUzKS9OkW5heXBIosaxQiFm1azyytw6qo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=AamKjMcpNm9bdoPBgmeF9MmQjBVNk3wmY9cnhkkhDumx8Guzxjx802kFvvo0J+YXZ
	 vFC/Dr5VI590UCe4RyjDZNd6fNrJCzItElxc8XhQCLfkJtwnhK8gHwJGh7WEYMWntn
	 Q+Fvuq0JgcMsNC3gXiGV7WBluzk7JC88zXW3V688=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfCXSk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbfCXSkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:40:15 -0400
Subject: Re: [GIT pull] timers updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553452814;
        bh=fZX4FpyIFTPUzKS9OkW5heXBIosaxQiFm1azyytw6qo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OKjXdbKlxSd+HtzNaBdk9MBHBW8C3ms6YvjQcp/7v+P0DhXxTQFDYsavl13jfF76L
         Kb8Q2oH4N6qdYfMH0ShAVrK6zki5L5zt5DnUHJ7lGAIJJBghQkoLbumt3YdYUKxX/m
         P1czI1+8Y5MuJQIVF+aw94MMpLhkntlScH+7etko=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155343674152.28403.6243688206829902894.tglx@nanos.tec.linutronix.de>
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
 <155343674152.28403.6243688206829902894.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155343674152.28403.6243688206829902894.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 timers-urgent-for-linus
X-PR-Tracked-Commit-Id: 2a6a8e2d9004b5303fcb494588ba3a3b87a256c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a75eda7bce5e8ffdebe6ddfe513b31e5ec3527d2
Message-Id: <155345281479.5356.5114164329581846595.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Mar 2019 18:40:14 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Mar 2019 14:12:21 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a75eda7bce5e8ffdebe6ddfe513b31e5ec3527d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
