Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AF3C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F38208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555600814;
	bh=LvS0sxZqdNgy3XOGEQeOiDRDx8/tOqzXV00yPqNAKTU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=SG9MdGSe9Hma73gg5NfKccCH/DH1r3t1LudJEm9YOSsJJ0iGtpD1WJzl3/h9VjD95
	 sySZlspsNZ/1ISYkZFFDgBn6OeIXgJGmk0qDtpz1462iZQ9Kf4WEiGvB4SiFYLiAvm
	 qOAKIYGypzlM3pqTR9uqfood9aBabiaHhRM9G6eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389601AbfDRPUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389535AbfDRPUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:20:05 -0400
Subject: Re: [GIT PULL] afs: Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555600805;
        bh=LvS0sxZqdNgy3XOGEQeOiDRDx8/tOqzXV00yPqNAKTU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WZIjSWztiQF+p7uNTLt9vqT6ihnnXd5pLEorqxKNWFeEyaQAgvUhos0tAOrZIyi61
         x6oK6wiDQYGzkqR8CmgMvEP3KfwLQGkvwRaOofD9xcAMzqKJal1BOqT1lsOSgWGCwl
         A/wiZoZyt/nrzWmjNukxhMJo36FN901eYu1I4WlA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <26449.1555579052@warthog.procyon.org.uk>
References: <26449.1555579052@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <26449.1555579052@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20190413
X-PR-Tracked-Commit-Id: eeba1e9cf31d064284dd1fa7bd6cfe01395bd03d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a852fd1ac893d75879923025306f146b7e0747e
Message-Id: <155560080497.14770.8198992465427665523.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Apr 2019 15:20:04 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Apr 2019 10:17:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20190413

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a852fd1ac893d75879923025306f146b7e0747e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
