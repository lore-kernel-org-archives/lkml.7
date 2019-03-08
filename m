Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCC0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B992146F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552070137;
	bh=HeqHEnoTvxiNTpwVzEh9Q1exS2C7AWvBODE+n/pz29k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WCZAhxdXxKom1ikMCi3qtXVCZ5lu/97P4B0vb9yvsBpxF923dG4eem3NnQNMVw5Uk
	 JtB6YvtlXWY+rsr2neWQYPgaXl9M6W/tDRmk2wOAAc319c9qX0iX341yCxXNaNEvvE
	 K3k43q/Ek+KQ2S6Ris+zm8BzDuWOrGfOUrVKYhNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfCHSff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:35:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:41080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728143AbfCHSf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:35:27 -0500
Subject: Re: [GIT PULL] Thermal-SoC management changes for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552070127;
        bh=HeqHEnoTvxiNTpwVzEh9Q1exS2C7AWvBODE+n/pz29k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TOrR1fwY1L51fWWxM0pmem2GBk/kGvPDuCxYQlQgQk4Wz4x5vPxwe9unzNW06k1o5
         DQsPhcPbks0cXdirxbhSeBJZL4pH/5WCZ71HhXi8GBe5ciR4BGoWJ6wbq9EEfzHLnC
         IANfMUvLoy+IiUZ1PAFAdHyAMcW1zi+CI1dxvauM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306161207.GA7365@localhost.localdomain>
References: <20190306161207.GA7365@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306161207.GA7365@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
 linus
X-PR-Tracked-Commit-Id: 6269e9f790e8d442b3e1529bf3b3de452dd4ac92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f24a81e2e5daf8820c8654afcd8512e797c41f2
Message-Id: <155207012695.7904.15535583986932491916.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Mar 2019 18:35:26 +0000
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 08:12:09 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f24a81e2e5daf8820c8654afcd8512e797c41f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
