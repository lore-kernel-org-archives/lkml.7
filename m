Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD91C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AAE2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfCACOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:14:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:30270 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725896AbfCACOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:14:18 -0500
X-UUID: e8fb2f54fddb4f34a4ce6f51c673252e-20190301
X-UUID: e8fb2f54fddb4f34a4ce6f51c673252e-20190301
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1578556314; Fri, 01 Mar 2019 10:14:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Mar 2019 10:14:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Mar 2019 10:14:10 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 0/2] Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART devices
Date:   Fri, 1 Mar 2019 10:14:06 +0800
Message-ID: <cover.1551405664.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

v2: changes since v1
- add Rob's review tag
- removed these merged patches

This adds the support of enabling MT7668U and MT7663U UART based Bluetooth
function running on the top of btmtkuart driver.

We are through several patches to reach the goal and also wish applied
the same flow in MediaTek btusb [1] for the transport independence.
Once [1] and the series is being merged and then in next step I will
consider to add a btmtk.c to hold these independent operations among
various transport reused by MediaTek UART, USB and SDIO-based Bluetooth.

Firstly,
in patch 1/6 to update the dt-binding document for the kind of devices.
in patch 2/6, 3/6 to fix the common error issues in the current code.
in Patch 4/6, 5/6 to add the general flow which MT7622 and even MT7663U and
MT7668U USB devices also utilize.

Finally, in patch 6/6 to add the specific setups for MediaTek UART-based
Bluetooth and enable MT7663U and MT7668U device.

[1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html 

Sean Wang (2):
  dt-bindings: net: bluetooth: add support for MediaTek MT7663U and
    MT7668U UART devices
  Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART
    devices

 .../bindings/net/mediatek-bluetooth.txt       |  64 ++++
 drivers/bluetooth/btmtkuart.c                 | 281 +++++++++++++++++-
 2 files changed, 335 insertions(+), 10 deletions(-)

-- 
2.18.0

