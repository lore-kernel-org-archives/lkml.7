Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A45CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 17:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E5320679
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 17:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfJ0RqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 13:46:05 -0400
Received: from gloria.sntech.de ([185.11.138.130]:57948 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfJ0RqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 13:46:04 -0400
Received: from [46.218.74.72] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iOmc4-00089Z-Uy; Sun, 27 Oct 2019 18:46:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Andy Yan <andy.yan@rock-chips.com>
Cc:     kever.yang@rock-chips.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/4] arm64: dts: rockchip: Add core dts for RK3308 SOC
Date:   Sun, 27 Oct 2019 18:45:59 +0100
Message-ID: <12893370.vt1eeOlM6n@phil>
In-Reply-To: <20191021084616.28431-1-andy.yan@rock-chips.com>
References: <20191021084437.28279-1-andy.yan@rock-chips.com> <20191021084616.28431-1-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 21. Oktober 2019, 10:46:16 CET schrieb Andy Yan:
> RK3308 is a quad Cortex A35 based SOC with rich audio
> interfaces(I2S/PCM/TDM/PDM/SPDIF/VAD/HDMI ARC), which
> designed for intelligent voice interaction and audio
> input/output processing.
> 
> This patch add basic core dtsi file for it.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

applied for 5.5 with changes:

- dropped spi high_speed pinctrl, as it's not part of the spi binding
- dropped peripherals-req-type-burst as it's not part of the dma binding
- dropped sdmmc_gpio pinctrl
- removed a number of unneeded empty lines
- reordered things to better match our alphabetical sorting

Heiko


