Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EFCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4AE20818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573494608;
	bh=6Btq0cANTE9NZDddbWN8HJIM2SdQnv3rmPVHoIJKJzA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tKAu8mY0sGyJk9b2/TcbRl6+SQvSsLfFPt9hWhqHmwjaEeabLV/oh6N2iZGuLbNqy
	 01MMWI2D1Pn7g5VNFPRro7GhMhX4c1bFV/r+aZWNAuVVCvua+PnCkrex6VloU3qbm+
	 Zz5d05cKG+CcgR31LN3/PxIlsx47Q9OMUnA2e+Sg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKKRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:50:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfKKRuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:50:06 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573494606;
        bh=6Btq0cANTE9NZDddbWN8HJIM2SdQnv3rmPVHoIJKJzA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yfwA+7HxVPLWjvW3lrHzmCqcDCDMiydhiQjd7Q86Ft3GrQI/d0BXq5WmUey9ZqbnD
         JzeWyBODmtd0RO6SRBd/lM7cTXGNh3yDTeCvPiVyjr1wMEqOrDA1otFgiwa+NtSqKg
         ZSNyoYdWxBg6rlj+v85q77u1tzy9Atn0zvVN2RLE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1573492117.6865.5.camel@HansenPartnership.com>
References: <1573492117.6865.5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1573492117.6865.5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 9393c8de628cf0968d81a17cc11841e42191e041
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72d5ac679e246c15d94a00d53a6289e142cfcf86
Message-Id: <157349460633.15424.9562738626187318416.pr-tracker-bot@kernel.org>
Date:   Mon, 11 Nov 2019 17:50:06 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 11 Nov 2019 09:08:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72d5ac679e246c15d94a00d53a6289e142cfcf86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
