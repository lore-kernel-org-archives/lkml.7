Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC5FC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 11:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344E3214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 11:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfGFLBM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 07:01:12 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37516 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGFLBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 07:01:11 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 1D63CCEFAE;
        Sat,  6 Jul 2019 13:09:41 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v1 0/4] add boot-gpios and clock property to btmtkuart
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1559437457-26766-1-git-send-email-sean.wang@mediatek.com>
Date:   Sat, 6 Jul 2019 13:01:08 +0200
Cc:     Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1E60D580-3D91-4AF0-8CCC-4576C54D2258@holtmann.org>
References: <1559437457-26766-1-git-send-email-sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Update dt-binding and the corresponding implmentation of boot-gpios and clock
> property to btmtkuart.
> 
> Sean Wang (4):
>  dt-bindings: net: bluetooth: add boot-gpios property to UART-based
>    device
>  dt-bindings: net: bluetooth: add clock property to UART-based device
>  Bluetooth: btmtkuart: add an implementation for boot-gpios property
>  Bluetooth: btmtkuart: add an implementation for clock osc property
> 
> .../bindings/net/mediatek-bluetooth.txt       | 17 +++++++
> drivers/bluetooth/btmtkuart.c                 | 51 +++++++++++++++----
> 2 files changed, 58 insertions(+), 10 deletions(-)

all four patches have been applied to bluetooth-next tree.

Regards

Marcel

