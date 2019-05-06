Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF31C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A39220835
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557186088;
	bh=wLvblnipMupvIvx03SJNjzBBfSa4LBKvClGrLhdhqOk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GFRLTnd43tD8yqb78S8gfA/V7Lqn493+UlD9vV+a3J5TszcwIf7TOfF71B4Eu5zpB
	 9rwTqXj0yNy9NG2UIUkLqDA0kUoVqZA/6JlcRGs1xEunh0vOIpGKI/lb/X9d6E9OD3
	 Estl0v2kOH79EybnZOia4TehY0XEL383WeqCGmb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfEFXl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbfEFXkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:40:08 -0400
Subject: Re: [GIT PULL] SMP hotplug support changes for v5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557186008;
        bh=wLvblnipMupvIvx03SJNjzBBfSa4LBKvClGrLhdhqOk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OjxOoxUecejh83YfvRscRlyhNkuRd8C3G+ALshYiGhhn9ivY8iV9UyONNTnk8ECS+
         rVpgt4sFeP4+jheS35tGYFsvZuh2FV/xXB29/zUhlCMlixZgJuWt9liROsXRYdxfpQ
         3pCM1drk7L8a+5eXaDzlWcK+r+A07JEcV/V7FqpE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190506091632.GA42696@gmail.com>
References: <20190506091632.GA42696@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190506091632.GA42696@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-hotplug-for-linus
X-PR-Tracked-Commit-Id: d4645d30b50d1691c26ff0f8fa4e718b08f8d3bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a2bf1abbf96fca02b9785c252e569ef8e004851
Message-Id: <155718600840.9113.13445751111078551504.pr-tracker-bot@kernel.org>
Date:   Mon, 06 May 2019 23:40:08 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 May 2019 11:16:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-hotplug-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a2bf1abbf96fca02b9785c252e569ef8e004851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
