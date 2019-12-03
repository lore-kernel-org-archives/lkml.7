Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A32C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08F820661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 21:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575407128;
	bh=NHjNFrsf8Q5MKSY7r5InJ7NWvT7DmWFHDV5KW0y3SS8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=MNH/Q/uXR9lg+A9LwyRjCN33cO0jg7HnLYUKBbsFTmLYyTNDk4/Nd98xPZUqyAhQJ
	 DXvluzF2c5+mkUaAQWUGTw1zY85KMdk59vhgTj5ieag5Ca5GOhc4JRBUHGo0yaBMXe
	 DVQ2W14iL3nTJUT1wq87WJRdPtfo0dtJzt4quBVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfLCVF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 16:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727682AbfLCVFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 16:05:24 -0500
Subject: Re: [GIT PULL] apparmor updates for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575407124;
        bh=NHjNFrsf8Q5MKSY7r5InJ7NWvT7DmWFHDV5KW0y3SS8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LrWAf4Ak5SA88HwZv9bZcTY2zDlPMxcPByJfFO7ILfgcknxJazxC/2lUTnS2Ej1za
         OdtGCqQwFoUyshjKo6hZ7YbRNMNgGMg4FALWRv0dBiI3iH/9KQd4vd7WDCcYcRgX5G
         n8wzsTBmWbNridvzDdJNeKmEGsmV9M1rsGZC6vtk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ab8e6cbb-c46d-41bd-0a0d-43530ee37386@canonical.com>
References: <ab8e6cbb-c46d-41bd-0a0d-43530ee37386@canonical.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ab8e6cbb-c46d-41bd-0a0d-43530ee37386@canonical.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
 tags/apparmor-pr-2019-12-03
X-PR-Tracked-Commit-Id: 341c1fda5e17156619fb71acfc7082b2669b4b72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79e178a57dae819ae724065b47c25720494cc9f2
Message-Id: <157540712396.31207.3965904857120280213.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 21:05:23 +0000
To:     John Johansen <john.johansen@canonical.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Dec 2019 12:33:43 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2019-12-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79e178a57dae819ae724065b47c25720494cc9f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
