Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7208ACA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A417222BD
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571568318;
	bh=oBAXu4wpziO8RNOK5tTg9LxlVC7Dub+AZKWlkfR/fhE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=RAmXsAgYSZppz9adMAyyVcWJQt8jNqSzHXP4xxjRsiFlFIwiQxEPJGkSFexxaX4b7
	 vlIdK6BIKvGY8rUPM7IPd28CJRYb5Q/TITYrgndf0VwOSPodaemwuwuzZ+ZDJJoANB
	 7xzBgdxtlbktufPUwvdBIaUWlwCMtUD5psNqyKzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfJTKpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 06:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfJTKpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 06:45:06 -0400
Subject: Re: [GIT pull] x86/urgent for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571568306;
        bh=oBAXu4wpziO8RNOK5tTg9LxlVC7Dub+AZKWlkfR/fhE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CnUymjkgdCI/2zWHDGNnqblFCPvG9BEjC8Jc5/XScSPfhmiJ6E27emyHyHJj7XHgU
         MDg9WxcXqAPpSIA8C9SguHS5Rykcq/6NB5BtoCPfnT7CHVd8KpjelN+drl63Zv5ReE
         U3PUtdSdF30Xd9fI+C7pfxm92ncruUyFCH65kC0w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <157156643658.8795.4431392863558132451.tglx@nanos.tec.linutronix.de>
References: <157156643658.8795.8700195163364281095.tglx@nanos.tec.linutronix.de>
 <157156643658.8795.4431392863558132451.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <157156643658.8795.4431392863558132451.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-urgent-for-linus
X-PR-Tracked-Commit-Id: 228d120051a2234356690924c1f42e07e54e1eaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fe34d61a3a9d9ed954cbc90713506a7598d6b36
Message-Id: <157156830635.17957.15370246840199294959.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Oct 2019 10:45:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Oct 2019 10:13:56 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fe34d61a3a9d9ed954cbc90713506a7598d6b36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
