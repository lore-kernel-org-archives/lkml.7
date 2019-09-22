Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9034C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 06:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9098C20820
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 06:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfIVGEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 02:04:21 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39563 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfIVGEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 02:04:21 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46bcNM2b81z1rGSc;
        Sun, 22 Sep 2019 08:04:19 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46bcNM2M0Kz1qqkb;
        Sun, 22 Sep 2019 08:04:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id ufIv7I92wtW8; Sun, 22 Sep 2019 08:04:18 +0200 (CEST)
X-Auth-Info: 6uH5t34rFB92KUI6/Y+flphwb9TE9I1O5B8Cg2Rqy2c=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 22 Sep 2019 08:04:18 +0200 (CEST)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 5658E183633;
        Sun, 22 Sep 2019 08:04:04 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 37FEF1A0097; Sun, 22 Sep 2019 08:04:04 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/2] misc: add support for the cc1101 RF transceiver chip from TI
Date:   Sun, 22 Sep 2019 08:03:54 +0200
Message-Id: <20190922060356.58763-1-hs@denx.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver provides support for the Low-Power Sub-1 GHz RF
Transceiver chip from Texas Instruments. It provides a
simple message based protocol to set chip registers, send
and receive packets to/from the chip.


Heiko Schocher (2):
  misc: add cc1101 devicetree binding
  misc: add support for the cc1101 RF transceiver chip from TI

 .../devicetree/bindings/misc/cc1101.txt       |   27 +
 Documentation/misc-devices/cc1101.txt         |  446 ++++
 drivers/misc/Kconfig                          |   11 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/cc1101.c                         | 2004 +++++++++++++++++
 drivers/misc/cc1101.h                         |   89 +
 include/uapi/linux/cc1101_user.h              |  255 +++
 7 files changed, 2833 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/cc1101.txt
 create mode 100644 Documentation/misc-devices/cc1101.txt
 create mode 100644 drivers/misc/cc1101.c
 create mode 100644 drivers/misc/cc1101.h
 create mode 100644 include/uapi/linux/cc1101_user.h

-- 
2.21.0

