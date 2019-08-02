Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CDCC0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A6F2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564788012;
	bh=rMKBcLDfCGhasRdtm0uRydBPuSC1GDQPEtmka9yAR6o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tkSSOemouQlwqs0UvcGgh/zECFsJ4CkAMFI0EY7Ilf1ulnx9OL8P+f0ZmNVQXRc4h
	 mfH0dDK9J1lJNDrAZxS0JrUN+NWb1moKc0DHqiiDs5Eck4K5AqwpoYVzJibzGrL8eP
	 ViVEoryI55KEA5UuirHMlV/qeSI89M8hWqCHu6Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437459AbfHBXUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437446AbfHBXUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:20:11 -0400
Subject: Re: [GIT PULL] s390 updates for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564788010;
        bh=rMKBcLDfCGhasRdtm0uRydBPuSC1GDQPEtmka9yAR6o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=g9b5/QiUNttj2PhTOseg6MYZHjn0xZ/BYmpsRUG834DlzGeniDCUCNyqlp/xoHpdv
         Ba0ec4x3KbIiUeC1VqcGMQOPK0o488BFKYFNGOLptInWoMTV8Qg5jzVi/0zSz84G+b
         Hd5rYkIwYiz2Fv00w5V4ngQucR1f37lT685bgKDs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01564754888-ext-1592@work.hours>
References: <your-ad-here.call-01564754888-ext-1592@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01564754888-ext-1592@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-4
X-PR-Tracked-Commit-Id: 3cdd98606750a5a1d1c8bcda5b481cb86ed67b3b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dd68199f3ed7ee62f94869a1d7b29749e3696fb
Message-Id: <156478800999.22769.11059158573761622305.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 23:20:09 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Aug 2019 16:08:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dd68199f3ed7ee62f94869a1d7b29749e3696fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
