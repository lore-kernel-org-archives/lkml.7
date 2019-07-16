Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233BFC76191
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 02:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9492080A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 02:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563243016;
	bh=J9n5L+Q9IHtkAgIPApZEMaLKERyM/6PXykpKL5+3IR4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=tTIdJ8+Rd/e53jMJNQAOxY2xQOh7sLOPZBjs9VMbAtny2ee5yvZq6sL+Gvms/vWbe
	 jvBdt6LYeTQ2lw06QiMp0mP9BChB7uWH4JwRfrhm65wGBRdAY0qeFKHHkBVnfwDImB
	 wq4vvbNwM9AsvFy7i/dWPWbi4WJ+nQlAdpeSzPJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfGPCKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 22:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728256AbfGPCKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 22:10:14 -0400
Subject: Re: [git pull] drm pull for 5.3-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563243013;
        bh=J9n5L+Q9IHtkAgIPApZEMaLKERyM/6PXykpKL5+3IR4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l/P9CG4A4RkaLs1tzSJFDI8ecyOMsaiS511OOZYoMhv2Ut7aimVhTl5QoR1opxR4G
         1Jeo61atge01iugYaRUXtTlQGWbS+/KbNbp/KdOacvcyulXHGgFeXgBz4qc4IH1lkg
         HS7E6/QJnARPqgyVDZbXycsjYQ5dv83yfsA8D35w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txxWeKW1VLWNzLEykELmSCqo_kOHBDdJH-cJfAJXZnnuw@mail.gmail.com>
References: <CAPM=9txxWeKW1VLWNzLEykELmSCqo_kOHBDdJH-cJfAJXZnnuw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txxWeKW1VLWNzLEykELmSCqo_kOHBDdJH-cJfAJXZnnuw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm
 drm-next-5.3-backmerge-conflicts
X-PR-Tracked-Commit-Id: 3729fe2bc2a01f4cc1aa88be8f64af06084c87d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be8454afc50f43016ca8b6130d9673bdd0bd56ec
Message-Id: <156324301374.8427.15937802000299539468.pr-tracker-bot@kernel.org>
Date:   Tue, 16 Jul 2019 02:10:13 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Jul 2019 04:37:38 +1000:

> git://anongit.freedesktop.org/drm/drm drm-next-5.3-backmerge-conflicts

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be8454afc50f43016ca8b6130d9673bdd0bd56ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
