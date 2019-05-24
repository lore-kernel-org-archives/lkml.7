Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507F7C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F4221848
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 23:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558739723;
	bh=dWSz4+g/jY1UJuyGYvqzv8BJfXUPGCTRSEnGNcRqVno=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=WSmgkDTolDzhUVHYnPQEKj/4f43mp8XVfcFJ02RsD5L6NyXJBjsA4rLKvbXp6QjDW
	 qdFVygAv9swEAcUT9gCFL1LOjEbfNNmOo/3t7fsHduhQ1str2LnZauTYU6qy1UTW50
	 KGYgjLH5axRrw96USKehJhgGsQ8nJYwqsmHQ4smg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfEXXPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 19:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfEXXPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 19:15:17 -0400
Subject: Re: [GIT PULL] Kselftest fixes update for Linux 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558739717;
        bh=dWSz4+g/jY1UJuyGYvqzv8BJfXUPGCTRSEnGNcRqVno=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OsVjy1wIvxZPIkLdtlN7AAWOliex+v42Gzb2YFPdBI1EwVIgdq5/YuSeBTXdMyfKD
         /OdN8GxGq5dV0q9BfkCjbMzgFED1OgpSfGfJK4sQlWB1FbjY1BPyQFBW/cD4mBXCAU
         QC8CZkUJm289NVmOfmBbmNLHOKcOc5EuEI8qDwgU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <46b8fc51-ac8f-c03d-443e-4bd265cd4527@linuxfoundation.org>
References: <46b8fc51-ac8f-c03d-443e-4bd265cd4527@linuxfoundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <46b8fc51-ac8f-c03d-443e-4bd265cd4527@linuxfoundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.2-rc2
X-PR-Tracked-Commit-Id: fe48319243a626c860fd666ca032daacc2ba84a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f8b40e3dbcd7dbeabe6be8f157376ef0b890e06
Message-Id: <155873971735.4676.15830422826307745956.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 23:15:17 +0000
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     torvalds@linux-foundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tong Bo <bo.tong@intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 15:19:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f8b40e3dbcd7dbeabe6be8f157376ef0b890e06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
