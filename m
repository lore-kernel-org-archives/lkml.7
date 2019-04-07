Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4227AC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B232133F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDGBRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:17:14 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39596 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDGBRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:17:13 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 946CC14BC08AB;
        Sat,  6 Apr 2019 18:17:12 -0700 (PDT)
Date:   Sat, 06 Apr 2019 18:17:12 -0700 (PDT)
Message-Id: <20190406.181712.1121608163259706596.davem@davemloft.net>
To:     jbrunet@baylibre.com
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        khilman@baylibre.com, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/4] net: phy: add Amlogic g12a support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190404131147.31156-1-jbrunet@baylibre.com>
References: <20190404131147.31156-1-jbrunet@baylibre.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 06 Apr 2019 18:17:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu,  4 Apr 2019 15:11:43 +0200

> This patchset adds the necessary bits to support network on the Amlogic
> g12a SoC family.
> 
> Only the internal PHY and related MDIO mux needed to be addressed.
> The GMAC remains compatible with axg SoC family
> 
> This series has been tested on the u200 (S905D2) with both the internal
> and external (Realtek) PHYs.
> 
> Change since v2 [1]:
> * Change 'clk part' Reviewed-by as suggested
> * Remove default callback from phy drivers
> * Use exact match PHY macros
> * Default MDIO g12a as module if ARCH_MESON is enabled
> * Don't print error on probe defer in the g12a mdio mux
> 
> Change since v1 [0]:
> * drop '_' from function name unrelated to locking
> * fix peripheral clock disable on error
> * fix variable declaration reverse Xmas trees
> * fix Kconfig dependency on CCF
>   (Actually needed for 'struct clk_hw', Thx Andrew !)
> * Minor fix in the DT exemple as reported by Rob
> 
> [0] https://lkml.kernel.org/r/20190314140135.19184-1-jbrunet@baylibre.com
> [1] https://lkml.kernel.org/r/20190329141512.29867-1-jbrunet@baylibre.com

Series applied, thanks.
