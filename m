Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DCCCA9EBC
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 05:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273C120578
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 05:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfJZF1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 01:27:05 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46915 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfJZF1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 01:27:05 -0400
Received: from [172.20.19.11] (unknown [213.61.67.157])
        by mail.holtmann.org (Postfix) with ESMTPSA id BBE06CED0D;
        Sat, 26 Oct 2019 07:36:04 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH -next] Bluetooth: btrtl: remove unneeded semicolon
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191025092653.30428-1-yuehaibing@huawei.com>
Date:   Sat, 26 Oct 2019 07:27:03 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5D6A13BC-0E81-4AA6-B375-B7B762B93BD3@holtmann.org>
References: <20191025092653.30428-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

> Remove unneeded semicolon.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> drivers/bluetooth/btrtl.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

