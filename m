Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9955C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 19:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09D920748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 19:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577648108;
	bh=xxYoTET7e/wH3hkJT+fld7Y6Yj0O25w85B8QzOHe9uk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=t4C67+1Rue6lHRtItN3HrN9MQx1ATOuTb7gHyH6ophDOnTXo8DGsaPot1WlviRPNE
	 T4YuqVOq8fQWbghIQhRG94nL4uaVqhnf0JQPNwukzyepr6aVIUDRtCH2FQtWL3cHgE
	 shdK0+1r1wma3xruVNmkojy0EkZd1p0BJKaCynAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfL2TfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 14:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbfL2TfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 14:35:07 -0500
Subject: Re: [GIT PULL] RISC-V updates for v5.5-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577648106;
        bh=xxYoTET7e/wH3hkJT+fld7Y6Yj0O25w85B8QzOHe9uk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Pn8rGdKZCoFeDTDBlXEsoDNd1M6+RNBw0fMpqDuaSGNOQLpp/MJ19tl45oBGh4XSw
         MbvLLkw5oSvvpPaOq4lDT6l2X3mxjjESk2uRrMN44kCxO4s5+4nGVSOVpr9NIPQS69
         nEyWQKnMMA60ndAT12CCIcivPbCDsG37Qpl7LDyw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <alpine.DEB.2.21.9999.1912290921260.204131@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1912290921260.204131@viisi.sifive.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alpine.DEB.2.21.9999.1912290921260.204131@viisi.sifive.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 tags/riscv/for-v5.5-rc4
X-PR-Tracked-Commit-Id: 1833e327a5ea1d1f356fbf6ded0760c9ff4b0594
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a99efa00891b66405ebd25e49868efc701fe1546
Message-Id: <157764810672.31581.14083159610729733661.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Dec 2019 19:35:06 +0000
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     torvalds@linux-foundation.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Dec 2019 09:22:29 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv/for-v5.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a99efa00891b66405ebd25e49868efc701fe1546

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
