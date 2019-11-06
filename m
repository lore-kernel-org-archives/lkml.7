Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE773C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F612205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731135AbfKFK0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:26:44 -0500
Received: from mx.socionext.com ([202.248.49.38]:44272 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbfKFK0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:26:44 -0500
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 06 Nov 2019 19:26:43 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 6AE77180095;
        Wed,  6 Nov 2019 19:26:43 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 6 Nov 2019 19:26:53 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id CB92B1A04FC;
        Wed,  6 Nov 2019 19:26:42 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 0/6] phy: socionext: Add some improvements and legacy SoC support
Date:   Wed,  6 Nov 2019 19:26:13 +0900
Message-Id: <1573035979-32200-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds some improvements to PHY interface drivers, and adds legacy SoC
support that needs to manage gio clock and reset.

Kunihiko Hayashi (6):
  phy: socionext: Use devm_platform_ioremap_resource()
  dt-bindings: phy: socionext: Add Pro5 support and remove Pro4 from
    usb3-hsphy
  phy: uniphier-usb3ss: Add Pro5 support
  phy: uniphier-usb3hs: Add legacy SoC support for Pro5
  phy: uniphier-usb3hs: Change Rx sync mode to avoid communication
    failure
  phy: uniphier-pcie: Add legacy SoC support for Pro5

 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  | 13 ++-
 .../bindings/phy/uniphier-usb3-hsphy.txt           |  6 +-
 .../bindings/phy/uniphier-usb3-ssphy.txt           |  5 +-
 drivers/phy/socionext/phy-uniphier-pcie.c          | 87 ++++++++++++++++----
 drivers/phy/socionext/phy-uniphier-usb3hs.c        | 92 ++++++++++++++++------
 drivers/phy/socionext/phy-uniphier-usb3ss.c        |  8 +-
 6 files changed, 163 insertions(+), 48 deletions(-)

-- 
2.7.4

