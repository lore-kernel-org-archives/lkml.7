Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA0BC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B6620656
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfHOGqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 02:46:30 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:45493 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHOGqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 02:46:30 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 3E33BCED13;
        Thu, 15 Aug 2019 08:55:10 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: 6lowpan: Make variable header_ops constant
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190815055255.1153-1-nishkadg.linux@gmail.com>
Date:   Thu, 15 Aug 2019 08:46:27 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4E787A5C-3B2E-4056-8392-94193C9616C0@holtmann.org>
References: <20190815055255.1153-1-nishkadg.linux@gmail.com>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishka,

> Static variable header_ops, of type header_ops, is used only once, when
> it is assigned to field header_ops of a variable having type net_device.
> This corresponding field is declared as const in the definition of
> net_device. Hence make header_ops constant as well to protect it from
> unnecessary modification.
> Issue found with Coccinelle.
> 
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> ---
> net/bluetooth/6lowpan.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

