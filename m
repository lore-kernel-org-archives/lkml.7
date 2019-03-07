Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC24C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318CF2063F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCGR3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:29:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51988 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCGR3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:29:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DE83E147A0F4B;
        Thu,  7 Mar 2019 09:29:35 -0800 (PST)
Date:   Thu, 07 Mar 2019 09:29:35 -0800 (PST)
Message-Id: <20190307.092935.672404980902324009.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     ndesaulniers@google.com, grygorii.strashko@ti.com,
        bgolaszewski@baylibre.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] davinci_emac: always build in CONFIG_OF code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307093135.3354493-1-arnd@arndb.de>
References: <20190307093135.3354493-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Mar 2019 09:29:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  7 Mar 2019 10:31:20 +0100

> clang warns about what seems to be an unintended use of an obscure C
> language feature where a forward declaration of an array remains usable
> when the final definition is never seen:
> 
> drivers/net/ethernet/ti/davinci_emac.c:1694:34: error: tentative array definition assumed to have one element [-Werror]
> static const struct of_device_id davinci_emac_of_match[];
> 
> There is no harm in always enabling the device tree matching code here,
> and it makes the code behave in a more conventional way aside from
> avoiding the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
