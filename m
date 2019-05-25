Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D044C07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7437F216E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558804819;
	bh=hM6OadMFhEZvV+/0q2EXuMBZAHrS1SgwQeNA3HHgJd8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pZtnF6Dagzsp40xEI4qWgwviOFWcSouVX1w9FcAuxKsnbj+MnhIeo4UloLlUOA0cf
	 JXP5+ssviPfVAjvwhzwGgiqKHuICv1vG4xvYGdOVXLwWLskeLcHnd5uUMK+Z1izaSY
	 ooSWE5+mL9raxROHDhKqHzetpkeXjacPFnBXZTbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfEYRUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfEYRUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:20:18 -0400
Subject: Re: [GIT PULL] libnvdimm fixes for v5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558804817;
        bh=hM6OadMFhEZvV+/0q2EXuMBZAHrS1SgwQeNA3HHgJd8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ozJnTovkxqyDNrBOuNlyht6Mb5e+wlVo9YG6ICWiDrooFlBXnpRaukw4+ARbyXDG1
         heH95BDYRBdLiUwCOFtDENBThbyGP6DRnM12NJUGgl/3zh102XRrNqAa/XhF6OVkso
         asO4ZXxnMWnZdbbBan4PeA5HnJ23RB8pjVIjM564=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4ghA3bGeTFw+wVV5N8cb-izpwdi9BQU5Ec6wNTw8ZywMw@mail.gmail.com>
References: <CAPcyv4ghA3bGeTFw+wVV5N8cb-izpwdi9BQU5Ec6wNTw8ZywMw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4ghA3bGeTFw+wVV5N8cb-izpwdi9BQU5Ec6wNTw8ZywMw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
 tags/libnvdimm-fixes-5.2-rc2
X-PR-Tracked-Commit-Id: 52f476a323f9efc959be1c890d0cdcf12e1582e0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2ad81363f12261f8b6a97ed7723960ea6450f31
Message-Id: <155880481554.7430.6840543435398022446.pr-tracker-bot@kernel.org>
Date:   Sat, 25 May 2019 17:20:15 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 May 2019 09:05:03 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2ad81363f12261f8b6a97ed7723960ea6450f31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
