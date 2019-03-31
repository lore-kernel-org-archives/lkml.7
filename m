Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D26C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855F02173C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554048018;
	bh=PGSwxLLQRi/owIu21qnGn5w1fg4vcOYviGDHaGKSVw4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TpxXJIODAcbaiUHQREzjLxR6Cii5mRpQBvlZhwY3ulcggJQ+GTxh1GK5wobBzetXh
	 YETadnt9Zbj8vVLEN3BOz13cjrwEYH334Z+6J+BGjUtipk4VDt84+/lpQ61719dDCo
	 JfC/Jr0twnbOvdV/CaRgafJuz/QwovCz9oCWjuyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbfCaQAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 12:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731365AbfCaQAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 12:00:12 -0400
Subject: Re: [GIT pull] smp/hotplug updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554048012;
        bh=PGSwxLLQRi/owIu21qnGn5w1fg4vcOYviGDHaGKSVw4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MpEzXn4HCRbuVOPbHO4OpxMyMftGwdUIbH0CEqG2DZ4BZylfsqe+z+mZuqc/1/dls
         nGMo4vKnATHFhFALf/Hsqee8ofSeYaJGOeGNACx7LWpb9RTFGPgAEQyES2U8Jilayx
         +z0w3qZYVsZqOxUZ7ITelg9t7UzMN9aGEFXY7jzE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155402878327.25983.12240602392812564980.tglx@nanos.tec.linutronix.de>
References: <155402878327.25983.10899882979692424898.tglx@nanos.tec.linutronix.de>
 <155402878327.25983.12240602392812564980.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155402878327.25983.12240602392812564980.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 smp-urgent-for-linus
X-PR-Tracked-Commit-Id: bebd024e4815b1a170fcd21ead9c2222b23ce9e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c29d85417c5f9a0a970ebd2571b65f0d52f110f5
Message-Id: <155404801206.15219.9724185859235154170.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Mar 2019 16:00:12 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 31 Mar 2019 10:39:43 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c29d85417c5f9a0a970ebd2571b65f0d52f110f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
