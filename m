Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34EBC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F9B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfJJVa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:30:29 -0400
Received: from gloria.sntech.de ([185.11.138.130]:33816 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfJJVa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:30:28 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iIg0w-0007BZ-RA; Thu, 10 Oct 2019 23:30:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Soeren Moch <smoch@web.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: fix RockPro64 sdmmc settings
Date:   Thu, 10 Oct 2019 23:30:26 +0200
Message-ID: <2055831.6uBfQfHlXk@phil>
In-Reply-To: <20191004203213.4995-1-smoch@web.de>
References: <20191004203213.4995-1-smoch@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 4. Oktober 2019, 22:32:13 CEST schrieb Soeren Moch:
> According to the RockPro64 schematic [1] the rk3399 sdmmc controller is
> connected to a microSD (TF card) slot. Remove the cap-mmc-highspeed
> property of the sdmmc controller, since no mmc card can be connected here.
> 
> [1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> 
> Fixes: e4f3fb490967 ("arm64: dts: rockchip: add initial dts support for Rockpro64")
> Signed-off-by: Soeren Moch <smoch@web.de>

applied as fix for 5.4

Thanks
Heiko


