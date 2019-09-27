Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A010FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEE3217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfI0IUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:20:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57170 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfI0IUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:20:19 -0400
Received: from localhost (unknown [65.39.69.237])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 573F414DE4E2A;
        Fri, 27 Sep 2019 01:20:16 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:20:14 +0200 (CEST)
Message-Id: <20190927.102014.1540733849871544653.davem@davemloft.net>
To:     dan.carpenter@oracle.com
Cc:     andrew@lunn.ch, lidongpo@hisilicon.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com, robh+dt@kernel.org, frowand.list@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] of: mdio: Fix a signedness bug in
 of_phy_get_and_connect()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190925110100.GL3264@mwanda>
References: <20190925110100.GL3264@mwanda>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 27 Sep 2019 01:20:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 25 Sep 2019 14:01:00 +0300

> The "iface" variable is an enum and in this context GCC treats it as
> an unsigned int so the error handling is never triggered.
> 
> Fixes: b78624125304 ("of_mdio: Abstract a general interface for phy connect")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.
