Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E2DC2D0D4
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 12:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9681C21927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 12:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfLUM5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 07:57:52 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55276 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfLUM5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 07:57:52 -0500
Received: from [195.37.15.138] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iieKA-0004xy-4C; Sat, 21 Dec 2019 13:57:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Thomas McKahan <tmckahan@singleboardsolutions.com>
Cc:     Markus Reichl <m.reichl@fivetechno.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Enable PD for USB-C-Port on rk3399-roc-pc.
Date:   Sat, 21 Dec 2019 13:57:37 +0100
Message-ID: <2330032.fiRFtybceW@phil>
In-Reply-To: <84920a36-230f-42a6-a960-a71e685be99f@singleboardsolutions.com>
References: <678df227-38be-47af-7ee3-741a391a196c@fivetechno.de> <84920a36-230f-42a6-a960-a71e685be99f@singleboardsolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Am Donnerstag, 12. Dezember 2019, 16:46:09 CET schrieb Thomas McKahan:
> Hello Markus,
> 
>     I have been working with this as well, came across it on Armbian. I was also trying to eliminate the warning concerning the lack of port with limited success.  I also missed the interrupt pin definition I see.  I will test this later today.  

Where you successful in your testing? My type-c exposure is somewhat
limited so it would be nice to get another opinion ;-)

>    I've added Neil Armstrong for information in case any boards on the Amlogic side are similarly configured, I think a few other Rockchip ones at least are missing connector nodes, it appears to be a consistent issue presumably due to driver changes.

The whole type-c topic is a somewhat undiscovered country on rk3399, due to
the cross-ec hooking rk3399's type-c components. (see the cros-ec-pd extcon
going to the rockchip type-c phy etc).

This is presently worked on so that also everything can at some point use the
kernel-internal type-c framework.

But of course this doesn't hinder configuring the power-develivery in the
fusb302 ICs already :-D .


Heiko


