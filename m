Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1E1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDE32133D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553452834;
	bh=TsSOfKXi/egbIiV9CGC7B/I3d57EIwGBq8rLiT5wGdM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=TRXn57cJYiGUX7/Gk2xyFRpwWc7r1ZAll2w+X2J+4Jmbk0fDJLtY1p5IikVOzQr9w
	 lTJFLVfzVrm+YCGUWjcvtIhkR6SMunMNFzb9IMsBH8w0mwj2ihF2KoPBj7E7dtWi3c
	 eJEjdbMswasvw04+1y52/1VBxzsolde9RXrl01a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfCXSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 14:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbfCXSkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 14:40:14 -0400
Subject: Re: [GIT pull] irq updates for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553452814;
        bh=TsSOfKXi/egbIiV9CGC7B/I3d57EIwGBq8rLiT5wGdM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2GiPnEVwJaTHMytAlzExtwxUMFoMxI92Pt3DKdGOkyGSoTl4C1MLTaZjH3sWlB+od
         oquBOhUjGTkEgI55jQNR2O4ztnQZuA+y/h9QPGl9y9V8u7lGhr3enUIJRKnS3jmK6u
         FxWbCl6DRciYsYF6zAUgTtmNnry5u9pTUCJTopBA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <155343674151.28403.15105698349850612949.tglx@nanos.tec.linutronix.de>
References: <155343674151.28403.7455818401538063350.tglx@nanos.tec.linutronix.de>
 <155343674151.28403.15105698349850612949.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <155343674151.28403.15105698349850612949.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 irq-urgent-for-linus
X-PR-Tracked-Commit-Id: 93417a3fda2060f2a34e3341904024c5b6980d1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e08fef881dd5f33d97db35a32cc71e04061163fc
Message-Id: <155345281406.5356.2858970089217409598.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Mar 2019 18:40:14 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Mar 2019 14:12:21 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e08fef881dd5f33d97db35a32cc71e04061163fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
