Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB320C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8131620700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDAWDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:03:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDAWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:03:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 98A77108DA508;
        Mon,  1 Apr 2019 15:03:11 -0700 (PDT)
Date:   Mon, 01 Apr 2019 15:03:11 -0700 (PDT)
Message-Id: <20190401.150311.1479407310371625393.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     netdev@vger.kernel.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de
Subject: Re: [PATCH v2 net-next] net: ethernet: ti: davinci_mdio: switch to
 readl/writel()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1553875114-14249-1-git-send-email-grygorii.strashko@ti.com>
References: <1553875114-14249-1-git-send-email-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Apr 2019 15:03:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 29 Mar 2019 17:58:34 +0200

> Switch to readl/writel() APIs, because this is recommended
> API and the MDIO block is reused on Keystone 2 SoCs
> where LE/BE modes are supported.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> changes in v2:
> - use readl/writel() as recommended

Applied, thanks.
