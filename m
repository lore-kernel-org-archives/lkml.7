Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D1BC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8416220C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565368541;
	bh=Sy1NFzK5II8U4lIrfExT3QawBzTbjsw/rHwqYHNoREg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uDcuPk8rsQMXqIkXNFKVRJdwND2UvwbGEmByjPzQPk9Um10FnSzPu1CsnwBKAojXx
	 ab0t9+t3M8LKPM0Yz76jC1vl3w+J/ykLekBBUBplru98tJXLlNxxC6Me/EDlU6VlYJ
	 L+c2RzsUmp4Q65n99t8xvdgTb8DKk/n0RfRhHo8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437438AbfHIQfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437311AbfHIQfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:35:10 -0400
Subject: Re: [GIT PULL] s390 updates for 5.3-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565368509;
        bh=Sy1NFzK5II8U4lIrfExT3QawBzTbjsw/rHwqYHNoREg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wktlVMh376vcjzy3Zn4mwdmZnSrbWil2FgAn5RVT/XGoYWsGAGcB05Y4jMxSF0DNE
         yDkk1oKNF68asFhjiUfBP0JkrVtBNwomFk86plyl3JO2WLI4UYoiEb3I8+ekXUrX1N
         qxzG7CIR/zpScoe1oL2thFHGiWrz0E5Z2kZPPlk4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01565348470-ext-7484@work.hours>
References: <your-ad-here.call-01565348470-ext-7484@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01565348470-ext-7484@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-5
X-PR-Tracked-Commit-Id: 404861e15b5fa7edbab22400f9174c1a21fde731
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb7ef4bc927233304aeeeb891c1cfc5ad6f87975
Message-Id: <156536850967.6429.3536164448724937140.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Aug 2019 16:35:09 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Aug 2019 13:01:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb7ef4bc927233304aeeeb891c1cfc5ad6f87975

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
