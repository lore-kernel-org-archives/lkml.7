Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C9C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03AD218B8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfGFKvL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:51:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38879 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGFKvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:51:08 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 38CFFCF12E;
        Sat,  6 Jul 2019 12:59:38 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: serdev: hci_ll: set operational frequency
 earlier
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190702141337.10528-1-philipp.puschmann@emlix.com>
Date:   Sat, 6 Jul 2019 12:51:06 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7AB980EF-D99E-4211-A07A-5A891112144F@holtmann.org>
References: <20190702141337.10528-1-philipp.puschmann@emlix.com>
To:     Philipp Puschmann <philipp.puschmann@emlix.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

> Uploading the firmware needs quite a few seconds if done at 115200 kbps. So set
> the operational frequency, usually 3 MHz, before uploading the firmware.
> 
> I have successfully tested this with a wl1837mod.
> 
> Signed-off-by: Philipp Puschmann <philipp.puschmann@emlix.com>
> ---
> drivers/bluetooth/hci_ll.c | 39 ++++++++++++++++++++------------------
> 1 file changed, 21 insertions(+), 18 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

