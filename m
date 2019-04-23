Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B23C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472A32148D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfDWRCX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:02:23 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47083 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfDWRCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:02:22 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id B2165CF2DA;
        Tue, 23 Apr 2019 19:10:31 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/1] Bluetooth: btmrvl: add support for SD8987 chipset
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190414183814.7620-1-tszucs@protonmail.ch>
Date:   Tue, 23 Apr 2019 19:02:20 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>,
        Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Rahul Tank <rahult@marvell.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <ABD7B540-AB30-423C-909E-BA6832E6329C@holtmann.org>
References: <20190414183814.7620-1-tszucs@protonmail.ch>
To:     =?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tamas,

> Changes here have been tested with u-blox JODY-W2XX and Marvell
> TB-AQB8987-QFN-EPA-2A. It would be great to have driver support upstream.
> Kindly review.
> 
> Kind regards,
> Tamas
> 
> Tamás Szűcs (1):
>  Bluetooth: btmrvl: add support for SD8987 chipset
> 
> drivers/bluetooth/Kconfig       |  4 ++--
> drivers/bluetooth/btmrvl_sdio.c | 36 ++++++++++++++++++++++++++++++++++++
> 2 files changed, 38 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

