Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5649C04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 00:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EFB216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 00:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfE2A1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 20:27:01 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54484 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE2A1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 20:27:00 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 42AEF1400F7B0;
        Tue, 28 May 2019 17:27:00 -0700 (PDT)
Date:   Tue, 28 May 2019 17:26:59 -0700 (PDT)
Message-Id: <20190528.172659.217782677107847236.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, ioana.ciornei@nxp.com, olteanv@gmail.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] Documentation: net-sysfs: Remove duplicate PHY
 device documentation
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190528020643.646-1-f.fainelli@gmail.com>
References: <20190528020643.646-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 28 May 2019 17:27:00 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 27 May 2019 19:06:38 -0700

> Both sysfs-bus-mdio and sysfs-class-net-phydev contain the same
> duplication information. There is not currently any MDIO bus specific
> attribute, but there are PHY device (struct phy_device) specific
> attributes. Use the more precise description from sysfs-bus-mdio and
> carry that over to sysfs-class-net-phydev.
> 
> Fixes: 86f22d04dfb5 ("net: sysfs: Document PHY device sysfs attributes")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied, thanks.
