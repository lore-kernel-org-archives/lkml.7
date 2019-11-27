Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D97DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221AB2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574818217;
	bh=Rpvlg1wGcAstMTJCUST9ULZ68Ja+EclHFGb/WpN6S4E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=16+rte8aRiWl6JYwHBP2L8dsKVQtyYFAHWMK+8hqGAJ9SpTQQKvK6tl+XYRzIhUWC
	 j9eM+5Si7LGmIVlINa1IKCjNZLpBsAOL0tiRP+SCEk4rVUpIYjElF+PYuOJvPt17ec
	 /F4zuffSBpNv8J7ze4wSIN7xX+MNOmWmNM/jt70g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfK0BaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:30:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:59098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbfK0BaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:30:13 -0500
Subject: Re: [GIT PULL] locking changes for v5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574818213;
        bh=Rpvlg1wGcAstMTJCUST9ULZ68Ja+EclHFGb/WpN6S4E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vKRl688KidXa/d9G6fqi6TCVjuU6K+/fsuMHOZPD9yKZovxkWJ1S1sK7rrArIUyYH
         KnFaCCXWxu9ddY463xgno09Y6GZI/UJlbsW5b+jK4HvVvR6rhx50PnfvymV01v8qp5
         BAYSQ0BtJhyRGBpRgY9dz0QM357OhFSkqAY6BcZg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125113542.GA109603@gmail.com>
References: <20191125113542.GA109603@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125113542.GA109603@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-core-for-linus
X-PR-Tracked-Commit-Id: 500543c53a54134ced386aed85cd93cf1363f981
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 168829ad09ca9cdfdc664b2110d0e3569932c12d
Message-Id: <157481821311.26353.4985281013101467128.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Nov 2019 01:30:13 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 12:35:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/168829ad09ca9cdfdc664b2110d0e3569932c12d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
