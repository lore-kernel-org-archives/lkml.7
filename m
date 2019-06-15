Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C77C31E44
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936952173C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 02:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFOC3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 22:29:06 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57470 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFOC3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 22:29:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 266BB136E0811;
        Fri, 14 Jun 2019 19:29:05 -0700 (PDT)
Date:   Fri, 14 Jun 2019 19:29:04 -0700 (PDT)
Message-Id: <20190614.192904.1407195520084868084.davem@davemloft.net>
To:     anders.roxell@linaro.org
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        linus.walleij@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: dsa: fix warning same module names
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190613113503.4839-1-anders.roxell@linaro.org>
References: <20190613113503.4839-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Jun 2019 19:29:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 13 Jun 2019 13:35:03 +0200

> When building with CONFIG_NET_DSA_REALTEK_SMI and CONFIG_REALTEK_PHY
> enabled as loadable modules, we see the following warning:
> 
> warning: same module names found:
>   drivers/net/phy/realtek.ko
>   drivers/net/dsa/realtek.ko
> 
> Rework so the driver name is realtek-smi instead of realtek.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied.
