Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A5AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBF820851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441920;
	bh=YRL+3yXsjxbpg+1zG3QoQsx7tN81Q8VQg2j27pXpieQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ugfS1sIVR5z/CKP2W+w3qdPmmGQ4o1ka36gFz0CdlrSbp7y1MKwHOfLdDVoy5s8R7
	 aSJsopkBtLtqb7wXk5R2LS1qaCAULEIWf4RrGZPBVqUGt+Th3QJzQ2SFgBpy4ti/hn
	 r48HB7t/Z+RDDflcUHjUUa+SaQTP5oTJ8KSulb5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbfFMQFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732591AbfFMQFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:05:09 -0400
Subject: Re: [GIT PULL] HID fixes for 5.2-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560441908;
        bh=YRL+3yXsjxbpg+1zG3QoQsx7tN81Q8VQg2j27pXpieQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=acYjJNVtdGI4LC586P9Xkp0cy6g2N0ExiizGusy12CE27gamsozZENpbuDq//6DGz
         gK8R/mAIeoMMmkgZSjEPhgktEAS3mki4539nm43GaVPTmtAw3l+W/0JpZg4wbzhCF3
         TeM4/LUxrMxdgOZrqOMDKvOxZU/dtmbVESTXcN0U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.1906131632070.27227@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1906131632070.27227@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.1906131632070.27227@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 3ed224e273ac5880eeab4c3043a6b06b0478dd56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c11fb13a117e5a6736481c779cb971249ed96016
Message-Id: <156044190877.6802.10583406698611497279.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jun 2019 16:05:08 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jun 2019 16:37:20 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c11fb13a117e5a6736481c779cb971249ed96016

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
