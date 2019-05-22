Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355D2C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122E220644
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfEVGiP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:38:15 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:35426 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfEVGiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:38:15 -0400
Received: from marcel-macpro.fritz.box (p5B3D2A37.dip0.t-ipconnect.de [91.61.42.55])
        by mail.holtmann.org (Postfix) with ESMTPSA id AE754CF183;
        Wed, 22 May 2019 08:46:31 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Revert "Bluetooth: Align minimum encryption key size for
 LE and BR/EDR connections"
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190522052002.10411-1-anarsoul@gmail.com>
Date:   Wed, 22 May 2019 08:38:12 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6BD1D3F7-E2F2-4B2D-9479-06E27049133C@holtmann.org>
References: <20190522052002.10411-1-anarsoul@gmail.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vasily,

> This reverts commit d5bb334a8e171b262e48f378bd2096c0ea458265.
> 
> This commit breaks some HID devices, see [1] for details
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=203643
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Cc: stable@vger.kernel.org

let me have a look at this. Maybe there is a missing initialization for older HID devices that we need to handle. Do you happen to have the full btmon binary trace from controller initialization to connection attempt for me?

Are both devices Bluetooth 2.1 or later device that are supporting Secure Simple Pairing? Or is one of them a Bluetooth 2.0 or earlier device?

Regards

Marcel

