Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8540C2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE05F206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 20:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576959611;
	bh=QwYZc6ehQHBlSjArD4PkxDCKRQgNYnk0+54I+uASoeo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wubX/qNxy5/RIRjCNCQFG1ZNTthcpAqh0GZw2fv5BOi8qOtlzdaUyCwRBoCLzyVgA
	 SscINeBxMIRDibGzfUMovfYQP77Z6azfpjJTd2v+kX9KeaxB1xGpa52xgjnztV0e/V
	 M0asYwSZmsNplOJx2bMRXtmorb1C+A3+/DIVVtz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfLUUUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 15:20:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfLUUUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 15:20:10 -0500
Subject: Re: [GIT PULL] s390 updates for 5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576959609;
        bh=QwYZc6ehQHBlSjArD4PkxDCKRQgNYnk0+54I+uASoeo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Iw/PqQhDDPKyu/Nelsso9wBgy7+K0SIFCRSSvZh1agb7s70PNY0qRf7m+Lgefma/8
         QMlp6J41ou/xXTnC9S/flVBci5KEoflCLux1qLcAOnr35VN02pZIoQ33/LTXjxmCNt
         OlHtTphqAfQDO9j6eBjMI+geyyDpUanNlPeqWnng=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01576957972-ext-6011@work.hours>
References: <your-ad-here.call-01576957972-ext-6011@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01576957972-ext-6011@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-4
X-PR-Tracked-Commit-Id: b4adfe55915d8363e244e42386d69567db1719b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60b04df6bfbf7e65954c44f7945b381e0fee5b6a
Message-Id: <157695960957.315.3541305310902676791.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Dec 2019 20:20:09 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Dec 2019 20:52:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60b04df6bfbf7e65954c44f7945b381e0fee5b6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
