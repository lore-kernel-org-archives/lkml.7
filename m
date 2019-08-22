Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6568C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E723402
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566498609;
	bh=Mg43IPyxQgY8DIuetTLTwM+nBK82U9tuabS8PmKxRtQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=wvgFUztmIkEcmH5MgRwTi91D8gAM8LdfjnsPMFBDvS9YQ3Oqcrp+OgQB/r8XF813R
	 r+D412xdv61AFdAMyAGLL89s1lUVOWvfTMy1BepUObcPtx3ViyE12YQTFLo5RhkNos
	 9apS/FLy9Xdaaa6jYO15ahUNYqdPU2ary3XFG1Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390310AbfHVSaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 14:30:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390245AbfHVSaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 14:30:07 -0400
Subject: Re: [GIT PULL] afs: Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566498606;
        bh=Mg43IPyxQgY8DIuetTLTwM+nBK82U9tuabS8PmKxRtQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e7cdRbmVb6MwR1bXWekSjXiwvVFS4+v+mFdLYQpj5TkC7CiRrl6EeqMDOg60k+cKf
         3k2t2niQUVaPRhwzV6YUixUfNrOuvv8a9OjX/TFIN4a+iRbrrulKhAOPuBS72J1p0T
         9Hr5tbyReAnTujcdmSabnQ3qs3Isb4WLRLHD52Vw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <32268.1566479439@warthog.procyon.org.uk>
References: <32268.1566479439@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <32268.1566479439@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20190822
X-PR-Tracked-Commit-Id: 7533be858f5b9a036b9f91556a3ed70786abca8e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8c3fa9f4d3b9c56ee9436c310318a8165d695c1
Message-Id: <156649860661.11049.11048812113160004145.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Aug 2019 18:30:06 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        marc.dionne@auristor.com, yuehaibing@huawei.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Aug 2019 14:10:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20190822

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8c3fa9f4d3b9c56ee9436c310318a8165d695c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
