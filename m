Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AF2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574872085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfCGSeL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:34:11 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50492 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfCGSeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:34:11 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h1xq9-0003jG-Ce; Thu, 07 Mar 2019 19:33:57 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        kernel@collabora.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Yannick =?ISO-8859-1?Q?Fertr=E9?= <yannick.fertre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Olof Johansson <olof@lixom.net>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH v2] ARM: multi_v7_defconfig: Enable missing drivers for supported Chromebooks
Date:   Thu, 07 Mar 2019 19:33:56 +0100
Message-ID: <4389876.Ov8Zuus1em@diego>
In-Reply-To: <20190307152031.13417-1-enric.balletbo@collabora.com>
References: <20190307152031.13417-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 7. März 2019, 16:20:31 CET schrieb Enric Balletbo i Serra:
> Enable following drivers for merged devices:
> - Batteries with BQ27XXX chips for Minnie boards.
> - Elan eKTH I2C touchscreen for Minnie boards.
> - GPIO charger for all Veyron boards.
> - Rockchip SARADC driver for all rk3288 boards.
> - Rockchip eFUSE driver for all rk3288 boards.
> - TPM security chip for all Veyron boards.
> - ChromeOS EC userspace interface for all chromebooks boards.
> - ChromeOS EC light and proximity sensors for some chromebooks.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

@arm-soc people, do you want to apply this directly, if so here is a

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko


