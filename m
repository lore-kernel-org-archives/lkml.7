Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43096ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181582196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570829704;
	bh=9vz4Xxpjz07Krax/K16bG6ZIyQ95TNjzskvI0ZvgMaM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=m5CpOw26rOZkfYkSfp3w90/fA4vwtSdGZsBhzgvYk3kauVfsGHANGF1GegapDH24E
	 urhAmO7D669XXI+GKchFHGNL8LQW/sUqhwtN0gFJk3segk9c2bM8U/YYiIw1ytOrgp
	 7cF+IfyQhyGUkx2EPUVkbvEcP9QgHSegjbnQtQwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfJKVfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfJKVfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 17:35:02 -0400
Subject: Re: [GIT PULL] Please pull NFS Client bugfixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570829702;
        bh=9vz4Xxpjz07Krax/K16bG6ZIyQ95TNjzskvI0ZvgMaM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=M3ATU9zjXv0tA2GmyucK2fKIKZ7Ep319m3V30s3vlmQlU6BgRzLrgLrYAd1wSOSMz
         BaSe/9R0axxf4sum8gF6fTL7xAETKy7PcgzPyZzxJpgPzyhoHmuDp2ZfFaUYE4uYyL
         plglKfgLPuC2tcFFaLQRCGnkc5WTZ2py1u5cuWP8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5e755211af46cd98099145223b8d4929542a8141.camel@netapp.com>
References: <5e755211af46cd98099145223b8d4929542a8141.camel@netapp.com>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <5e755211af46cd98099145223b8d4929542a8141.camel@netapp.com>
X-PR-Tracked-Remote: git://git.linux-nfs.org/projects/anna/linux-nfs.git
 tags/nfs-for-5.4-2
X-PR-Tracked-Commit-Id: af84537dbd1b39505d1f3d8023029b4a59666513
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a
Message-Id: <157082970195.1897.12724883565139279738.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Oct 2019 21:35:01 +0000
To:     "Schumaker, Anna" <Anna.Schumaker@netapp.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Oct 2019 21:14:20 +0000:

> git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c0cc5f1ae5ee5a6913704c0d75a6e99604ee30a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
