Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0689C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7725E2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 02:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569293128;
	bh=kiMHv4EzKPXILofZb8wTlzddTjuhxLOOlAcmf8tWLFI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=EKxBbaMO1vX/sikBcxHe6E7NL6v0qsr8Vy8s0uozZJNAEfQBsmsiaoQ+5HLIewt6a
	 d0HN6wXk9eAu3IoQJfFYJ0cwK8JUaPeTMkkYnn9v4XhcSKi49nY3VrkY5r4DaTaXAr
	 Qjnt/eakJdXIXT3llFliawTJSmIXin5Dild9/p7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394445AbfIXCp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 22:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfIXCp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 22:45:26 -0400
Subject: Re: [GIT PULL] MFD for v5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569293126;
        bh=kiMHv4EzKPXILofZb8wTlzddTjuhxLOOlAcmf8tWLFI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GufTxB7nJGMSYaw+rThGxkiPo+V6YJjUgYfP6as6ZjqFWQuncpkoBjKPh1IdPvQpu
         lAc3zJqTzpsR8W9OW9wBpXkC6K/G3XFQdnYrhBPoM6MEjZGxCb/N1pEVWxytQrJFdO
         yf/zwg0CflG4mNViWFivqSBwRoIA5EPmJQPPdIJs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190923230848.GB4469@dell>
References: <20190923230848.GB4469@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190923230848.GB4469@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.4
X-PR-Tracked-Commit-Id: 8391c6cb2414d9a75bbe247a838d28cb0cee77ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c07e2ddab5b6b57dbcb09aedbda1f484d5940cc
Message-Id: <156929312599.18533.6374651945533731208.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 02:45:25 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 00:08:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c07e2ddab5b6b57dbcb09aedbda1f484d5940cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
