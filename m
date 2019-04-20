Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC3BC282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 20:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5BA217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 20:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555790703;
	bh=qrIdNJC/oNltibNOnxtzw/GA8Mht6VUhk/beXR/fj/8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=zA8lwUNA386NZa2Fope4nP48EQrL/dNcW5dqbiEpRL5ZIqVd+GSvtfiWYjEFNUu/u
	 DvbbvhK8yIK/z4TrA7BJfhKgL7vZnSvA6aMo5XvPfPh385xMV9KL97EJlwedNr2zK0
	 YGpOhb8he2AptnMr+26KMd4k389Y+HjXL+sGeuzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfDTUFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 16:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfDTUFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 16:05:02 -0400
Subject: Re: [GIT PULL] Please pull 1 NFS client bugfix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555790702;
        bh=qrIdNJC/oNltibNOnxtzw/GA8Mht6VUhk/beXR/fj/8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ue0SZUHDyxGLS6mLbdRAfQA4iTFIUoXhuWwte5nTeMGgxiMo0jYJ/pxyooqcQBdns
         RZSq/FVtG6uid7G3O7ianeNFsKRs2OTL910hNEBZy3oqF1S2BdLoRo392smLFjKwj5
         QdfaSmaMPg2eGZSYMMUeFMY+38OZtqs1oCZZ5mWc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bb6e36bd32eb85f32b15edacc9753341641f43fc.camel@hammerspace.com>
References: <bb6e36bd32eb85f32b15edacc9753341641f43fc.camel@hammerspace.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <bb6e36bd32eb85f32b15edacc9753341641f43fc.camel@hammerspace.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/trondmy/linux-nfs.git
 tags/nfs-for-5.1-5
X-PR-Tracked-Commit-Id: a7b1a4839ff979b4dd4fb6c1ccd31af11de9ca87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e5de623a0cb9374bdcc73c0c098818f0d7ab7e9
Message-Id: <155579070217.31475.9063334968196932595.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Apr 2019 20:05:02 +0000
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 20 Apr 2019 19:28:24 +0000:

> git://git.linux-nfs.org/projects/trondmy/linux-nfs.git tags/nfs-for-5.1-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e5de623a0cb9374bdcc73c0c098818f0d7ab7e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
