Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F060C00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7B02086D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfCBSwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:52:22 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:50894 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfCBSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:52:20 -0500
Received: from marcel-macpro.fritz.box (p4FF9F361.dip0.t-ipconnect.de [79.249.243.97])
        by mail.holtmann.org (Postfix) with ESMTPSA id F141DCEE16;
        Sat,  2 Mar 2019 20:00:14 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH RESEND v2] Bluetooth: mediatek: add support for MediaTek
 MT7663U and MT7668U UART devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <35cb9acf1c5604e1d975efe9186879fc826fbe2f.1551551989.git.sean.wang@mediatek.com>
Date:   Sat, 2 Mar 2019 19:52:18 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <826E5A6F-3429-416D-B4F4-DE3F6349D7FF@holtmann.org>
References: <35cb9acf1c5604e1d975efe9186879fc826fbe2f.1551551989.git.sean.wang@mediatek.com>
To:     sean.wang@mediatek.com
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> This adds the support of enabling MT7663U and MT7668U Bluetooth function
> running on the top of btmtkuart driver.
> 
> There are a few differences between MT766[3,8]U and MT7622 where
> MT766[3,8]U are standalone devices based on UART transport while MT7622
> bluetooth is a built-in device on MediaTek SoC communicating with the host
> through BTIF serial transport. Thus, extra setup sequence is necessary
> for these standalone devices such as remote regulator and reset control via
> GPIO, baud rate changing handshake between the host and device and so on.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtkuart.c | 281 ++++++++++++++++++++++++++++++++--
> 1 file changed, 271 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

