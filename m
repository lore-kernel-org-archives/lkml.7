Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA91C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B9C20840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551909614;
	bh=S1jgJp/hIy4+XoBrsDGo6saO5QWo45bCcfi5Q6I692Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=G/9HjJbeM8DYlGYiqnIQOgP50z2aWL4hYoncVZj9ZwPJfQIXhHAK0gpTwRvXLecxw
	 3HagpNlyfZ0ZisaJ5MzU14o2YXrUakvoyA6thP7AWmou0iQOHWCCFMkU49yspMWyTz
	 eaOUTbdEjnijA8FEOn+y1Qb83WwVnhaCz6jFw3pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCFWAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:00:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCFWAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:00:12 -0500
Subject: Re: [GIT PULL] Power management updates for v5.1-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551909612;
        bh=S1jgJp/hIy4+XoBrsDGo6saO5QWo45bCcfi5Q6I692Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=jkZROecmkOpaatqb0PrPU3pdqFvt/Bz/DTCRwHOIasr/PzKqfE8uw5RB32nG/nLyH
         HDXNqU5ccAMtjeSakuz0pighu7uxQmUuO9sv3bRm8klC8RRjXlpCod/PZLgN1LQ64Q
         6IGVNgAqZyQL5hFWF0zgAqRNxvyOP9/ky/LEc70E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jAtF5mdu1-_Wt3SbmL3zhXpJY2byPuryvRmCaJgtcuLA@mail.gmail.com>
References: <CAJZ5v0jAtF5mdu1-_Wt3SbmL3zhXpJY2byPuryvRmCaJgtcuLA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jAtF5mdu1-_Wt3SbmL3zhXpJY2byPuryvRmCaJgtcuLA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.1-rc1
X-PR-Tracked-Commit-Id: 1271d6d576b7e7c80519de211f250cfd4eebca1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef8006846a3a97d9d8bf49e63dba948d0d2dbbf0
Message-Id: <155190961208.11982.4441856239784560964.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Mar 2019 22:00:12 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 Mar 2019 14:21:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-5.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef8006846a3a97d9d8bf49e63dba948d0d2dbbf0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
