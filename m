Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF14C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCB220449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfCLKim convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:38:42 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58656 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfCLKil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:38:41 -0400
Received: from we0652.dip.tu-dresden.de ([141.76.178.140] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h3ens-00016F-L8; Tue, 12 Mar 2019 11:38:36 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Akash Gajjar <akash@openedev.com>
Subject: Re: [PATCH 1/3] arm64: dts: rockchip: rk3399: rock960: Rename vcc_sys into vcc5v0_sys
Date:   Tue, 12 Mar 2019 11:38:36 +0100
Message-ID: <2025500.4so6M6JK9C@phil>
In-Reply-To: <20190311150332.19492-1-jagan@amarulasolutions.com>
References: <20190311150332.19492-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 11. März 2019, 16:03:30 CET schrieb Jagan Teki:
> It is always better practice to follow regulator naming conventions
> as per the schematics for future references.
> 
> So, rename vcc_sys into vcc5v0_sys as per rk3399 power diagram of
> rock960 schematics.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Signed-off-by: Akash Gajjar <akash@openedev.com>

I've double-checked both rock960 and ficus schematics to verify
and applied both patch 1+2 for 5.2

Thanks
Heiko


