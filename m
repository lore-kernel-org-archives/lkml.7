Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CAAC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F7D21721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfHPS51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:57:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38016 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfHPS51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:57:27 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 11EEF133F9EED;
        Fri, 16 Aug 2019 11:57:26 -0700 (PDT)
Date:   Fri, 16 Aug 2019 11:57:21 -0700 (PDT)
Message-Id: <20190816.115721.2066524764941816948.davem@davemloft.net>
To:     alexandru.ardelean@analog.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, f.fainelli@gmail.com, hkallweit1@gmail.com,
        andrew@lunn.ch
Subject: Re: [PATCH v5 00/13] net: phy: adin: add support for Analog
 Devices PHYs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190816131011.23264-1-alexandru.ardelean@analog.com>
References: <20190816131011.23264-1-alexandru.ardelean@analog.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 16 Aug 2019 11:57:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Fri, 16 Aug 2019 16:09:58 +0300

> This changeset adds support for Analog Devices Industrial Ethernet PHYs.
> Particularly the PHYs this driver adds support for:
>  * ADIN1200 - Robust, Industrial, Low Power 10/100 Ethernet PHY
>  * ADIN1300 - Robust, Industrial, Low Latency 10/100/1000 Gigabit
>    Ethernet PHY
> 
> The 2 chips are register compatible with one another. The main
> difference being that ADIN1200 doesn't operate in gigabit mode.
> 
> The chips can be operated by the Generic PHY driver as well via the
> standard IEEE PHY registers (0x0000 - 0x000F) which are supported by the
> kernel as well. This assumes that configuration of the PHY has been done
> completely in HW, according to spec, i.e. no extra SW configuration
> required.
> 
> This changeset also implements the ability to configure the chips via SW
> registers.
> 
> Datasheets:
>   https://www.analog.com/media/en/technical-documentation/data-sheets/ADIN1300.pdf
>   https://www.analog.com/media/en/technical-documentation/data-sheets/ADIN1200.pdf
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Series applied, thank you.
