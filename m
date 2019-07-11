Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EBBC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C5E216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 18:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562870112;
	bh=03dy95pU7hXFx0fAu7RHVL86NqSjTwLfiuVRhxYHBV4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=aHqdY7pMsSDuibcB6/Mt1lXI+RklueTYJmLaJ78mlaLA6ogTz5QsR+pW06hGH9UrQ
	 6BEhw2aspLwlI3y57ZLu4Let7fxKHJ8K46sS/S8TaykgH53ORhObvTLoQi71CU9PiP
	 LCugJZ5CbUnjfl4J72QBRCrdfGZ5xnmAJwA050jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfGKSfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 14:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbfGKSfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 14:35:09 -0400
Subject: Re: [GIT] Networking
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562870108;
        bh=03dy95pU7hXFx0fAu7RHVL86NqSjTwLfiuVRhxYHBV4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2HevMoJvXN8gUJNvzN0GsMmI2bxrdw9IDYPSZox3AOfskPSpsLG+j/3Mj9vEwTHLw
         wKXyFbgT672KO2uey5jJqV7BiCxNUBOLjHjzepvvlZwEMHhFHxDiTX39floIh+byTR
         vqFHSmdMadY2YZXhDmXUwvMaruvT9Pm+9SyNKhxE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709.223834.2182721912834033108.davem@davemloft.net>
References: <20190709.223834.2182721912834033108.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709.223834.2182721912834033108.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 1ff2f0fa450ea4e4f87793d9ed513098ec6e12be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 237f83dfbe668443b5e31c3c7576125871cca674
Message-Id: <156287010833.13847.17387879259053198434.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 18:35:08 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 09 Jul 2019 22:38:34 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/237f83dfbe668443b5e31c3c7576125871cca674

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
