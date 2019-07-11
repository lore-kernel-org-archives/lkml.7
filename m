Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413F1C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1974121530
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 05:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562823012;
	bh=w8i0/Tm4LGeP5uAj+0j0eTWM0IvNyPCQwJ1Yufk7zxk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=KDgcMV/iGKfrwmT6YLCc2aN+gN9VGbo8/5vjdBqdzCsfG2pJMaPnzutEa3sTuSe4T
	 tEF05z4JblxmnS49kYxJJ3j5kZO+/yovthMxgx1j2X/UKqm3ifeTNZH1zQhe1xwmm6
	 FY63RD4QIWQxm3JPkJIah5dG5AIl5KrmQkkrnQoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfGKFaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 01:30:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfGKFaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 01:30:09 -0400
Subject: Re: [git pull] m68knommu changes for v5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562823008;
        bh=w8i0/Tm4LGeP5uAj+0j0eTWM0IvNyPCQwJ1Yufk7zxk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R1HkC57928H5yfkS5BRessbeJ+TjBHlGtkISpi5ip7VNm3SN4m2i7aATsAhXElbk+
         JcRsjvxRzmnWcUvNYQIIZv9tiRQ1OoiP2WI3Imi0Je/wu2hlH0KD5RSjhwRBsZnaTs
         T/NTmuL4sZOaagFNWhIxX1J+agzhbp+NV4e08hCk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cf9d62c7-2b47-e234-ee35-2562b125a411@linux-m68k.org>
References: <cf9d62c7-2b47-e234-ee35-2562b125a411@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cf9d62c7-2b47-e234-ee35-2562b125a411@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next
X-PR-Tracked-Commit-Id: ad97f9df0fee4ddc9ef056dda4dcbc6630d9f972
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 398364a35daed7361e76c3666fb9a97792edce09
Message-Id: <156282300838.30654.2457890120180976831.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 05:30:08 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 15:22:09 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git for-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/398364a35daed7361e76c3666fb9a97792edce09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
