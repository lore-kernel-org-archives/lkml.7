Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2318120684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551921619;
	bh=EYu62R8Rmm4clI3/k/dCLQNKVe6bpkgfCRfy1gh0/SM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=DUwAhiWe2EbPLslZSZOs2NMfkvd14Fstj3PLV+JUIm2xkWNYPNKnZgJonEm35assV
	 Aq6esX28KbHmzTKQRGsUUmtikeW0j8nCqnw4t6/VnN4yyfzKSqitPCN5CGHWXh47Rr
	 gGZ34JoANG3hpfP3X7gpXAHEUJPMHODdFLAavT/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCGBUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbfCGBUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:20:16 -0500
Subject: Re: [GIT PULL] Driver core patches for 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551921616;
        bh=EYu62R8Rmm4clI3/k/dCLQNKVe6bpkgfCRfy1gh0/SM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t1uexovAwreLMK9K4lpZi1dIwdHUGgSLYnkTTQuHh8UUwMtcE9EE7Ru+azU4C5y03
         +I3ODsFkENPEaIN10/hmETuLVkHSDpXLcAxa176pKG0eGuF6/2npnUAtgiaGJhBdFW
         N0yAyJYA5xmOoX2K0Mcc+ObNNNDi7XTVUTCLAg4k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190306103350.GA10570@kroah.com>
References: <20190306103350.GA10570@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190306103350.GA10570@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 tags/driver-core-5.1-rc1
X-PR-Tracked-Commit-Id: 36cf3b1363f464c40f6ce647d3ac0ae9617d5fbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e431f2d74e1b91e00e71e97cadcadffc4cda8a9b
Message-Id: <155192161636.31671.4585897793543157466.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Mar 2019 01:20:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 11:33:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e431f2d74e1b91e00e71e97cadcadffc4cda8a9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
