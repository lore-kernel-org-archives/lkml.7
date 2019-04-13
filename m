Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D021DC10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A04218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555192816;
	bh=jJB0t1ZDtOREiiAJ7cx4jcB26ocP7LVXBe2NEoNqY+0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=BfriLv7V/vrsOMC6PI9udsyrTMRJ84E/4x90obNJztyiSBJtRkIdLGUNoKXxRGC3b
	 cc328bSXNNsyNUORElrtinm4P9n8yxYSHw2iQvmRwkVaOwm+IS10vwRU/jv59Eq1uK
	 +uD+WkhyBOj3a1NonwRv3Q+rbECKuExbxb3RONwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfDMWAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727240AbfDMWAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 18:00:07 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.1-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555192807;
        bh=jJB0t1ZDtOREiiAJ7cx4jcB26ocP7LVXBe2NEoNqY+0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1E3laxgSyhvLB60JHh/yxrs0Uwa1vi5xrxV09lf1aZzleeSVGPWeABtR75u0EfQOz
         zD2ICRJU6Pcgl6EuzXyv2HwLF4KXF9NB+qEECc/5wLs8uDcD7mPHceRWSON0f8QeFW
         ohSJNR6yyO4dSIbtc4R8I1og2SUa/oe4j8KvS8ok=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1555149542.2995.15.camel@HansenPartnership.com>
References: <1555149542.2995.15.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1555149542.2995.15.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 5c2442fd78998af60e13aba506d103f7f43f8701
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87af0c3813570193c6708f6fddbf85178a5bab7e
Message-Id: <155519280710.8399.5367441134897219422.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Apr 2019 22:00:07 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Apr 2019 11:59:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87af0c3813570193c6708f6fddbf85178a5bab7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
