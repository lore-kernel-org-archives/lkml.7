Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EC5C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B297B214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576361117;
	bh=q/R+NMMKXMDezjZ6ZdJEj4Eom7ojsej7tNeS1Jrlkew=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=QolYGUktQ/F2nMvW2T3er7nCH5HUAB9oZGDmHq8AKZCP8IWl/H1YBXpCJKmkqNZjP
	 kClsF1ekS8oF4s7d732hPOHbQwQIl+lUfugc9nMI5GVnnfdpswaM+75x0jmtDOxmUN
	 jdIwhmyy0g8YBvZZn5ZCPfgoaJhR3+GqpNDauks0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfLNWFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:44942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbfLNWFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:05:15 -0500
Subject: Re: [GIT PULL] USB fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576361114;
        bh=q/R+NMMKXMDezjZ6ZdJEj4Eom7ojsej7tNeS1Jrlkew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AeEL1Ak8L1jwXeWZZnP/99bPj6TDZ4Ybx4Vq5N06FDI5hC6/GYI3SlOOZiAfttXhY
         LTanarpMMimdrWQicqONNrvCiLXsOx8YOrrnpWHOrCPhwhfmBLbeYouU7xu6EbCCLM
         ilZph7wYLfPk0koUg8Bq+IF0g+emhvzhViByFuVg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191214152712.GA3459916@kroah.com>
References: <20191214152712.GA3459916@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191214152712.GA3459916@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc2
X-PR-Tracked-Commit-Id: 3c3caae4cd6e122472efcf64759ff6392fb6bce2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1b85b3bf9f9922bdc1428cd2ac4528786a05da7
Message-Id: <157636111493.10255.8314917323496068827.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Dec 2019 22:05:14 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Dec 2019 16:27:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1b85b3bf9f9922bdc1428cd2ac4528786a05da7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
