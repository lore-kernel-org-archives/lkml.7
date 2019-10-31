Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E466CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E68E2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfJaOXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:23:11 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38254 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfJaOXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:23:11 -0400
Received: from dhcp-64-28.ens-lyon.fr ([140.77.64.28] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iQBLt-0005nA-Pi; Thu, 31 Oct 2019 15:23:05 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add vcc_sys enable pin on rk3399-roc-pc
Date:   Thu, 31 Oct 2019 15:23:04 +0100
Message-ID: <6903568.7J3coomyo0@phil>
In-Reply-To: <c72db0ad-c261-af4f-efe6-22bbcf4a0b7b@fivetechno.de>
References: <c72db0ad-c261-af4f-efe6-22bbcf4a0b7b@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 31. Oktober 2019, 09:51:56 CET schrieb Markus Reichl:
> rk3399-roc-pc has vcc_sys 5V supply for USB and other peripherals.
> Add the GPIO pin to enable the regulator.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied for 5.5


