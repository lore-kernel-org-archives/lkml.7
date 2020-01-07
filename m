Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD61C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D18420848
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgAGS6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:58:04 -0500
Received: from lists.gateworks.com ([108.161.130.12]:46796 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgAGS6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:58:04 -0500
Received: from 68-189-91-139.static.snlo.ca.charter.com ([68.189.91.139] helo=rjones.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <rjones@gateworks.com>)
        id 1iou3F-0006Mw-Ke; Tue, 07 Jan 2020 18:58:01 +0000
From:   Robert Jones <rjones@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Robert Jones <rjones@gateworks.com>
Subject: [PATCH v6 0/5] ARM: dts: imx: Add GW59xx Gateworks specials
Date:   Tue,  7 Jan 2020 10:57:48 -0800
Message-Id: <20200107185753.28308-1-rjones@gateworks.com>
X-Mailer: git-send-email 2.9.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds board support for the GW59xx Gateworks Ventana family
specials.

Changes in v2:
 - Generalized node names
 - Removed unnecessary labels
 - Expanded patch subject
 - Removed undocumented compatible string in dts

Changes in v3:
 - Fixed a conflict in arch/arm/boot/dts/Makefile

Changes in v4:
 - Clarified authorship
 - Added dt-bindings compatible entries

Changes in v5:
 - Added documentation schema permutations for all gateworks ventana boards
 - Added back compatible strings from dts removed in v2

Changes in v6:
 - Reorganized dt-bindings schema into new items entry

Robert Jones (4):
  dt-bindings: arm: fsl: Add Gateworks Ventana i.MX6DL/Q compatibles
  ARM: dts: imx: Add GW5907 board support
  ARM: dts: imx: Add GW5913 board support
  ARM: dts: imx: Add GW5912 board support

Tim Harvey (1):
  ARM: dts: imx: Add GW5910 board support

 Documentation/devicetree/bindings/arm/fsl.yaml |  37 ++
 arch/arm/boot/dts/Makefile                     |   8 +
 arch/arm/boot/dts/imx6dl-gw5907.dts            |  14 +
 arch/arm/boot/dts/imx6dl-gw5910.dts            |  14 +
 arch/arm/boot/dts/imx6dl-gw5912.dts            |  13 +
 arch/arm/boot/dts/imx6dl-gw5913.dts            |  14 +
 arch/arm/boot/dts/imx6q-gw5907.dts             |  14 +
 arch/arm/boot/dts/imx6q-gw5910.dts             |  14 +
 arch/arm/boot/dts/imx6q-gw5912.dts             |  13 +
 arch/arm/boot/dts/imx6q-gw5913.dts             |  14 +
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi          | 399 ++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi          | 491 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi          | 461 +++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi          | 348 ++++++++++++++++++
 14 files changed, 1854 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5907.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5910.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5912.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5913.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5907.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5910.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5912.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5913.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5907.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5910.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5912.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5913.dtsi

-- 
2.9.2

