Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82901C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C617214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCKXKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:10:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:35614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbfCKXKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:10:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0FA2EB15E;
        Mon, 11 Mar 2019 23:09:59 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 12 Mar 2019 10:09:36 +1100
Subject: [PATCH 0/2] staging: remove mt7621-eth
Cc:     devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>
Message-ID: <155234569479.4958.3984850739390042194.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/ethernet/mediatek/ now supports the mt7621
ethernet controller.
So we can remove the drivers/staging driver, and update
the devicetree file to work with this driver.

NeilBrown

---

NeilBrown (2):
      staging: remove mt7621-eth
      staging: mt7621-dts: update ethernet settings.


 drivers/staging/Kconfig                            |    2 
 drivers/staging/Makefile                           |    1 
 drivers/staging/mt7621-dts/gbpc1.dts               |   29 
 drivers/staging/mt7621-dts/mt7621.dtsi             |   73 +
 .../devicetree/bindings/net/mediatek-net-gsw.txt   |   48 
 drivers/staging/mt7621-eth/Kconfig                 |   39 
 drivers/staging/mt7621-eth/Makefile                |   14 
 drivers/staging/mt7621-eth/TODO                    |   13 
 drivers/staging/mt7621-eth/ethtool.c               |  250 --
 drivers/staging/mt7621-eth/ethtool.h               |   15 
 drivers/staging/mt7621-eth/gsw_mt7620.h            |  277 ---
 drivers/staging/mt7621-eth/gsw_mt7621.c            |  297 ---
 drivers/staging/mt7621-eth/mdio.c                  |  275 ---
 drivers/staging/mt7621-eth/mdio.h                  |   27 
 drivers/staging/mt7621-eth/mdio_mt7620.c           |  173 --
 drivers/staging/mt7621-eth/mtk_eth_soc.c           | 2176 --------------------
 drivers/staging/mt7621-eth/mtk_eth_soc.h           |  716 -------
 drivers/staging/mt7621-eth/soc_mt7621.c            |  161 -
 18 files changed, 83 insertions(+), 4503 deletions(-)
 delete mode 100644 drivers/staging/mt7621-eth/Documentation/devicetree/bindings/net/mediatek-net-gsw.txt
 delete mode 100644 drivers/staging/mt7621-eth/Kconfig
 delete mode 100644 drivers/staging/mt7621-eth/Makefile
 delete mode 100644 drivers/staging/mt7621-eth/TODO
 delete mode 100644 drivers/staging/mt7621-eth/ethtool.c
 delete mode 100644 drivers/staging/mt7621-eth/ethtool.h
 delete mode 100644 drivers/staging/mt7621-eth/gsw_mt7620.h
 delete mode 100644 drivers/staging/mt7621-eth/gsw_mt7621.c
 delete mode 100644 drivers/staging/mt7621-eth/mdio.c
 delete mode 100644 drivers/staging/mt7621-eth/mdio.h
 delete mode 100644 drivers/staging/mt7621-eth/mdio_mt7620.c
 delete mode 100644 drivers/staging/mt7621-eth/mtk_eth_soc.c
 delete mode 100644 drivers/staging/mt7621-eth/mtk_eth_soc.h
 delete mode 100644 drivers/staging/mt7621-eth/soc_mt7621.c

--
Signature

