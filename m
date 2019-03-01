Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7170C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AB02087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 04:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="DNfvESeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfCAEYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 23:24:06 -0500
Received: from mail.nic.cz ([217.31.204.67]:53956 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCAEYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 23:24:06 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 3B6306235E;
        Fri,  1 Mar 2019 05:24:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551414244; bh=CCzZIWsfGNm+j1aCuYUYxTHwbZhC2pVX+r4Vn4WaVnY=;
        h=From:To:Date;
        b=DNfvESeCSpqW42vgvbMikrNRHjvQ8kqp0lK5FoQ2ybGBDWJHAofyxAbxzvpsxKbP1
         ccby90Ex8Yyz/POLVTUrHakJzagx7cquBRQ6Quk3L4CsXKXwkobdbXuBc+XQ+uktGS
         R2YVeqtDXEwVj80vkZ9zu3sIaXO+JKG4oJtCeeB0=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH v2 mailbox 0/3] Armada 37xx mailbox support
Date:   Fri,  1 Mar 2019 05:23:38 +0100
Message-Id: <20190301042341.29484-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this is the second version of patches I sent in December, rebased onto
current linux/master.

Changes since previous version:
 - compatible string changed not to use wildcards, as requested by
   Rob Herring

Marek

Marek Behún (3):
  mailbox: Add support for Armada 37xx rWTM mailbox
  dt-bindings: mailbox: Document armada-37xx-rwtm-mailbox binding
  arm64: dts: marvell: armada-37xx: add mailbox node

 .../mailbox/armada-37xx-rwtm-mailbox.txt      |  16 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   7 +
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/armada-37xx-rwtm-mailbox.c    | 227 ++++++++++++++++++
 include/linux/armada-37xx-rwtm-mailbox.h      |  23 ++
 6 files changed, 285 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt
 create mode 100644 drivers/mailbox/armada-37xx-rwtm-mailbox.c
 create mode 100644 include/linux/armada-37xx-rwtm-mailbox.h

-- 
2.19.2

