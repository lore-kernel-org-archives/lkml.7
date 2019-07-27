Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECB5C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 21:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CAE208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 21:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfG0VSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 17:18:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40292 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfG0VSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 17:18:14 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4E1BE1534E491;
        Sat, 27 Jul 2019 14:18:13 -0700 (PDT)
Date:   Sat, 27 Jul 2019 14:18:12 -0700 (PDT)
Message-Id: <20190727.141812.424056483851039132.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, skunberg.kelsey@gmail.com
Subject: Re: [PATCH] drivers: net: xgene: Move status variable declaration
 into CONFIG_ACPI block
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190726162037.37308-1-natechancellor@gmail.com>
References: <20190726162037.37308-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Jul 2019 14:18:13 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Fri, 26 Jul 2019 09:20:37 -0700

> When CONFIG_ACPI is unset (arm allyesconfig), status is unused.
> 
> drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c:383:14: warning:
> unused variable 'status' [-Wunused-variable]
>         acpi_status status;
>                     ^
> drivers/net/ethernet/apm/xgene/xgene_enet_sgmac.c:440:14: warning:
> unused variable 'status' [-Wunused-variable]
>         acpi_status status;
>                     ^
> drivers/net/ethernet/apm/xgene/xgene_enet_hw.c:697:14: warning: unused
> variable 'status' [-Wunused-variable]
>         acpi_status status;
>                     ^
> 
> Move the declaration into the CONFIG_ACPI block so that there are no
> compiler warnings.
> 
> Fixes: 570d785ba46b ("drivers: net: xgene: Remove acpi_has_method() calls")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
