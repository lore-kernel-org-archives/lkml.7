Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4DFC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D96C20449
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfEBPgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:36:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727175AbfEBPgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:36:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6DF5AB91;
        Thu,  2 May 2019 15:36:28 +0000 (UTC)
Subject: Re: [PATCH v9 2/2] phy: Add driver for mixel mipi dphy found on NXP's
 i.MX8 SoCs
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Robert Chiras <robert.chiras@nxp.com>
References: <cover.1556633413.git.agx@sigxcpu.org>
 <b999b07673e59c676d2e43a786b635beb056e9bf.1556633413.git.agx@sigxcpu.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hovold <johan@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>, Li Jun <jun.li@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <4ce62b78-64ac-ca84-733f-bc4d10a67c54@suse.de>
Date:   Thu, 2 May 2019 17:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b999b07673e59c676d2e43a786b635beb056e9bf.1556633413.git.agx@sigxcpu.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.04.19 um 16:40 schrieb Guido Günther:
> This adds support for the Mixel DPHY as found on i.MX8 CPUs but since
> this is an IP core it will likely be found on others in the future. So
> instead of adding this to the nwl host driver make it a generic PHY
> driver.
> 
> The driver supports the i.MX8MQ. Support for i.MX8QM and i.MX8QXP can be
> added once the necessary system controller bits are in via
> mixel_dphy_devdata.
> 
> Co-authored-by: Robert Chiras <robert.chiras@nxp.com>

This should be Co-developed-by and is lacking a Signed-off-by from that
author. Robert, can you please provide one?

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> Signed-off-by: Guido Günther <agx@sigxcpu.org>
Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
