Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83762C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3E620665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbfG3VZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:25:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55518 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387649AbfG3VZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:25:11 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2F9E7143750FA;
        Tue, 30 Jul 2019 14:25:10 -0700 (PDT)
Date:   Tue, 30 Jul 2019 14:25:09 -0700 (PDT)
Message-Id: <20190730.142509.1116873625739020925.davem@davemloft.net>
To:     swboyd@chromium.org
Cc:     linux-kernel@vger.kernel.org, kvalo@codeaurora.org,
        saeedm@mellanox.com, jeffrey.t.kirsher@intel.com, nbd@nbd.name,
        lorenzo@kernel.org, netdev@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v6 51/57] net: Remove dev_err() usage after
 platform_get_irq()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190730181557.90391-52-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
        <20190730181557.90391-52-swboyd@chromium.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jul 2019 14:25:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <swboyd@chromium.org>
Date: Tue, 30 Jul 2019 11:15:51 -0700

> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
 ...
> While we're here, remove braces on if statements that only have one
> statement (manually).
 ...
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
> 
> Please apply directly to subsystem trees

I'll take this into net-next.
