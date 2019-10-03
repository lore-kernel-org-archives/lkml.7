Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FF321D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 22:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfJCWuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 18:50:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:56902 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbfJCWuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 18:50:01 -0400
Received: from p57b7758c.dip0.t-ipconnect.de ([87.183.117.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iG9up-0000uR-6I; Fri, 04 Oct 2019 00:49:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Levin Du <djw@t-chip.com.cn>, Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Da Xue <da@lessconfused.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH 5/6] arm64: dts: rockchip: Rename vcc12v_sys into dc_12v for roc-rk3399-pc
Date:   Fri, 04 Oct 2019 00:49:42 +0200
Message-ID: <2645663.MEMbyMBloX@phil>
In-Reply-To: <20190919052822.10403-6-jagan@amarulasolutions.com>
References: <20190919052822.10403-1-jagan@amarulasolutions.com> <20190919052822.10403-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 19. September 2019, 07:28:21 CEST schrieb Jagan Teki:
> It is always better practice to follow regulator naming conventions
> as per the schematics for future references.
> 
> This would indeed helpful to review and check the naming convention
> directly on schematics, both for the code reviewers and the developers.
> 
> So, rename vcc12v_sys into dc_12v as per rk3399 power tree as per
> roc-rk3399-pc schematics.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

applied for 5.5 (with the filename changed to the current one of course)

Thanks
Heiko


