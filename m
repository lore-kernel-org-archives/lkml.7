Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D2BC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E66020818
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfEQJWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:22:12 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60352 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfEQJWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:22:12 -0400
Received: from we0524.dip.tu-dresden.de ([141.76.178.12] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hRZ42-0001Ab-69; Fri, 17 May 2019 11:22:06 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add PCIe nodes on rk3399-rockpro64
Date:   Fri, 17 May 2019 11:22:05 +0200
Message-ID: <45858032.MVTSb7sYM0@phil>
In-Reply-To: <20190509170314.12806-1-katsuhiro@katsuster.net>
References: <20190509170314.12806-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Mai 2019, 19:03:14 CEST schrieb Katsuhiro Suzuki:
> This patch adds PCIe, PCIe phy and pinctrl (for PERST#) nodes for
> RockPro64 board.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

applied for 5.3 after a bit of alphabetical sorting
- num-lanes above pinctrl properties
- pcie-perst above pcie-pwr-on pinctrl entry


Heiko


