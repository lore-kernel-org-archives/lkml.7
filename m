Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D59C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31C6218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553967026;
	bh=K4Nlba/ZRDYxrLQyHZ/DEMKkwY6BDuJdfp7dxoJBh00=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ByPOzvgwNDUBO6OVHanrcsHJs0ZgQkSV5rmGN6/7gskivX25qple1w5fe44hsw4Gi
	 BVajw1+jeIeMKGGACx1n9GTl4CmeyU5AzAP+MXVGdHt3fDtIVpxTqglpoq2tKUQ1jT
	 EtIkhVSWHaPHjyibml7DVqudbo8QZzLotiOKDZFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbfC3RaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730826AbfC3RaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:30:13 -0400
Subject: Re: [GIT PULL] ACPI fix for v5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553967012;
        bh=K4Nlba/ZRDYxrLQyHZ/DEMKkwY6BDuJdfp7dxoJBh00=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eGfyTMlbnWCdND/t5d3LmhMcETCvO2fQS8yNt7BhVNqMOm8ZBamqhwMnBNiyAYS1a
         JhJahFJwQ2qCnuOy5v6SKlOQwfJ0T3UAlvaSYSUexdEeWIoXaLRtJqG301KP0qO0K+
         yNSaGvAjRfDhr1k6Now1LL6fGZx/XWVDoJcBt55U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hx5EMHeJoS+OZDpg+vU3LVxX7gn3Jo4gbFB7Hyh3Kq4w@mail.gmail.com>
References: <CAJZ5v0hx5EMHeJoS+OZDpg+vU3LVxX7gn3Jo4gbFB7Hyh3Kq4w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hx5EMHeJoS+OZDpg+vU3LVxX7gn3Jo4gbFB7Hyh3Kq4w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
 acpi-5.1-rc3
X-PR-Tracked-Commit-Id: aa9aaa4d61c0048d3faad056893cd7860bbc084c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 782492a7a4807317319a0b1832594d07ba79747d
Message-Id: <155396701236.21865.1741201696706265127.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Mar 2019 17:30:12 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Mar 2019 01:38:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/782492a7a4807317319a0b1832594d07ba79747d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
