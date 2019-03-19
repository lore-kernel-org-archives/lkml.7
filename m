Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CADC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D2C2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 21:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCSV3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 17:29:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53994 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfCSV3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 17:29:20 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 255251469C564;
        Tue, 19 Mar 2019 14:29:20 -0700 (PDT)
Date:   Tue, 19 Mar 2019 14:29:19 -0700 (PDT)
Message-Id: <20190319.142919.1092427577031423870.davem@davemloft.net>
To:     wsa+renesas@sang-engineering.com
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        nicolas.ferre@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] net: macb: simplify getting .driver_data
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190319163634.30814-1-wsa+renesas@sang-engineering.com>
References: <20190319163634.30814-1-wsa+renesas@sang-engineering.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Mar 2019 14:29:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Tue, 19 Mar 2019 17:36:34 +0100

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Looks good to me, applied.
