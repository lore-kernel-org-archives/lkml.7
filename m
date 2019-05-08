Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417E1C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E0C21530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557359414;
	bh=RWOrWrWmi3h+shzPZp8fyicG/IPv7uSrE7wtofsLBKo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=N2IoKUbxk9klkPUNz2koYFvZ1ssdJcYrJYpJTFq1qtb5RsDrlOSFOtBK+ezVDu8K7
	 e50RiKnpQJrqCUQDCH9JR3dkzpgNHj5EhTQlFxHRZhGjX3F0nvVXEF3B6ftvB3Hlea
	 2K9+/qwvZmnc/mNJa6SiCebaFQvr/ggbnbzFcpjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfEHXuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 19:50:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfEHXuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:50:12 -0400
Subject: Re: [GIT PULL] MIPS changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557359412;
        bh=RWOrWrWmi3h+shzPZp8fyicG/IPv7uSrE7wtofsLBKo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1iWqBi7U9yeFI8ByeoeiEsFNQCc6VCSIGw5YAcX8EmH57VYQOiP7vhiyOTYXOTDYZ
         6Msh8G6gnDjWktcPLChx9ZuaPWvVHZlKYPTLJ2H+HA+9YNZiMwAd4ztJmUN6iPQpIq
         Wqppi1EYwJWT4U7EnPM49zrP8XzfdmEYZzfDxgGs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190508210444.vxnmbd2sdluubjdy@pburton-laptop>
References: <20190508210444.vxnmbd2sdluubjdy@pburton-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190508210444.vxnmbd2sdluubjdy@pburton-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.2
X-PR-Tracked-Commit-Id: 3751cbda8f223549d7ea28803cbec8ac87e43ed2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92fab77b6b309dc219b02da4a69ad5dc76f7ec74
Message-Id: <155735941195.32517.3108513884819567716.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 23:50:11 +0000
To:     Paul Burton <paul.burton@mips.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 May 2019 21:04:46 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92fab77b6b309dc219b02da4a69ad5dc76f7ec74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
