Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAB8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20BF2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437227AbfIWIeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:34:25 -0400
Received: from mail-sz.amlogic.com ([211.162.65.117]:17196 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390945AbfIWIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:34:25 -0400
Received: from droid12-sz.software.amlogic (10.28.8.22) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.1591.10; Mon, 23 Sep 2019
 16:35:22 +0800
From:   Xingyu Chen <xingyu.chen@amlogic.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Xingyu Chen <xingyu.chen@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/3] reset: meson: add Meson-A1 SoC support
Date:   Mon, 23 Sep 2019 16:34:18 +0800
Message-ID: <1569227661-4261-1-git-send-email-xingyu.chen@amlogic.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.8.22]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for Meson-A1 SoC Reset Controller. A new struct
meson_reset_param is introduced to describe the register differences between
Meson-A1 and previous SoCs.

This patchset is based on A1 DTBv4[0].

Changes since v1 at [1]:
- rebase on linux-next
- add Neil's Reviewed-by

[0] https://lore.kernel.org/linux-amlogic/1568276370-54181-1-git-send-email-jianxin.pan@amlogic.com
[1] https://lore.kernel.org/linux-amlogic/1568808746-1153-1-git-send-email-xingyu.chen@amlogic.com

Xingyu Chen (3):
  arm64: dts: meson: add reset controller for Meson-A1 SoC
  dt-bindings: reset: add bindings for the Meson-A1 SoC Reset Controller
  reset: add support for the Meson-A1 SoC Reset Controller

 .../bindings/reset/amlogic,meson-reset.yaml        |  1 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |  6 +++
 drivers/reset/reset-meson.c                        | 35 ++++++++++---
 include/dt-bindings/reset/amlogic,meson-a1-reset.h | 59 ++++++++++++++++++++++
 4 files changed, 94 insertions(+), 7 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h

-- 
2.7.4

