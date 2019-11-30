Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F51CC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E055C20833
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 23:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575155105;
	bh=w2QmLYJyGTcRLFfPhu0LjCJ6dHaswB2M5Ccpys7AjcQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=r0Czg91V1k2/g0Qq0YDQogCWWRkb7DWlOuDtaZGnlJy4VxnVIPxjptyHau81WKUOx
	 BNv/IDm+EJJTLZGrjfg3pGfSs0hF4qW988vKDoeX+wM3pMu8bDMiLvc7KMgTfAFCfz
	 NPtA2kPhsSOtNTuS1MmyMMS5PXWanm/nmyajbonA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfK3XFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 18:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfK3XFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 18:05:03 -0500
Subject: Re: [GIT PULL] pipe: Notification queue preparation
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575155102;
        bh=w2QmLYJyGTcRLFfPhu0LjCJ6dHaswB2M5Ccpys7AjcQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qy+ZYiX68zRepv8cYALiXn55172AR/2ESXosXG8XcwR5AZ1RkFbyJPrA23YRVRFaz
         J5XvLfnT9dON5hezMp8NkDcn5zQCAw4akUrhJ4bitGjvoqPAc6lFqeUUxwVoEj1zzb
         Vsyv2zpQmGmB/Yp+0f6fLoRfnI5MOssGxVOysHwU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <31452.1574721589@warthog.procyon.org.uk>
References: <31452.1574721589@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <31452.1574721589@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/notifications-pipe-prep-20191115
X-PR-Tracked-Commit-Id: 3c0edea9b29f9be6c093f236f762202b30ac9431
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a965666b7e7475c2f8c8e724703db58b8a8a445
Message-Id: <157515510281.27985.4081388238466676103.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 23:05:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 22:39:49 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/notifications-pipe-prep-20191115

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a965666b7e7475c2f8c8e724703db58b8a8a445

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
