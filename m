Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D14EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EAD20855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552161341;
	bh=/5yT+XyKWM8cjw9hFQeQHvQz8u3gb8txKA1UbgW3mRI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ByBV7NUjA+FUbvYWEnSq56i2eWayPBSht9oHxKF+r5GAaT6Xe9svnCkGS5t2PAPZS
	 WmDVpMa7/irop38bwnpcmV43zNXFnGLdc9auBUKHTMPcFgoGxyDURV8H8l23kOiqVg
	 J2p2Xm0oYjVnjvDjkxLcSHs2udWpTUGBxzAwMlRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCITzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:55:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726744AbfCITzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:55:19 -0500
Subject: Re: [GIT PULL] leaking_addresses: changes for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552161319;
        bh=/5yT+XyKWM8cjw9hFQeQHvQz8u3gb8txKA1UbgW3mRI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bzubzoiUwiW635vpPbjHUCRXnLwCrcA9GrGGvDO8QmptcxEilM46eXp4kKIJLsUQA
         xouksIyGdrROfvcN/Sn0hBmwRqkFoIHy8aUqI2yOpiNFERTqhd7Ba/nFx7eTisBoSU
         qqvJsBu1ZmfiZPj3eS+JXQFQapdcluimpx/zw81o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190307022522.GA3942@eros.localdomain>
References: <20190307022522.GA3942@eros.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190307022522.GA3942@eros.localdomain>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git
 tags/leaks-5.1-rc1
X-PR-Tracked-Commit-Id: 9ac060a708e054233265f8febfcef009ac3da826
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99b25a7fc6150d613be8eab71a47e6c0fcc8d7c5
Message-Id: <155216131942.23333.12256290409276650618.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 19:55:19 +0000
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Mar 2019 13:25:22 +1100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tobin/leaks.git tags/leaks-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99b25a7fc6150d613be8eab71a47e6c0fcc8d7c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
