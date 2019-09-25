Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5254C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEDD207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569433209;
	bh=d0Ht5tuogpE0oLeNz+8DxZE0agOlMsMwzMYMy2/DwMc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=kTpYaNr6SgXaDA9rjPioJuGR/YJEq+ZH2h6lVebSKVYt/Nn6//xMLFUFCQEh9Ke56
	 12M5oa9hVGzFpiaCTXYf2I1rF6NlOiEgWh+UkDBbfi7NORyyvHsOCiezo7jyb+9H7z
	 qr+cALgPSWwUuoAznnjZARoWP4f7Ryu320AGBmZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634228AbfIYRkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443048AbfIYRkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:40:06 -0400
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569433206;
        bh=d0Ht5tuogpE0oLeNz+8DxZE0agOlMsMwzMYMy2/DwMc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1TxT3E6W2lKgQMM+HS3ycaKsaf8U3QMnA7KX1zRd7aXcW4c4hqLIF7oUNCVpm4U5U
         0TKAJ4lbRgUxUIBhgneEWwhJmMA0dRj1BOO7A6Pp8AJHdTIFr+eMrl3tgUbVcN0Jot
         2Hhmua5oWjHY+kc4jU1dpgmu63ufNcKRgG1wuDUQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190925000214.GA23372@linux.intel.com>
References: <20190925000214.GA23372@linux.intel.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190925000214.GA23372@linux.intel.com>
X-PR-Tracked-Remote: git://git.infradead.org/users/jjs/linux-tpmdd.git
 tags/tpmdd-next-20190925
X-PR-Tracked-Commit-Id: e13cd21ffd50a07b55dcc4d8c38cedf27f28eaa1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 301310c6d24e5b135d1efd3d4a9cc6adc4fbd94a
Message-Id: <156943320613.26797.6301275237676729094.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Sep 2019 17:40:06 +0000
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jmorris@namei.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 Sep 2019 03:02:14 +0300:

> git://git.infradead.org/users/jjs/linux-tpmdd.git tags/tpmdd-next-20190925

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/301310c6d24e5b135d1efd3d4a9cc6adc4fbd94a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
