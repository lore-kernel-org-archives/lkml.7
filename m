Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A1DC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B762183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfFNQzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:55:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43218 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfFNQzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:55:06 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hbpTc-0006Tl-WD; Fri, 14 Jun 2019 18:54:57 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org,
        justin.swartz@risingedge.co.za, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 0/4] hdmi on rk3229
Date:   Fri, 14 Jun 2019 18:54:50 +0200
Message-Id: <20190614165454.13743-1-heiko@sntech.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hdmiphy needs its clock reparented to the actual hdmiphy-pll
that gets generated in the hdmiphy itself.

This incorporates adapted versions of Justin's original patches
and also the needed clock adaptions to make it possible to
reparent the hdmiphy clock.

Heiko Stuebner (2):
  clk: rockchip: add clock id for hdmi_phy special clock
  clk: rockchip: export HDMIPHY clock

Justin Swartz (2):
  ARM: dts: rockchip: add display nodes for rk322x
  ARM: dts: rockchip: fix vop iommu-cells on rk322x

 arch/arm/boot/dts/rk322x.dtsi          | 85 +++++++++++++++++++++++++-
 drivers/clk/rockchip/clk-rk3228.c      |  2 +-
 include/dt-bindings/clock/rk3228-cru.h |  1 +
 3 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.20.1

