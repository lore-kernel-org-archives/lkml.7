Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCFA20838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfCBQu3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:50:29 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:57728 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCBQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:50:29 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id ED825CF352;
        Sat,  2 Mar 2019 17:58:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v2 0/2] Bluetooth: mediatek: add support for MediaTek
 MT7663U and MT7668U UART devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cover.1551405664.git.sean.wang@mediatek.com>
Date:   Sat, 2 Mar 2019 17:50:26 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <172BBF8E-16EC-4DF8-99D6-B991FADA91B6@holtmann.org>
References: <cover.1551405664.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> v2: changes since v1
> - add Rob's review tag
> - removed these merged patches
> 
> This adds the support of enabling MT7668U and MT7663U UART based Bluetooth
> function running on the top of btmtkuart driver.
> 
> We are through several patches to reach the goal and also wish applied
> the same flow in MediaTek btusb [1] for the transport independence.
> Once [1] and the series is being merged and then in next step I will
> consider to add a btmtk.c to hold these independent operations among
> various transport reused by MediaTek UART, USB and SDIO-based Bluetooth.
> 
> Firstly,
> in patch 1/6 to update the dt-binding document for the kind of devices.
> in patch 2/6, 3/6 to fix the common error issues in the current code.
> in Patch 4/6, 5/6 to add the general flow which MT7622 and even MT7663U and
> MT7668U USB devices also utilize.
> 
> Finally, in patch 6/6 to add the specific setups for MediaTek UART-based
> Bluetooth and enable MT7663U and MT7668U device.
> 
> [1] http://lists.infradead.org/pipermail/linux-mediatek/2019-January/017074.html 
> 
> Sean Wang (2):
>  dt-bindings: net: bluetooth: add support for MediaTek MT7663U and
>    MT7668U UART devices
>  Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART
>    devices
> 
> .../bindings/net/mediatek-bluetooth.txt       |  64 ++++
> drivers/bluetooth/btmtkuart.c                 | 281 +++++++++++++++++-
> 2 files changed, 335 insertions(+), 10 deletions(-)

I applied patch 1/2 but it seems patch 2/2 is missing. Please re-send.

Regards

Marcel

