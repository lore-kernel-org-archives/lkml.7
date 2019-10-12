Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613E3C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F07214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 03:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfJLDps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 23:45:48 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55292 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJLDps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 23:45:48 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 067CA150030AC;
        Fri, 11 Oct 2019 20:45:47 -0700 (PDT)
Date:   Fri, 11 Oct 2019 20:45:47 -0700 (PDT)
Message-Id: <20191011.204547.362684384666618017.davem@davemloft.net>
To:     vcaputo@pengaru.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sock_get_timeout: drop unnecessary return variable
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191010040824.fbauijiiyyz5dl5y@shells.gnugeneration.com>
References: <20191010040824.fbauijiiyyz5dl5y@shells.gnugeneration.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 11 Oct 2019 20:45:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vito Caputo <vcaputo@pengaru.com>
Date: Wed, 9 Oct 2019 21:08:24 -0700

> Remove pointless use of size return variable by directly returning
> sizes.
> 
> Signed-off-by: Vito Caputo <vcaputo@pengaru.com>

Looks good, applied to net-next.
