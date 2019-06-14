Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793CEC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506332173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560528910;
	bh=2+K1vZzfZH05W3JJSs2Pul0tXH3bGKmc3kyN/HUe408=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kgnB6b/Yxz7YelkqOmEH+cV+CTn6dH/tiPugwD/8Kf3wUnToDIzMSFILORpRy1wve
	 2g3IwA1Q+UH+6wimYpAG5LJeLFumOEcqVGX+Dxafqzw4PdR3nUBtI+4AbHNFXIE7LV
	 2VyodFSTb57vfPhaUYVYs3utZFxg7JaopFE+PVWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfFNQPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfFNQPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:15:07 -0400
Subject: Re: [git pull] IOMMU Fixes for Linux v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560528907;
        bh=2+K1vZzfZH05W3JJSs2Pul0tXH3bGKmc3kyN/HUe408=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YucqWFdDpXXrp06J+Ete4AZ/0gdaFlsf+io5xEBba/4HmcJ1KS/cR1v3i5/NoZLdZ
         gNbUo8OmYCNFAi+CdvrxdTTFKRdkKBaCGs3z359JmXRistAxlpoivmTuwL0N3GWyaA
         J+5HhOZNKtE7cz9e6QTm0lLmO81bHBuQ38MVYP5Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190614093854.GA10155@8bytes.org>
References: <20190614093854.GA10155@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190614093854.GA10155@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 tags/iommu-fixes-v5.2-rc4
X-PR-Tracked-Commit-Id: 4e4abae311e4b44aaf61f18a826fd7136037f199
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c78ad1be4b4d65eb214421b90a788abf3c85c3ea
Message-Id: <156052890740.10292.7234479296212051919.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Jun 2019 16:15:07 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jun 2019 11:39:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.2-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c78ad1be4b4d65eb214421b90a788abf3c85c3ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
