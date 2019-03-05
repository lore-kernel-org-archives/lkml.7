Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E0DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B4C2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551757205;
	bh=GyjC17H3OTmgKWC6sMB1720lR+IVaaHwLRqyVKWX4RU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=c7iup3D1+yBGAgdLuzgyjT6TeEcu0Dok/OArCK7wnadpBQmmbR39FJHsBFOAoP8rx
	 aMFXCeDwK5v+CEjELvmY3KO3QwuXvvmxDQVQjvxAVMo001V2jIOO328chxK6Z9JOBc
	 znS1QVHX45R65CCD9jNM6cIxdliXkFgqNdGQOG/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfCEDkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbfCEDkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:40:03 -0500
Subject: Re: [GIT PULL] VFIO updates for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551757203;
        bh=GyjC17H3OTmgKWC6sMB1720lR+IVaaHwLRqyVKWX4RU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z0uf/o/PgSRsgTwGF54LYGOrhN67KvKPxSw3BGb8TNgmx1ugj1eS5ukzzDLIvHCDz
         OA0zaFZWOiwCYxIhjHyf71pZgWofh+oYLoRLHS2kxcxR/AM2X4XtkE8uMoNH+1wEij
         wxFUaMYq8EByse0SuG4mpWFT7IVCiwbfBcNcVgTU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190222152546.5b95bb65@x1.home>
References: <20190222152546.5b95bb65@x1.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190222152546.5b95bb65@x1.home>
X-PR-Tracked-Remote: git://github.com/awilliam/linux-vfio.git
 tags/vfio-v5.1-rc1
X-PR-Tracked-Commit-Id: 0cfd027be1d6def4a462cdc180c055143af24069
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a83b04232cec52a8a93700ab7f17a09500c558b8
Message-Id: <155175720308.14960.9138789413084259389.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Mar 2019 03:40:03 +0000
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Feb 2019 15:25:46 -0700:

> git://github.com/awilliam/linux-vfio.git tags/vfio-v5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a83b04232cec52a8a93700ab7f17a09500c558b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
