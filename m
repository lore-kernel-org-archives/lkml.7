Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4654FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13AA3218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552686322;
	bh=4g6qcNatoOVDOWTUq7OdMxy/00E5KAicQSKCkd4pE0A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mil6Fpi29NJQO1SeZlBz0cPkGb9jWJfFciaUTM3XHyGO4MS9DAjx+MtHn8ZMfXhxn
	 KFtB/ylB9ao1wSONPV61riv0OQimK3qQVHM8o7DmhOx6mTvOEsXIdVG/lAtRgyjDwc
	 IJG2bWnQuI/HA40ajgH/9PI1eEw5H93G5PyQ2aJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCOVpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfCOVpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:45:19 -0400
Subject: Re: [PULL REQUEST] i2c for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552686318;
        bh=4g6qcNatoOVDOWTUq7OdMxy/00E5KAicQSKCkd4pE0A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Sh9ElEhXm9s5Knw8qzaJlrGwZ+Z1B3rzxvS6boy+6WL5MQsoeb7RxCZtHuqDkbKLi
         bQ0v+bS2We7lAxNJj7RxFKU8io3vj6WIIFf0kUFpn1BzyyKqqVSppVnTe0v2phbNZb
         thdRNc2q+SqzuqLRjUQXjHH2cFUyRBCREcTGhO0U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190315110010.GA2084@kunai>
References: <20190315110010.GA2084@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190315110010.GA2084@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
 i2c/for-current-fixed
X-PR-Tracked-Commit-Id: cd86d1403bb4c80e443d736b2a692cbf68a9f471
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51b1ac0fa2403d1db009189122c17b7c1ea37b33
Message-Id: <155268631871.16247.1605102877130123097.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Mar 2019 21:45:18 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Mar 2019 12:00:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51b1ac0fa2403d1db009189122c17b7c1ea37b33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
