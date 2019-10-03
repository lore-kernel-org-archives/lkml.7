Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96C2222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfJCWuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 18:50:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56958 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfJCWuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 18:50:14 -0400
Received: from p57b7758c.dip0.t-ipconnect.de ([87.183.117.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iG9vA-0000up-PG; Fri, 04 Oct 2019 00:50:04 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Levin Du <djw@t-chip.com.cn>, Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 6/6] arm64: dts: rockchip: Fix roc-rk3399-pc regulator input rails
Date:   Fri, 04 Oct 2019 00:50:03 +0200
Message-ID: <3794940.QX3D9CpLXO@phil>
In-Reply-To: <20190919052822.10403-7-jagan@amarulasolutions.com>
References: <20190919052822.10403-1-jagan@amarulasolutions.com> <20190919052822.10403-7-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 19. September 2019, 07:28:22 CEST schrieb Jagan Teki:
> Few, know rk808 pmic regulators VCC[1-4], VCC[6-7], VCC[9-11],
> VDD_LOG, VDD_GPU, VDD_CPU_B, VCC3V3_SYS are inputting with vcc_sys
> which is 5V power rail from dc_12v.
> 
> So, replace the vin-supply of above mentioned regulators
> with vcc_sys as per the PMIC-RK808-D page of roc-rk3399-pc
> schematics.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

applied for 5.5 (with the filename changed to the current one of course)

Thanks
Heiko


