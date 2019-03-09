Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCEBC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3D8206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552161347;
	bh=TJNLzf1JJklhMSCGhaawFyQaZ5PADOUqsN5eKWxgWXs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=He232tSPHli6s578+eD1t8RuaTZvaBYFOhXoMVb4PjpL9J5SoFpiceDJO4DPU+eR/
	 NA4C4mYumjeW88e5DkCPl259Ss6bDqNfEg4Omrv7cLt6a/mJWisCN5H1mBSHcR4qQ4
	 qVJbjcB9N7qOq0G2NqDWUaD96aSsneu7maUBRUMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfCITzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbfCITzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:55:19 -0500
Subject: Re: [GIT PULL] Kselftest update for Linux 5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552161318;
        bh=TJNLzf1JJklhMSCGhaawFyQaZ5PADOUqsN5eKWxgWXs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hANH9BhcyTxtcmTlLOdgsJZr0bV/RIzz3DTOZYXlJ3i3gasCzBPExzQRDqxMpoQjB
         edahZMyE+5+/as1fAL91BiBlHehlLS+QIwYERaeRVFqIAgr9bGSoB7zDiPvKi1ZDOe
         C4O4u1vzyxVjzjlfNbgxB7t895phyB2eoZnWcd5g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0935afa2-ad88-0db9-ca68-1b99544b8397@kernel.org>
References: <0935afa2-ad88-0db9-ca68-1b99544b8397@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <0935afa2-ad88-0db9-ca68-1b99544b8397@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
 tags/linux-kselftest-5.1-rc1
X-PR-Tracked-Commit-Id: 0e27ded1159f62ab1a4e723796246bd5b1793b93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a448c643bc49f14bb3aae68ee7085b4c7f6207d8
Message-Id: <155216131852.23333.14701600345076874170.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Mar 2019 19:55:18 +0000
To:     shuah <shuah@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Mar 2019 14:04:20 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a448c643bc49f14bb3aae68ee7085b4c7f6207d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
