Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08AEC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A0821850
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfDWRJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:09:11 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:59645 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfDWRJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:09:10 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id A91B5CF2E8;
        Tue, 23 Apr 2019 19:17:19 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Bluetooth: btbcm: Add default address for BCM43341B
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190409141550.19458-1-ftoth@exalondelft.nl>
Date:   Tue, 23 Apr 2019 19:09:08 +0200
Cc:     andriy.shevchenko@linux.intel.com, Daniel Wagner <wagi@monom.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <4A3856F7-29F1-47A9-BFDB-B4B07E9BA720@holtmann.org>
References: <20190409141550.19458-1-ftoth@exalondelft.nl>
To:     Ferry Toth <ftoth@exalondelft.nl>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ferry,

> The BCM43341B has the default MAC address 43:34:1B:00:1F:AC if none
> is given. This address was found when enabling Bluetooth on multiple
> Intel Edison modules. It also contains the sequence 43341B, the name
> the chip identifies itself as. Using the same BD_ADDR is problematic
> when having multiple Intel Edison modules in each others range.
> The default address also has the LAA (locally administered address)
> bit set which prevents a BNEP device from being created, needed for
> BT tethering.
> 
> Add this to the list of black listed default MAC addresses and let
> the user configure a valid one using f.i.
> `btmgmt -i hci0 public-addr xx:xx:xx:xx:xx:xx`
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> ---
> drivers/bluetooth/btbcm.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

