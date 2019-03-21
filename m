Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33397C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E40218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfCUUVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:21:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbfCUUVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:21:34 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 78355133E9775;
        Thu, 21 Mar 2019 13:21:33 -0700 (PDT)
Date:   Thu, 21 Mar 2019 13:21:32 -0700 (PDT)
Message-Id: <20190321.132132.401829742507656571.davem@davemloft.net>
To:     dmurphy@ti.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: Add DP83825I to the DP83822 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190320123655.6289-1-dmurphy@ti.com>
References: <20190320123655.6289-1-dmurphy@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Mar 2019 13:21:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 20 Mar 2019 07:36:55 -0500

> Add the DP83825I ethernet PHY to the DP83822 driver.
> These devices share the same WoL register bits and addresses.
> 
> The phy_driver init was made into a macro as there may be future
> devices appended to this driver that will share the register space.
> 
> http://www.ti.com/lit/gpn/dp83825i
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Updated id and mask to new ID_MATCH macro, removed extra line - https://lore.kernel.org/patchwork/patch/1052329/

Applied, thanks.
