Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFAAC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910D420863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 19:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551556505;
	bh=fPtnNYupvu0/R0mg8AnA9biJ9736EUGbR6uaKtqZrjA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=PpocwhUpWeif+E6Dbw05cRSqPxd6tDW7twxBGicD1EafysLCcM1VHYw6jsI03ysYi
	 c40jlTCaCYHa07swsQ88P7sBlLi2m2VKh7+pBSnTClN0jJWjQxjUSPN+ExZaZdFQjK
	 p/sF+/PBz+zjwv2UxYgwVQQVWoxv0CThWhjn5jeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfCBTzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 14:55:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfCBTzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 14:55:03 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.0-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551556502;
        bh=fPtnNYupvu0/R0mg8AnA9biJ9736EUGbR6uaKtqZrjA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kmKyIoo8dXvGmnPpV8v4AnmUiBBLmYq3e5aJIQBV+xv5kBF4IjjxhOx3fUUqS7cBp
         YLN4tXdUMwOWAzOfB0NQapujCDcJkcAtpCzzeCrkPpWBdPLGNDNw47j5W7fRR9Z97z
         USASf98vhbQFfl8l7H0E36RdZMJdytvEMO3EhiuY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1551541788.5893.6.camel@HansenPartnership.com>
References: <1551541788.5893.6.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1551541788.5893.6.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 388b4e6a00bb3097278ed1648ac5a1cb48c894e6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df49fd0ff83a0c20c5ce68a790a4f43601ecdc4a
Message-Id: <155155650278.16810.10212351166552762952.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Mar 2019 19:55:02 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 02 Mar 2019 07:49:48 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df49fd0ff83a0c20c5ce68a790a4f43601ecdc4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
