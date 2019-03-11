Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18DFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71B6205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbfCKQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:38:56 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:54423 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfCKQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:38:55 -0400
Received: from marcel-macpro.fritz.box (p4FEFC449.dip0.t-ipconnect.de [79.239.196.73])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7DEE7CF2CA;
        Mon, 11 Mar 2019 17:46:51 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v1 1/2] mmc: add SDIO identifiers for MediaTek Bluetooth
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <97d7949c00bd78f8ec282fb9cd380ad161244616.1552007059.git.sean.wang@mediatek.com>
Date:   Mon, 11 Mar 2019 17:38:52 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, ulf.hansson@linaro.org,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7C99941A-306E-4233-9EA4-5D681308C490@holtmann.org>
References: <cover.1552007058.git.sean.wang@mediatek.com>
 <97d7949c00bd78f8ec282fb9cd380ad161244616.1552007059.git.sean.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> The SDIO identifier for MediaTek Bluetooth devices were defined in the
> MediaTek Bluetooth driver. Moving the definitions in MMC header file
> seems common sense.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> include/linux/mmc/sdio_ids.h | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Can we also update the sdio.ids database inside systemd.

https://github.com/systemd/systemd/blob/master/hwdb/sdio.ids

Regards

Marcel

