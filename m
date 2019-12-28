Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78925C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 15:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F49F2173E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 15:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfL1PGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 10:06:22 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:42381 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfL1PGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 10:06:21 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBSF5xcZ031645, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBSF5xcZ031645
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sat, 28 Dec 2019 23:05:59 +0800
Received: from james-BS01.localdomain (172.21.190.33) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Sat, 28 Dec 2019 23:05:58 +0800
From:   James Tai <james.tai@realtek.com>
To:     <linux-realtek-soc@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH v2 0/2] Initial RTD1319 SoC and Realtek PymParticle EVB support
Date:   Sat, 28 Dec 2019 23:05:51 +0800
Message-ID: <20191228150553.6210-1-james.tai@realtek.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

This series adds Device Trees for the Realtek RTD1319 SoC and Realtek's
PymParticle EVB.

The v2 is based on my RTD1619 series and Andreas' RTD1395, syscon series.

v1 -> v2:
* Reserve the boot ROM address
* Reserve boot loader address
* Reserve audio/video FW address
* Reserve RPC and ring budffer address
* Reserve TEE address
* Support 1 GiB RAM by default
* Reduce rbus range to 2 MiB
* Apply the syscon for ISO,MISC,CRT,SB2,SCPU_WRAPPER
* Adjust compatible strings order in document

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andreas Färber <afaerber@suse.de>

James Tai (2):
  dt-bindings: arm: realtek: Document RTD1319 and Realtek PymParticle
    EVB
  arm64: dts: realtek: Add RTD1319 SoC and Realtek PymParticle EVB

 .../devicetree/bindings/arm/realtek.yaml      |   6 +
 arch/arm64/boot/dts/realtek/Makefile          |   2 +
 .../boot/dts/realtek/rtd1319-pymparticle.dts  |  43 ++++
 arch/arm64/boot/dts/realtek/rtd1319.dtsi      |  12 +
 arch/arm64/boot/dts/realtek/rtd13xx.dtsi      | 212 ++++++++++++++++++
 5 files changed, 275 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319-pymparticle.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd13xx.dtsi

-- 
2.24.1

