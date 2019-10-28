Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B762CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7550020679
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 03:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfJ1DQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 23:16:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39508 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbfJ1DQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 23:16:08 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 68D1C1A0B11;
        Mon, 28 Oct 2019 04:16:06 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 232261A0058;
        Mon, 28 Oct 2019 04:16:02 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 486EA402F0;
        Mon, 28 Oct 2019 11:15:56 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 0/9] Add SoC serial number support for i.MX6/7 SoCs
Date:   Mon, 28 Oct 2019 11:12:41 +0800
Message-Id: <1572232370-31580-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6/7 SoCs have 64-bit unique ID stored in OCOTP bank 0, word 1/2,
read them out as SoC serial number which can be used from userspace:

root@imx7dsabresd:~# cat /sys/devices/soc0/serial_number
0000028FF618B953

Add support for i.MX6Q/6DL/6SL/6SX/6SLL/6UL/6ULL/6ULZ/7D, as they have
same unique ID layout in OCOTP.

Anson Huang (9):
  ARM: imx: Add serial number support for i.MX6Q
  ARM: imx: Add serial number support for i.MX6DL
  ARM: imx: Add serial number support for i.MX6SLL
  ARM: imx: Add serial number support for i.MX6ULL
  ARM: imx: Add serial number support for i.MX6UL
  ARM: imx: Add serial number support for i.MX6ULZ
  ARM: imx: Add serial number support for i.MX6SL
  ARM: imx: Add serial number support for i.MX6SX
  ARM: imx: Add serial number support for i.MX7D

 arch/arm/mach-imx/cpu.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

-- 
2.7.4

