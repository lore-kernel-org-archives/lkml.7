Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72795C17443
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 17:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4901520659
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 17:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573319705;
	bh=l8Qz4TeFD2IPuMPkfLjqZ1WZ0pu3NSHbQU9hFvJUYqE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=gqo1GZY12lgTDSE5UyCwpGXqBNG8yKNP1O5mzin3CWgHnsgPapuoiAgmBwRsZPFXZ
	 wlllchW4wBsxVo31sU/t9QFCmFWbqXErA5eKv6rXHlmzLGxy13Y4d+HHkLTlQkpdZf
	 SfRX4EJzOIlxfsFr+e4FC3iJQkOzozCsgAOezDmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfKIRPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 12:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:43242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbfKIRPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 12:15:03 -0500
Subject: Re: [GIT PULL REQUEST] watchdog - v5.4-rc7 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573319703;
        bh=l8Qz4TeFD2IPuMPkfLjqZ1WZ0pu3NSHbQU9hFvJUYqE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TPMaKKJ5QP38WV7FshPWhdS3cEBLGoyDqkNf5QTIzAXd+9tkD1QlAbyeg3SZz+Wn0
         Dd5q4Nk1P5isksJh/ik9y2XlzXEmIPPuqZOXhr9dRhPgGGKq0HbbD3R4RvnVLeBl/u
         x8N1rh+OYXAOtza9h1SFO5LyanlZyziRf3QxNNkg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191109095443.GA21465@www.linux-watchdog.org>
References: <20191109095443.GA21465@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191109095443.GA21465@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git
 tags/linux-watchdog-5.4-rc7
X-PR-Tracked-Commit-Id: 81363f248aecd2b5f10547af268a4dfaf8963489
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aba1a7ed563d1c0b153377f57f4d213776ea573
Message-Id: <157331970304.2485.631414306561377626.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Nov 2019 17:15:03 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Nov 2019 10:54:43 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-5.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aba1a7ed563d1c0b153377f57f4d213776ea573

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
