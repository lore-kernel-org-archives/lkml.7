Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126CEC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DF121920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570722306;
	bh=8Za0kk5c9AOHaeLMVd28JQO97jaavnpX48UYHzpnV6I=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=nyhwL+d3Zsv8dBdv2qLGwAVvys/w52PnxObim69H7MWq6BXKUeOLO5wyS4LdKPHUb
	 JQAttpNNJblOyoj7QYQEs8sd/F1dH6EHwInORVuIunPzVGuDTH7H1HF6262/AUFvKv
	 UjpdywWunuFWlxJeSKGAk2aukjtAPeoB7mxE3u5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfJJPpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbfJJPpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:45:04 -0400
Subject: Re: [git pull] dcache_readdir() fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570722304;
        bh=8Za0kk5c9AOHaeLMVd28JQO97jaavnpX48UYHzpnV6I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iSkJBfrey4QJDeumbgWq4IrHnjpVUqUo6VfM5N5RfIbL4hwdtqRKHsaIEgtbIKp7D
         WMIJsRGfAYUU/rR3AK71dDO3cDy0cychlUNRQeRe35YmLaNme7v84UHVTelqsh138k
         qBBOp9DtmbyT1bE5Aet4wDWcYlPXT+ONsNvS4gaY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191010043128.GF26530@ZenIV.linux.org.uk>
References: <20191010043128.GF26530@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191010043128.GF26530@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache
X-PR-Tracked-Commit-Id: 26b6c984338474b7032a3f1ee28e9d7590c225db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad338d05438ec003f90ac7304fbac80ef2d8c80e
Message-Id: <157072230432.27255.3946695199843898319.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Oct 2019 15:45:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Oct 2019 05:31:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.dcache

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad338d05438ec003f90ac7304fbac80ef2d8c80e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
