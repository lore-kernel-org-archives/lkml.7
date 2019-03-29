Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D767AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECA7218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553897717;
	bh=AkblHpdHHAZNCYJo/C5b8rUclMIGMUEZG+mTmi9K/Zw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=xK7OU0VV2Lmf1txrqLV3yTNof2sVW88//kqLFIO+RudLM4UZhSPhZdZRJf02lTEK2
	 ed8xPVD+utszdUQyqDtiN4Ki5wb5yRNx51OY94M7JFFqY4sjsLPtLoftThFayEEKCo
	 ikSiqtPFLXJDDZiUojyYXs4TBc2rvwVSTy4aWktQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbfC2WPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbfC2WPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:15:13 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.1-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553897712;
        bh=AkblHpdHHAZNCYJo/C5b8rUclMIGMUEZG+mTmi9K/Zw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IZAEpARH+uAktX/dpeeuth0UIqj+5dg/HpJc+UDL0WA7ojRDnFjaKENdN7fbN4hR5
         9e8wB/jVqZxTFjLKYhLdKh0mi8xUx479BfU3D0KXHKMc8DcQukLP+jEMegdSZzVcfX
         xDd2DrJ/nAR9e4zxChz+4wILUAf6aWvZ0+dXAx8k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1553887670.2911.16.camel@HansenPartnership.com>
References: <1553887670.2911.16.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1553887670.2911.16.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: d6e2635b9cf7982102750c5d9e4ba1474afa0981
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3467b90737e1551dbaa5b71fd5a54425fd4a72b2
Message-Id: <155389771259.19616.4315236675175951729.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Mar 2019 22:15:12 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Mar 2019 12:27:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3467b90737e1551dbaa5b71fd5a54425fd4a72b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
