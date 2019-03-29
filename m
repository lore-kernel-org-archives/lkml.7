Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD2BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75742218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553897726;
	bh=VQZOZp0LPIe4Q/sHuXJNP3E6PaamZ6EoyByh41Bfnig=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kjltMHulzx58ttHQ1Tea0EJQlzJcyAn1McoT8B8IJcjbEG1HgTih8i96biEq8+Ciu
	 TbW6U9nQ/VAre1qEpepzFBzNn77edigl1KYurfHtWrIuagITxQoZCe4yHoUY3cKnbR
	 ozTuVJxkw71PmkrnMpEd+13OXlDBFGRf75+SKzjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbfC2WPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730521AbfC2WPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:15:14 -0400
Subject: Re: [GIT PULL] Driver core fixes for 5.1-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553897713;
        bh=VQZOZp0LPIe4Q/sHuXJNP3E6PaamZ6EoyByh41Bfnig=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1w5bjyzGGf4l9sHnWJZxgx+bgOd9Yc7ELLXQ3HHXUEugFD1ugTFG9AXqpQn5qIgJP
         yvHvT/t9xHcvWyTmo8Ntw2u0cQQCMgKvYgpwOG2MYbvxaD27cYSDwQkeSPGw42O+En
         yxM1r134ostIlUOrW2A0ga9UwMgls3c05dcnlRi8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190329193944.GA11609@kroah.com>
References: <20190329193944.GA11609@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190329193944.GA11609@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.1-rc3
X-PR-Tracked-Commit-Id: cd1b772d4881d1cd15b90ec17aab9ac7950e8850
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eed4897dfe8a9743c998ebb57f86e146864ffa94
Message-Id: <155389771357.19616.2727508053911954005.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 22:15:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 20:39:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eed4897dfe8a9743c998ebb57f86e146864ffa94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
