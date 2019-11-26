Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56187C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1FB20836
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 04:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574742331;
	bh=qPXGSEwyK+M7YCVqbwBHaRLyDweui070sbBfFlkC+lY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=w1qbpsM+v5ypFY274inKjKH3ne9j/5HKXW+1StqC3N7ESd4taPs0GlL0YgCt2kDAQ
	 znjZDjug5jnxebEvjf9cLMUqFLiJbgdBYpvi/DxyCC70CPYOuekS6IOTq+52Fu9n9y
	 6ezAzdTVX6ZCwwvyuyZ2mJM1p0CpDlj390HAMuWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfKZEZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 23:25:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:59862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfKZEZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 23:25:09 -0500
Subject: Re: [GIT PULL] printk for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574742309;
        bh=qPXGSEwyK+M7YCVqbwBHaRLyDweui070sbBfFlkC+lY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B3dL13lF1bSWqqnYs/+JAfP9f2C9mCMyUYlslZxO6GPIS6dOV1PkMX/qqmeMxWAwx
         HHiTXU30TI5WLEJx75X1alsUR1fmFGQkOnQOLz6wuqPtHX+YkEhHo6MEb7y9yDCZ+y
         UbzpCO3AB89N9xPb0gzALLXW/2Q7flBORE0dpoyM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125123625.ddtry6j75bfjrbvi@pathway.suse.cz>
References: <20191125123625.ddtry6j75bfjrbvi@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125123625.ddtry6j75bfjrbvi@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk
 tags/printk-for-5.5
X-PR-Tracked-Commit-Id: 1d28122131b263f169a7f2d288178a56c69ee076
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 436b2a8039ac00f8dc6ae8f3bd2be83748f72312
Message-Id: <157474230895.2264.833576013729335853.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 04:25:08 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 13:36:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/436b2a8039ac00f8dc6ae8f3bd2be83748f72312

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
