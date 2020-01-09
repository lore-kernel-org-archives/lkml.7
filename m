Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2A6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDED20643
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 00:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgAIAGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 19:06:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:50054 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgAIAGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 19:06:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4F0BE1539F83E;
        Wed,  8 Jan 2020 16:06:45 -0800 (PST)
Date:   Wed, 08 Jan 2020 16:06:44 -0800 (PST)
Message-Id: <20200108.160644.387751419406283854.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     vladimir.oltean@nxp.com, claudiu.manoil@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: felix: fix link error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200108124844.1348395-1-arnd@arndb.de>
References: <20200108124844.1348395-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 08 Jan 2020 16:06:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  8 Jan 2020 13:48:38 +0100

> When the enetc driver is disabled, the mdio support fails to
> get built:
> 
> drivers/net/dsa/ocelot/felix_vsc9959.o: In function `vsc9959_mdio_bus_alloc':
> felix_vsc9959.c:(.text+0x19c): undefined reference to `enetc_hw_alloc'
> felix_vsc9959.c:(.text+0x1d1): undefined reference to `enetc_mdio_read'
> felix_vsc9959.c:(.text+0x1d8): undefined reference to `enetc_mdio_write'
> 
> Change the Makefile to enter the subdirectory for this as well.
> 
> Fixes: bdeced75b13f ("net: dsa: felix: Add PCS operations for PHYLINK")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
