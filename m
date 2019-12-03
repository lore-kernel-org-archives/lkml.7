Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5034C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D3320661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575407125;
	bh=AlwLDPItj/QAwn+eT1jJUm7hNUdk601hVz1T2nPvZVo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=XLkHqg0EW2WNUhV1kg7CEMOZv2o+EOAvEvcm1mLLFaWDwpeL0lWIbs8n7dgkRcdUQ
	 9a4TGOLtAkGF8Gbf0B4WpejgHSd+cWRL2I7GTB1P5z/IPCdLqQ6IzkQkkOzMl3MPXH
	 RKNbGkFirZ85W0NJG2LhJ4bJBspNZ+kDlzK+pjP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfLCVFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:05:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfLCVFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:05:22 -0500
Subject: Re: [GIT PULL] s390 patches for the 5.5 merge window #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575407121;
        bh=AlwLDPItj/QAwn+eT1jJUm7hNUdk601hVz1T2nPvZVo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qam6KeR3isIQQIm2wV5ENZ0xN/7towfuAig2DwzLOQL0C/h6eyYN+sF/+HFmB7AX3
         v9qD9kvgP55oqPG0LYhJCuU7gnue3FQyZ4LL9qoJMOQLflQAMED39A3WzLJN5nWiZD
         4urscaMPQBypDkANZWo8UbOYIHexT43FZ3ISj4Mo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01575376349-ext-1325@work.hours>
References: <your-ad-here.call-01575376349-ext-1325@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01575376349-ext-1325@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
 tags/s390-5.5-2
X-PR-Tracked-Commit-Id: 2115fbf7210bd053ba55a95e7ebc366df41aa9cf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01d1dff64662646023482806c6db8ef0b280c403
Message-Id: <157540712144.31207.5722570862214097444.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 21:05:21 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Dec 2019 13:32:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01d1dff64662646023482806c6db8ef0b280c403

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
