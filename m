Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9AD2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555523406;
	bh=LFwuDlVPGADvtsgfuibUqCSUbDJMXlFc83CnCStxTKM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Mvd8XoQbfkWk0JBemcsV0P0ICjHNsAslmt370CgH/g9tP/1APSrkSjlf4y6uZJhox
	 OFok1q859hHuqZ58iJDC98/9ZdDxy3e7a5NhZ388DGQt3qDeTDOnEQc293cWeqqKzC
	 vRvTedPnrDSBKvU8KOnPplHmKMoo5odb5asTCuuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfDQRuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733109AbfDQRuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:50:04 -0400
Subject: Re: [GIT PULL] IPMI serious bugfixes for 5.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555523404;
        bh=LFwuDlVPGADvtsgfuibUqCSUbDJMXlFc83CnCStxTKM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=phhcoj0bd67HEschtYsAH34Ncqh7E3G32j2wCP4ykt0ahMmd/1YcdP7D81XVjvVdT
         z4JB9XjvxGh8PnnxrAPXuNy12/n+8OG6+nF8Sg82ZOJjZgRqoR5I2kSFFPnjiSdim5
         jV8jwCdPO/yP8x/3ZY6YAErxTBDeBQHcVFqWmTw8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190417154654.GL4121@minyard.net>
References: <20190417154654.GL4121@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190417154654.GL4121@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git
 tags/for-linus-5.1-2
X-PR-Tracked-Commit-Id: 3b9a907223d7f6b9d1dadea29436842ae9bcd76d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe5cdef29e41c8bda8cd1a11545e7c6bfe25570e
Message-Id: <155552340406.18419.13447767487971596344.pr-tracker-bot@kernel.org>
Date:   Wed, 17 Apr 2019 17:50:04 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 17 Apr 2019 10:46:54 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe5cdef29e41c8bda8cd1a11545e7c6bfe25570e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
