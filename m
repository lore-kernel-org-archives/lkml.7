Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EE4C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AEF205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557262230;
	bh=/eJ4iPkqGwzRltB28e5m7CFWD6A3dJ3CHl4MU1c1sHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=OmDHYovrle+3SBSgxpGBKwRxPbaZ/yPrhNTF30M3dNQfvs5bkDMC+rh4eB09CerNV
	 uaTGrUW4XDk5/K9noEjQTlks0RzYi31Z3HiAJEr627xzAhx5m/RgrWDVOnwurwsDZk
	 DnKNXh0L7JQBU1ErY+Ckck3awKEkR3ec0XTQpGBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfEGUu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfEGUuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:50:14 -0400
Subject: Re: [GIT PULL] Driver core patches for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557262213;
        bh=/eJ4iPkqGwzRltB28e5m7CFWD6A3dJ3CHl4MU1c1sHk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J32Xz7RVjU87RvwFXuxVdcaKk/aEUN/0j7NfhzkBfcMcO177Bl7tCeXI51cL073bT
         4ko4QX8SXXVBCyVOw8Y6mj7F2/UrSLWLR4/tgvzlulnZDFzuD+yMHm6VuStJ8rbn1E
         npAlFm7ipHT6cbPpS6stK4zBEDNkypq3YTAdbfSQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190507175912.GA11709@kroah.com>
References: <20190507175912.GA11709@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190507175912.GA11709@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.2-rc1
X-PR-Tracked-Commit-Id: 70e16a620e075cb916644e06012766639b58b2fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf482a49af564a3044de3178ea28f10ad5921b38
Message-Id: <155726221380.25781.2226409672310401217.pr-tracker-bot@kernel.org>
Date:   Tue, 07 May 2019 20:50:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 19:59:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf482a49af564a3044de3178ea28f10ad5921b38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
