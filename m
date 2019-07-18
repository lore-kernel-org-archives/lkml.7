Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ADCC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E12921849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563474627;
	bh=1r3EurQxmmR6M8I1pSPfcCUy90F9rFAi+TAF9Ghmyi4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=HoF5UDA+QHW83XQibY6rIHg+VzKbU3453WfBlAj7zXbKyv5+SVP2fqYJCyEodsr4L
	 M4OhC9Vhxig4cQWKGTEHSSLa1gVogPqu/2mIAWCdYuDxuwxrABJmgBUhHgnwbWLDLW
	 UDF6DXUCgaZUW756f0+PMSTNmhNcIdtDSqiDflx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391276AbfGRSa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391202AbfGRSaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:30:20 -0400
Subject: Re: [GIT PULL] dax for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563474619;
        bh=1r3EurQxmmR6M8I1pSPfcCUy90F9rFAi+TAF9Ghmyi4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aAICNbsVy9WLwJ7dSj7dhKxofmKV90mme2Jc++9KRZEVqHWBkQVEGrQ/R+6EusN1W
         JOTMmwbiliVMOl71oTcgCUgG9qmnYcW+oM7qP4fOVuqfHqJMBrl1cRdXtRmx2eGoXh
         11e8vgtLLr8/SshIRDnDIFkOKz6x+Dom+BWc/JsU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jMjvPYTa00hbq=64LZ=Vcu-gi7hLcgDTnD9d4dF0t9ng@mail.gmail.com>
References: <CAPcyv4jMjvPYTa00hbq=64LZ=Vcu-gi7hLcgDTnD9d4dF0t9ng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jMjvPYTa00hbq=64LZ=Vcu-gi7hLcgDTnD9d4dF0t9ng@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.3
X-PR-Tracked-Commit-Id: 23c84eb7837514e16d79ed6d849b13745e0ce688
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0fe49f70a08d7d25acee3b066a88c654fea26121
Message-Id: <156347461988.12683.5649730008355419191.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 18:30:19 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 07:37:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/dax-for-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0fe49f70a08d7d25acee3b066a88c654fea26121

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
