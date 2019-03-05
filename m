Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F770C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0F620652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551814519;
	bh=0drqTKrhrHBAK2UPp6wXWUuKN64D7SPNQiivov2cPJY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XQeQkQR0Kx99ZcoTB1Akdorpxmi4l1DVzhVWhiDcwGZukMZ+EvEXBDz96qO8YqGna
	 t8TQRY+VKnTBHydKKf1bfAi72lzYHUWKguPHCOrwmEfbFMHB7AZmiYG3/N2ytKbkBW
	 TIWlvcAbAjLzY0h3Q7xhiOde/KBEOzpvK+atr3z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfCETfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:35:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCETfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:35:05 -0500
Subject: Re: [GIT PULL] Main MIPS pull request for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551814504;
        bh=0drqTKrhrHBAK2UPp6wXWUuKN64D7SPNQiivov2cPJY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eFXWQCB5T8HDh8t17A5xklbhQ7SgjRze8ml4uA5uvM8m48jG0qpTNKuLohRjaSWn6
         kJmF24z1ydoloxquFBBOA7rCXVi9paItLgzer64zLe8V8Ik+a6YODEqKkyx/KDqMnd
         ODGcs3pvFTxSdZNLfM7fIMFO5YmWYamaIkAGUwFo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190305002951.jdrcgn5jf5xoa5rr@pburton-laptop>
References: <20190305002951.jdrcgn5jf5xoa5rr@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190305002951.jdrcgn5jf5xoa5rr@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.1
X-PR-Tracked-Commit-Id: aeb669d41ffabb91b1542f1f802cb12a989fced0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9862cfbe2099deb83f0e9c1932c91f2d9c50464
Message-Id: <155181450424.15853.4862702803894985068.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 19:35:04 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Mar 2019 00:29:53 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9862cfbe2099deb83f0e9c1932c91f2d9c50464

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
