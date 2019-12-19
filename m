Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF90EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9057F222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576719004;
	bh=s8shV4w2igNDmjITc4x6DKnVvwncODzNRqpehLZ7QT8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=YX8wzuSLHD5u7v88YNPpgjWt0VxSsub7Lj2h1IkKOJixDqicnZ/m6/HmvGoodlKpm
	 Ywp+TVpur3vg1huqVroHhSKi6V8XD1yMnDkc9XHs0RakKTro0ubFkS/hgcQo7Ym2Ge
	 nhUTarN5/+CWGGFG8Ybs4TAxcVUx5KBIKXR/UAdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLSBaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfLSBaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:30:03 -0500
Subject: Re: [GIT PULL] tpmdd updates for Linux v5.5-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576719002;
        bh=s8shV4w2igNDmjITc4x6DKnVvwncODzNRqpehLZ7QT8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MjvEWmmGMzoNaOBvfT8+M5nnweh8c1zJ8KRQEfiDEVt48p94veuhHN13ylUb45a8f
         zl9PnFAqWKZqmabzVv/sXlN0LrrY8x9JMNDAX2VduiIIrYsZtUqevLdASlkgSue3mk
         pmvkj7NDxuqxlE582cg5dEw0vU3fX0BhQ/RF9gWc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191219010317.GA3086@linux.intel.com>
References: <20191219010317.GA3086@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191219010317.GA3086@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tpmdd-next-20191219
X-PR-Tracked-Commit-Id: 1760eb689ed68c6746744aff2092bff57c78d907
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a94c43323342f1522034d6566c5129a7386a0ab
Message-Id: <157671900258.19837.15533650713180573474.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Dec 2019 01:30:02 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Dec 2019 03:03:17 +0200:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tpmdd-next-20191219

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a94c43323342f1522034d6566c5129a7386a0ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
