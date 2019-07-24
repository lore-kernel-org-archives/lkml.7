Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8E0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8933D2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 21:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbfGXVLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:11:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51918 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387568AbfGXVLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 17:11:17 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6BFBE1543A181;
        Wed, 24 Jul 2019 14:11:16 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:11:15 -0700 (PDT)
Message-Id: <20190724.141115.1138018570861660677.davem@davemloft.net>
To:     corentinmusard@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org
Subject: Re: [PATCH] r8169: fix a typo in a comment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190724123443.GA9626@user.home>
References: <20190724123443.GA9626@user.home>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 24 Jul 2019 14:11:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Musard <corentinmusard@gmail.com>
Date: Wed, 24 Jul 2019 14:34:43 +0200

> Replace "additonal" by "additional" in a comment.
> Typo found by checkpatch.pl.
> 
> Signed-off-by: Corentin Musard <corentinmusard@gmail.com>

Applied to net-next.
