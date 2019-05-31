Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB30C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40CB26DBB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559326515;
	bh=WxxqN2+l2q4kLb4f/dh6zmQ2q2vnQ7Xm1Bmt9nZavVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=0XY/PoNbZUS0t3PWGNVP8zUImhpHxokar8b7HzuQdxxWr78YY6sYN809ZSSCpxAGV
	 Wo/moH5j95hce6Q7gpZLhIxClbw2FWngT6x2CdGCE6glwQtAxMm7X6D8YXzG4N+Vu+
	 UsIwGabtwUlfHKZaZJrml+utr+t2pwLNUkELRbgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfEaSPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 14:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfEaSPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 14:15:14 -0400
Subject: Re: [GIT PULL] s390 updates for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559326513;
        bh=WxxqN2+l2q4kLb4f/dh6zmQ2q2vnQ7Xm1Bmt9nZavVA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=SnEG8ZeqXfvuKdlImn1MYj7aD65Ib48woYPHysbE9XcXazCiDj+lRE/tMwMOCrMLB
         HzNl4nJnEd0aLz3xO0z+5yyNZHo1gUx4zvaRC33/Qha7J9Y1GVRCgb3rcMyNvtBBO7
         So4QTxYtjUsEH8Mm7V65y4c1hG1M83OvmWg5Ufkk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190531110750.GA20370@osiris>
References: <20190531110750.GA20370@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190531110750.GA20370@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-3
X-PR-Tracked-Commit-Id: 674459be116955e025d6a5e6142e2d500103de8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27a03b1a71b9adfa7f4ef3f61452fb3bc5b195b1
Message-Id: <155932651394.23368.5840164737650382905.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 18:15:13 +0000
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 31 May 2019 13:07:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27a03b1a71b9adfa7f4ef3f61452fb3bc5b195b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
