Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730FCC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D63320675
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLEWjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:39:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48670 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbfLEWjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:39:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E9F3C150AE493;
        Thu,  5 Dec 2019 14:39:44 -0800 (PST)
Date:   Thu, 05 Dec 2019 14:39:44 -0800 (PST)
Message-Id: <20191205.143944.1644239054512253859.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     rdunlap@infradead.org, netdev@vger.kernel.org, tony@atomide.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 0/2] net: ethernet: ti: cpsw_switchdev: fix unmet
 direct dependencies detected for NET_SWITCHDEV
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191204174533.32207-1-grygorii.strashko@ti.com>
References: <20191204174533.32207-1-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Dec 2019 14:39:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Wed, 4 Dec 2019 19:45:31 +0200

> This series fixes Kconfig warning with CONFIG_COMPILE_TEST=y reported by
> Randy Dunlap <rdunlap@infradead.org> [1]
> 
> [1] https://lkml.org/lkml/2019/12/3/1373

I applied patch #1 to the networking tree, the defconfig update has to be routed via
the appropriate architecture tree.

Thank you.
