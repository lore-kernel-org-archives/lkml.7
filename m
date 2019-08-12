Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A41C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5931120679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfHLQde convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:33:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45039 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfHLQde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:33:34 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 664B7CECF3;
        Mon, 12 Aug 2019 18:42:13 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v2] Bluetooth: btusb: Fix suspend issue for Realtek
 devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190802120217.GA8712@toshiba>
Date:   Mon, 12 Aug 2019 18:33:31 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Chou <max.chou@realtek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <A83A0A38-8AC8-4662-BBC1-3B48B707E97B@holtmann.org>
References: <20190802120217.GA8712@toshiba>
To:     Alex Lu <alex_lu@realsil.com.cn>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> From the perspective of controller, global suspend means there is no
> SET_FEATURE (DEVICE_REMOTE_WAKEUP) and controller would drop the
> firmware. It would consume less power. So we should not send this kind
> of SET_FEATURE when host goes to suspend state.
> Otherwise, when making device enter selective suspend, host should send
> SET_FEATURE to make sure the firmware remains.
> 
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> ---
> drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++++++++++++----
> 1 file changed, 30 insertions(+), 4 deletions(-)

this one doesn’t apply cleanly to bluetooth-next. Can you please send a version that does.

Regards

Marcel

