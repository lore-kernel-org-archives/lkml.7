Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9BBC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25B021738
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551909620;
	bh=VAw8MIRSRT+e0pplflJLnKaWqpG57nUoZU1z1kuwKsU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ms7LwZsrGBxypw+J8R0Qun6ZUYk+vV+RInlVPNKAdwLu6ApBhcv41qmKYxvJudeuK
	 4nNHeQvHpXwADwqwMo9HAb1jZOkM6mOYIKE7nRyN2LF/PFUb11ptZJCozReeEkJY+3
	 9GL0FxJNxSEQxLKTMGoinTN9Hb3baR+7ElG7PqRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfCFWAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:00:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbfCFWAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:00:13 -0500
Subject: Re: [GIT PULL] ACPI updates for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551909612;
        bh=VAw8MIRSRT+e0pplflJLnKaWqpG57nUoZU1z1kuwKsU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=S5VfLkQeuGuczFYvoqpbqZb+kxJ04OPuAmkrUuUi0gOZ4t3x42xDJoqzbkjek2bVX
         z60v/xuwetI5XypOICFTmz8ncB44XzgK6QRzOuSoUJeb42rKQuCePBRGhZDW3b6Kl7
         +SaVeXhlB8l++X/Cq4iV6ILY8K+zPCwD6yKHiu2k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gTvVCn6O63+TnU9QueyMgowNRd7dQC0oO18eXJVUMLsQ@mail.gmail.com>
References: <CAJZ5v0gTvVCn6O63+TnU9QueyMgowNRd7dQC0oO18eXJVUMLsQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gTvVCn6O63+TnU9QueyMgowNRd7dQC0oO18eXJVUMLsQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.1-rc1
X-PR-Tracked-Commit-Id: 8167e00e9e35ad90f62e2e424c80c9bc4f3adf7b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d276709ce6c90b9eceecdbd01a0c083ab04d3a52
Message-Id: <155190961288.11982.11231753445202184888.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 22:00:12 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Mar 2019 14:23:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d276709ce6c90b9eceecdbd01a0c083ab04d3a52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
