Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44500C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1787D217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfDWQgy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:36:54 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55193 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbfDWQgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:36:52 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id BD661CF2DA;
        Tue, 23 Apr 2019 18:45:00 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v1 0/4] Add a couple of enhancements to btmtksdio
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cover.1555577565.git.sean.wang@mediatek.com>
Date:   Tue, 23 Apr 2019 18:36:49 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <43F9EB53-7994-4727-948D-29D455C4F19B@holtmann.org>
References: <cover.1555577565.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> First three are all minor changes and the final one adds a runtime pm support to
> enter a lower power state for decreasing power dissipation when there is idle
> traffic in SDIO transport for a while.
> 
> Sean Wang (4):
>  Bluetooth: btmtksdio: Drop newline with bt_dev logging macros
>  Bluetooth: btmtksdio: Add a bit definition for CHLPCR
>  Bluetooth: btmtksdio: Fix hdev->stat.byte_rx accumulation
>  Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth
> 
> drivers/bluetooth/btmtksdio.c | 161 ++++++++++++++++++++++++++++++++--
> 1 file changed, 153 insertions(+), 8 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

