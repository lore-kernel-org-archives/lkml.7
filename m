Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75811C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5421783
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569354931;
	bh=aOzeBBUyM9Bst5wksrj/uHf5KpJtqVNQE25Nt0GuWoo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=GdMT1TThkvyAhLge6d98+KCYEPkWG/WY7DS5iux2u0myJaQtnlqvm49sZywxClqML
	 fKLZFmG2pFxl3LwXINVkp9OgUEGXneInEPpY2301SklNPQt4bHal55jJD3GXZ7zwhQ
	 FXol1E1jNqWU6g5VQKyDRjqS4tW2Trajb8V7Pwr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633326AbfIXTza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:55:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633248AbfIXTz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:55:27 -0400
Subject: Re: [GIT PULL] arch/microblaze patches for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569354926;
        bh=aOzeBBUyM9Bst5wksrj/uHf5KpJtqVNQE25Nt0GuWoo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QWf5Hv5mBufIK+oX1Uxb/rPcScqKPdLcfPW5ZLENQ++ufgh3aptPSQDeuYvvwdE3M
         jPAmSKhBJbbkSETUDaIR6Z5oS8uszu7XDGnoxrveUbQzwZ0vvUYE9hXt/mcFjOOQfc
         jZ+Ana3gOuy1GCSKQnfxXz8ijqwuVpNusF/VoK8Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <99b0cfb6-0d4a-555b-ebd6-d97f96dfd2c9@monstr.eu>
References: <99b0cfb6-0d4a-555b-ebd6-d97f96dfd2c9@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <99b0cfb6-0d4a-555b-ebd6-d97f96dfd2c9@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git
 tags/microblaze-v5.4-rc1
X-PR-Tracked-Commit-Id: 7cca9b8b7c5bcc56d627851550840586a25aaa1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5184d449600f501a8688069f35c138c6b3bf8b94
Message-Id: <156935492685.15821.9380699824086138096.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Sep 2019 19:55:26 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 11:56:11 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5184d449600f501a8688069f35c138c6b3bf8b94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
