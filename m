Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47F9C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4ED320874
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569369926;
	bh=qMNqctDBThkqsBsd+QFxirflNL7gPoUksZcagCWzkKA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=k2NzTzJRwM7VLxedaMk0XXmbamYViAH5Fk0PTzw3CdVcazH9awbrEEY4aus6fRmaG
	 rn4/84TrptQjz8iE4uP2JYbcZ65tMQHTinN0wToexOa3kD6lsK5woo96mEiukVxfYA
	 fnk2YKtCG81KHWuGvXhbO1gNmLuKFIA5vaA+d3/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392884AbfIYAFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 20:05:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfIYAFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:05:24 -0400
Subject: Re: [PULL REQUEST] i2c for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569369924;
        bh=qMNqctDBThkqsBsd+QFxirflNL7gPoUksZcagCWzkKA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=odaPwqncVlb60wTcNg3hpmtUK4V8qw7tKPjrzoqQGhp35AJ+jVSWdZNGa5ZPmN9RX
         k7tRRwIaO6gDiiaNP5bp+OV/f3VRMBvB6mYfe7VDs9FHXcYRle2IEemnpm9J3tvw5v
         vNJjHG6+RuWnFMOawUQZDFZ4fvMw7M7eApZJj0eI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190924193054.GA2215@kunai>
References: <20190924193054.GA2215@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190924193054.GA2215@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.4
X-PR-Tracked-Commit-Id: 8ebf15e9c869e764b3aab4928938ee68c0e2bd6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 351c8a09b00b5c51c8f58b016fffe51f87e2d820
Message-Id: <156936992423.955.6087749704237172959.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Sep 2019 00:05:24 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 21:31:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/351c8a09b00b5c51c8f58b016fffe51f87e2d820

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
