Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D1EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BE220863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfCRRRl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:17:41 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32905 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCRRRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:17:41 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 0EF0ECF174;
        Mon, 18 Mar 2019 18:25:40 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1 0/3] add module_sdio_driver and enable a few users
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cover.1552510141.git.sean.wang@mediatek.com>
Date:   Mon, 18 Mar 2019 18:17:39 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, ulf.hansson@linaro.org,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D233C009-8EA4-4C47-9CB3-A26C74C200D1@holtmann.org>
References: <cover.1552510141.git.sean.wang@mediatek.com>
To:     sean.wang@mediatek.com
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Add module_sdio_driver exactly like the function module_usb_drivear offers to
> and enable a few users to eliminate a few lines of boilerplate code per SDIO
> driver.
> 
> Sean Wang (3):
>  mmc: sdio: Add helper macro for sdio_driver boilerplate
>  Bluetooth: mediatek: Use module_sdio_driver helper
>  Bluetooth: btsdio: Use module_sdio_driver helper
> 
> drivers/bluetooth/btmtksdio.c | 15 +--------------
> drivers/bluetooth/btsdio.c    | 15 +--------------
> include/linux/mmc/sdio_func.h | 12 ++++++++++++
> 3 files changed, 14 insertions(+), 28 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

