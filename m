Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C95C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C152468B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576443017;
	bh=OXpOcNiD+2AL9P1jkhC2EdJutGC5Ab/+u4IOFlrYP6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=mG8HMus51Pkyiku3OI2Hn0M+o0hHRBuwpnx4tfR6EhxQEHVTwy115xcbX9jyQqXyT
	 RQHTLaupj1KLx1mk93PL3CDJHRff8bpWkxmtsEfB2dp08xtwEqmH4aVSeLg4c0XNO2
	 iTiCIwVlrAO99mP/ho6I5jxjmZ7rU4WUEcAo7Q/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfLOUuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfLOUuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:50:14 -0500
Subject: Re: [GIT PULL] RISC-V updates for v5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576443013;
        bh=OXpOcNiD+2AL9P1jkhC2EdJutGC5Ab/+u4IOFlrYP6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mpR4cS34PkT0VeM83sHkWFb56husVb8L6OPfW2TKKdogUdEW9ScWEqx2/aB0vnqLd
         YAM/sukoruXM9QukPZn03EtS3ZFAaV9rMH8wkDlu9L3APDI6aV1nPn2G41tC636SRT
         DNBBkuNEGaOVwt8V0DqdeiKAO++vincTZkH4vZ+o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1912151208120.91169@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1912151208120.91169@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1912151208120.91169@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.5-rc2
X-PR-Tracked-Commit-Id: bc3e8f5d42d5cfac3f7ac9b458c2eeb02e8b1cf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1522d9da40bdfe502c91163e6d769332897201fa
Message-Id: <157644301387.32474.4144085813869838879.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Dec 2019 20:50:13 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Dec 2019 12:10:34 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1522d9da40bdfe502c91163e6d769332897201fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
