Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D62C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9152145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563306022;
	bh=bN+oPIpyG5yQRc1UOp9OsN9wQ+tN14n6Tz0myt6bt4Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BeG2/v0MncTcfzmR99bAKnmzv2eaKcAPJcNrmze5MShQtff0IrxD6WY+a/I2uVUox
	 S032swhaaN0AtnKQrtyx+sRy29OW8lywtYlLZbz9QQ6Xb4973mQlNk464aGeLpK+di
	 u280KS3Gizb/JP4PjZJUnh9N8jeHJVdjK1D6aB1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbfGPTkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:40:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388878AbfGPTkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:40:19 -0400
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563306018;
        bh=bN+oPIpyG5yQRc1UOp9OsN9wQ+tN14n6Tz0myt6bt4Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=znNFF6ILmeJCJCMeqP3N+3aNxIwuCYtneYAhO0BYIY5hcw+Q6yrLl5Pkc7NClIxm4
         CEJOPk40twh5aqH6561PBFvMC5XsPyvAfpe6bXwMqAZPqZjpNyl1Ie9tARpM7KvJbq
         qsIf+UZlmH0zM8hnARZL4TeCSXXt/TBAiJXoftzs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJ-EccPGqp4PmRkFk505QhDKHWn-ajxS0__Nk9VS32jV_+3Y2A@mail.gmail.com>
References: <CAJ-EccPGqp4PmRkFk505QhDKHWn-ajxS0__Nk9VS32jV_+3Y2A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJ-EccPGqp4PmRkFk505QhDKHWn-ajxS0__Nk9VS32jV_+3Y2A@mail.gmail.com>
X-PR-Tracked-Remote: https://github.com/micah-morton/linux.git
 tags/safesetid-5.3
X-PR-Tracked-Commit-Id: e10337daefecb47209fd2af5f4fab0d1a370737f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ec4013bab89058dcc594dfe7b5a20f5d46bbc5f
Message-Id: <156330601855.24987.15351466493711255800.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 19:40:18 +0000
To:     Micah Morton <mortonm@chromium.org>
Cc:     torvalds@linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Jul 2019 09:04:48 -0700:

> https://github.com/micah-morton/linux.git tags/safesetid-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ec4013bab89058dcc594dfe7b5a20f5d46bbc5f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
