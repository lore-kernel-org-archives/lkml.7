Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3916DC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D53C21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562884216;
	bh=qg9MuYAAEKybpD5s5r8MpUip0VUV4OFFZAgr0BLzbis=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=iXOpvT3DDs74PQCAM6MgfnhkvzX4FC5NqsJNpaY6VQR0KoE/LkADmIqwpKKZ24FKn
	 qFgZaM1RbwTaAKAUiNOwG8olOLK4FxVoaAdAYJMDa90v9bqL0zHH5FgKHw/qgtwEc6
	 8ZkP5YCBUygbA5A8qK+IxprE2kREXpLndWv0U+A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfGKWaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfGKWaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:30:10 -0400
Subject: Re: [GIT PULL] hwmon updates for hwmon-for-v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562884209;
        bh=qg9MuYAAEKybpD5s5r8MpUip0VUV4OFFZAgr0BLzbis=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mvQz9Ndl5NIkaD/ImKlZh0k0OiDyEdSmr8etUUODQKO6i4/zmWGDiW6YulOBBbPIO
         5TYBVLYXlvay/UrNk5z2qcuSiHLKV7lAvQszutiUX0Zk3ZOKbOY58BzH0oOATwtM4q
         oQ4fxobC4XZbLbqw9CQZAziHZz5l1Vz2OxrhvdH0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1562696588-26554-1-git-send-email-linux@roeck-us.net>
References: <1562696588-26554-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1562696588-26554-1-git-send-email-linux@roeck-us.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 hwmon-for-v5.3
X-PR-Tracked-Commit-Id: 9f7546570bcb20debfaa97bcf720fa0fcb8fc05a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64b08df460cfdfc2b010263043a057cdd33500ed
Message-Id: <156288420938.10140.5674950479448727944.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 22:30:09 +0000
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  9 Jul 2019 11:23:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64b08df460cfdfc2b010263043a057cdd33500ed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
