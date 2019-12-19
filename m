Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFEAC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D4724682
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576773612;
	bh=kVZO1y7O7/FeMWl1i0VTlzIBrjOvi3NOrNm0YAIByyk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=l4BqWWMnhwlvmtmj9WQRJS6zQ+Jora+pdVf8oksOtSSzTSmaVvFiUfhg9f3eTYJFm
	 K73bKyboGckSslycIx1/EPyQc7ysQzpGux0JOpdGj0af2DPjZzwD5VkxeAUxe+gBjc
	 WtUDKNqIJrYeAnuBZGNS4QVFbx6pqGhPOsxFlR0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSQkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbfLSQkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:40:11 -0500
Subject: Re: [GIT PULL] Power management fix for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576773610;
        bh=kVZO1y7O7/FeMWl1i0VTlzIBrjOvi3NOrNm0YAIByyk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kprPBqkGFsL/3lQQGPTSf25JKXQ8jud2aVvzaTdAJUDNIN4gvnupJAhCXVxxIs7aB
         /GW+DIpi5U/j9c+BLztfbZeP1ZSyMcTyWxkOS8EJ0RAoQ0p0qo6SMPPux5AiIBHCz1
         xMIhz2yYgcSR7LkUK6TFFq1EP5wZvqwSrODwTN4o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hm1D5CJq81Ew9YjGc_ik8nw9Q_-w0a+7iMdarwPmsH7A@mail.gmail.com>
References: <CAJZ5v0hm1D5CJq81Ew9YjGc_ik8nw9Q_-w0a+7iMdarwPmsH7A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hm1D5CJq81Ew9YjGc_ik8nw9Q_-w0a+7iMdarwPmsH7A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc3
X-PR-Tracked-Commit-Id: 505b308b6944a91fa8437a3fd9f2dab29b5c3c88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f096c0ecd53263a94124bdfa516a29f154e44ed
Message-Id: <157677361077.29970.17745239851738773392.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Dec 2019 16:40:10 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Dec 2019 16:35:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f096c0ecd53263a94124bdfa516a29f154e44ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
