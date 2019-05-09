Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91951C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F994216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557440130;
	bh=FTHlsbqWxjBB9W+pC3r86Q/GMH/LDdFxaDeVqPd/UZg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vxyopAJtWYPpOUY413bevHXsOtzFByRUIy5HlEowDmedcA1n5AXjjvLFsTTnLCO9q
	 nA01BIUrHm2r+nA5U3gCCd1I6yQ7vHqrxGBBq5GdC0CtsH9GntsmxGAkvdWAR2anR/
	 Px4yKkqzMefGmzjypQtF/IpPDQ4LdKHrKUj17V9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfEIWPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfEIWPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:15:16 -0400
Subject: Re: [GIT PULL] Please pull NFS client updates for Linux 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557440116;
        bh=FTHlsbqWxjBB9W+pC3r86Q/GMH/LDdFxaDeVqPd/UZg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qtHHepnOvzhiHEtrFbVARSwGpkLxiyU3/x+q9lt6y7qdpA9Cze62NUqom49evwPye
         kIBTTzJKdVdiOWJQzn21Ly8tRPuTXyvDGPY7zkcoUMv6dhCZU/WmYGNyPMqowcVxmP
         jFHcXeDqkLPV4Qt76QQbx2XRfEawql0hl2SkU1Gg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b5c0559d5646a6c97c96567a94f94f88804b8f48.camel@netapp.com>
References: <b5c0559d5646a6c97c96567a94f94f88804b8f48.camel@netapp.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b5c0559d5646a6c97c96567a94f94f88804b8f48.camel@netapp.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 tags/nfs-for-5.2-1
X-PR-Tracked-Commit-Id: 5940d1cf9f42f67e9cc3f7df9eda39f5888d6e9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06cbd26d312edfe4a83ff541c23f8f866265eb24
Message-Id: <155744011645.23477.16243654197706861789.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 22:15:16 +0000
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.linux.org" <linux-nfs@vger.linux.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 20:37:00 +0000:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.2-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06cbd26d312edfe4a83ff541c23f8f866265eb24

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
