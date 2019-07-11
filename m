Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B27BC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628E621019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562884233;
	bh=AG4EThfffPFMnyXZhJKocF0ZpIlWJjNJ2tbQs2Eaxms=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BbWz2v1COtuHQBUBefNKBW23Hqeawnws17z+Nqc+OeYd4DL0g37vWaaxGkFhDGy9+
	 wa6mz/PIbKFCqDLPeTZKyVkqy/mID0JU2fB3PlE2s3FHiWVa4Rba3kwVr8foqLuUAz
	 6uPJcu60x7shY0MT61S7eAZ4Fyn59zXuJo12b17c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfGKWac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbfGKWaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:30:10 -0400
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.2+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562884210;
        bh=AG4EThfffPFMnyXZhJKocF0ZpIlWJjNJ2tbQs2Eaxms=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DmKGy+hTkxDra284VjV4+YIp36Ytuil9MQ1kjoXjvsgR90qTEF2TYGW0HbmdRxQqJ
         7I4v3/SAE1wflFjfBQFxUpbOOqpjKypej4HlXz/sR3e2+AMAIrqVRMUeMUcMF355aK
         2iQKgCBz+l2726SMHUGnlzcPE/QreyMtlm92vQX8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1562699693.3362.93.camel@HansenPartnership.com>
References: <1562699693.3362.93.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1562699693.3362.93.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: baf23eddbf2a4ba9bf2bdb342686c71a8042e39b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba6d10ab8014ac10d25ca513352b6665e73b5785
Message-Id: <156288421003.10140.9773404980067834853.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:30:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 09 Jul 2019 12:14:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba6d10ab8014ac10d25ca513352b6665e73b5785

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
