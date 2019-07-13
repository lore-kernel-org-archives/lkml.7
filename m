Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FBFC31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 23:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8600E20838
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 23:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563059726;
	bh=9JBOotczWgZpK5tseRn08nHfizYrttK15HHA84w7ymM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wbl4O8LA1CZOKTcTYL0FEpn2W1opc5dXewIpM2SQTf8sB09tFoFqFSEKaiJ0kcasH
	 RFMs0a4eifKYkXoZLI1/37LIclqhVsLwc+/gByoZCoVDwzJ8pjnlBe2K3G4be2EKbe
	 vU3p/KF5ZkMIPI7JcO50BtVN5eFrDjtUjM20/Z+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfGMXPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 19:15:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbfGMXPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 19:15:16 -0400
Subject: Re: [GIT] Sparc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563059716;
        bh=9JBOotczWgZpK5tseRn08nHfizYrttK15HHA84w7ymM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a5APnUYut9XEHy6LTRhejBi02YJx7OO40MVah99ruPIULQEkOk9O9EwBGoqh4PxhE
         7DdbPTflV5LviAFOOwyYE2Z4Ygj6P3t20dRFLTOZ3UZTLjx/io8ukcof5PsONT57ox
         Vjek6+fX2xkZa1+Gj74U4AvJoPVVB0Ks/uTuLTeo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712.231742.1744524168822613248.davem@davemloft.net>
References: <20190712.231742.1744524168822613248.davem@davemloft.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712.231742.1744524168822613248.davem@davemloft.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
 refs/heads/master
X-PR-Tracked-Commit-Id: 61daf52c4ddd433924687850fa04ed85c0d806dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec9249752465b87b5b26d03f476eebaf872ebd12
Message-Id: <156305971620.4281.13657812831041025401.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 23:15:16 +0000
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 23:17:42 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec9249752465b87b5b26d03f476eebaf872ebd12

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
