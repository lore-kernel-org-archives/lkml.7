Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E75EC28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5933926D1D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559323516;
	bh=AEzvWjXir+2Dk0leM7N37RhArXjppArK6Z97VxmT6H4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=thBVY68JCF7UWgEQ5CevVBjAHbwFDgBSgjEIjETj5duepEmw+P/iDQcl6X/qwAuKw
	 XnJ2Trd/DIq29Ob0GRi4I94wp4FY7nMti+c/IjqANLqlGx5w13qrtcG9cv2o5cCZKy
	 divxo5JFsIonBEXltulB9YpGJDvuQQ0KMOq84g0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfEaRZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbfEaRZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:25:14 -0400
Subject: Re: [GIT PULL] USB fixes for 5.2-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559323513;
        bh=AEzvWjXir+2Dk0leM7N37RhArXjppArK6Z97VxmT6H4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=04JYd7tXQ9tqNh5EC7+5emHfPy90wDVCNAhqP6nOL+Md+vVAV99tFtLNtuSxFNF1z
         zMd9nd9R4PN5+gzbf1lAlc5NLnwMVkrgYkEN1R3kE4eEuxmd5XXXM+hFgm1jR22HMC
         lKBftCzTsxoY9VaL9kdyrYgsVaVEzPv84cmLxYTY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190531014637.GA30613@kroah.com>
References: <20190531014637.GA30613@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190531014637.GA30613@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc3
X-PR-Tracked-Commit-Id: 3ea3091f1bd8586125848c62be295910e9802af0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e49c8547fb940982a04c98377bf5468a3b4a3fd4
Message-Id: <155932351392.8550.1230418185782239205.pr-tracker-bot@kernel.org>
Date:   Fri, 31 May 2019 17:25:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 May 2019 18:46:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e49c8547fb940982a04c98377bf5468a3b4a3fd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
