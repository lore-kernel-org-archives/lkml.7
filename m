Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E499FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15C1218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553897732;
	bh=4Wj5upoTLmfXdZxj3d6ESXcDAGRwep27PapB6pFSwSM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=txlVHmKto9cg1w1E2XIcmJFPZr+B8aEUMQWGAeJII3nH9blwoQnYu9VeVzIMwMWdi
	 JXuZFeI+LGsm8zOZTsxf5eBzq4Qhm80fSkdRUxeUdKfKM3kyztBhtRnlsbTJboyfS0
	 spJFbvLH4hP9SXLGWF7q9MVy1JIa92ciQ4sVeDj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfC2WPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbfC2WPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:15:12 -0400
Subject: Re: [PULL REQUEST] i2c for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553897712;
        bh=4Wj5upoTLmfXdZxj3d6ESXcDAGRwep27PapB6pFSwSM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pv8vfRbm8lxHLAYhjSeomMp8OI/zreWW5ghIicVizoo8moMIvUofa30heHQqZVdcQ
         FeJAvanfUvTI0YBtMnwqotJ8o3CfyxixV+FGtyV36tnodhEWkgPmskcu0RPyRJEg87
         Zn2GtSUct43TC7kQUFTEovFRZZgJ9+gvrM3EtlgU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190329151647.GA4556@kunai>
References: <20190329151647.GA4556@kunai>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190329151647.GA4556@kunai>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current
X-PR-Tracked-Commit-Id: 080a910414659dfd18ffaf60a1e95b96c3f50eab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ad528360cf6455bfaaf9164350ed74cbfadc7c5
Message-Id: <155389771203.19616.12279873121343869194.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 22:15:12 +0000
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 16:16:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ad528360cf6455bfaaf9164350ed74cbfadc7c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
