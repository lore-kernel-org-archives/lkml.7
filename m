Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0412FCA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89AA20873
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 18:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfJ0SSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 14:18:49 -0400
Received: from gloria.sntech.de ([185.11.138.130]:58130 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfJ0SSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 14:18:49 -0400
Received: from [46.218.74.72] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iOn7j-0008Gg-Pf; Sun, 27 Oct 2019 19:18:43 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add LED nodes on rk3399-roc-pc
Date:   Sun, 27 Oct 2019 19:18:37 +0100
Message-ID: <4966121.jNSStvosxs@phil>
In-Reply-To: <7d8d85c9-5fde-7943-a6b6-639bca38bdc1@fivetechno.de>
References: <7d8d85c9-5fde-7943-a6b6-639bca38bdc1@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 21. Oktober 2019, 12:24:36 CET schrieb Markus Reichl:
> rk3399-roc-pc has three gpio LEDs, enable them.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied for 5.5
git am choked a bit on your inline signature though.

Thanks
Heiko


