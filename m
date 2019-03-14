Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 556062077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552586127;
	bh=ZaVkXS6ENw2QMBzOXPQt1Vf0Zsm8E06QpJQekD4V8YY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=n6SKeONmlmwKsX8eXRhV9ABiTexmGtqVvI2rd/q+QXsSDJ++p1B94aH6olCkpd0iO
	 w1Wcix4WUQ79mkRzEQ8f3/kax3uvGwgWBX9GFkUagaSgu8v8nb7SLUZ0NtvkfudPua
	 /dIwgshKsstI7hF0iSKo9XVS4qCmz0Cv27X+w1Fk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfCNRzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfCNRzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:55:20 -0400
Subject: Re: [GIT PULL] More power management updates for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552586120;
        bh=ZaVkXS6ENw2QMBzOXPQt1Vf0Zsm8E06QpJQekD4V8YY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gvovSypFvo2ptr2+1A49uTh6clXDCinMyAWyWRTd0u1oq3EUveMEoYIPiYrzhaHlK
         1H93QO9wb8e2740Z3MgKO79EzQ9o7LFKjQXTH/t1SstQUkt3OYeHy2RG2uSnpSuldK
         RCnqJgDPhsiKHST6cq9+WfsSkKHXN2kWfxpACjkg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0h0y40_bVqOyD-+hkCQmVv1vruO0donzjE7FOZ8jteubQ@mail.gmail.com>
References: <CAJZ5v0h0y40_bVqOyD-+hkCQmVv1vruO0donzjE7FOZ8jteubQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0h0y40_bVqOyD-+hkCQmVv1vruO0donzjE7FOZ8jteubQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 pm-5.1-rc1-2
X-PR-Tracked-Commit-Id: b444e1aa3e48e13aea22162918bd6140c85142de
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9352ca585b2ac7b67d2119b9386573b2a4c0ef4b
Message-Id: <155258612026.11723.16627701451155820577.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Mar 2019 17:55:20 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Mar 2019 12:34:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.1-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9352ca585b2ac7b67d2119b9386573b2a4c0ef4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
