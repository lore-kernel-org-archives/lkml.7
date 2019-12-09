Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FCDC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6B5206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfLIWmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:42:05 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:36756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfLIWmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:42:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 71F1915494A9F;
        Mon,  9 Dec 2019 14:42:04 -0800 (PST)
Date:   Mon, 09 Dec 2019 14:42:03 -0800 (PST)
Message-Id: <20191209.144203.2085646533397424867.davem@davemloft.net>
To:     hslester96@gmail.com
Cc:     izumi.taku@jp.fujitsu.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fjes: fix missed check in fjes_acpi_add
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191209162207.14934-1-hslester96@gmail.com>
References: <20191209162207.14934-1-hslester96@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 09 Dec 2019 14:42:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>
Date: Tue, 10 Dec 2019 00:22:07 +0800

> fjes_acpi_add() misses a check for platform_device_register_simple().
> Add a check to fix it.
> 
> Fixes: 658d439b2292 ("fjes: Introduce FUJITSU Extended Socket Network Device driver")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Applied.
