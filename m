Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B476C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647D82072C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 22:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgAEWtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 17:49:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41698 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgAEWtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 17:49:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BFDB015572976;
        Sun,  5 Jan 2020 14:49:45 -0800 (PST)
Date:   Sun, 05 Jan 2020 14:49:45 -0800 (PST)
Message-Id: <20200105.144945.1887147568639526288.davem@davemloft.net>
To:     krzk@kernel.org
Cc:     bh74.an@samsung.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Drop obsolete entries from Samsung sxgbe
 ethernet driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200103172549.11048-1-krzk@kernel.org>
References: <20200103172549.11048-1-krzk@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 Jan 2020 14:49:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri,  3 Jan 2020 18:25:49 +0100

> The emails to ks.giri@samsung.com and vipul.pandya@samsung.com bounce
> with 550 error code:
> 
>     host mailin.samsung.com[203.254.224.12] said: 550
>     5.1.1 Recipient address rejected: User unknown (in reply to RCPT TO
>     command)"
> 
> Drop Girish K S and Vipul Pandya from sxgbe maintainers entry.
> 
> Cc: Byungho An <bh74.an@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied.
