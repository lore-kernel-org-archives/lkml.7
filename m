Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3024C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8458120823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553788516;
	bh=e3sOxIDh1HK0o/peLFi0dIGaW1BiFEWUf5SINYklbLg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=lnWZo1pGX2UEpkgjsBgCV5zt+q6+Jtyof2JYaRe0Ka4RBqaB5mrC+Nm3+mSWsUfq2
	 4jngoHK+/0ca2HmPkWN7y/Rfp3VLpFvaXEcZ7B71h5M50d6KSdJoGh1LvFXbYRQlMj
	 jLv96uLcIy30WMEtf2GN8MO15SgwnQMYm3qp2X5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfC1PzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfC1PzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:55:13 -0400
Subject: Re: [GIT PULL] s390 patches for 5.1 #2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553788512;
        bh=e3sOxIDh1HK0o/peLFi0dIGaW1BiFEWUf5SINYklbLg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YqdcdcVQo6vCtf3/JHA0jzUt5/smPY7ahcQiFkPy37IfYXcwB9W0OffvNPZXCjnv4
         gINpVy8TzWOB2ktGs5fME/JkhKidTvase9y5zScEu4keLZidqXFWW3Zqgj5y823DMB
         PyxtyT0lzKhOGBXz+3P9CKAFVLgkB1GbLWIUvYq0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190328095544.1930d8c7@mschwideX1>
References: <20190328095544.1930d8c7@mschwideX1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190328095544.1930d8c7@mschwideX1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
 tags/s390-5.1-2
X-PR-Tracked-Commit-Id: b6ffdf27f3d4f1e9af56effe6f86989170d71e95
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfed6d0ffc8dba002312c2641c00ecd3bf9f9cbf
Message-Id: <155378851235.26949.5659386618288556416.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Mar 2019 15:55:12 +0000
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 28 Mar 2019 09:55:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux tags/s390-5.1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfed6d0ffc8dba002312c2641c00ecd3bf9f9cbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
