Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14CAC468AD
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83664214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfGFK5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:57:25 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46734 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGFK5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:57:25 -0400
Received: from [192.168.0.113] (CMPC-089-239-107-172.CNet.Gawex.PL [89.239.107.172])
        by mail.holtmann.org (Postfix) with ESMTPSA id 36870CEFAE;
        Sat,  6 Jul 2019 13:05:55 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: btbcm: Add entry for BCM4359C0 UART bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190520134104.24575-1-narmstrong@baylibre.com>
Date:   Sat, 6 Jul 2019 12:57:22 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <26F7D7FD-4D59-4AAE-879B-11446F27B33B@holtmann.org>
References: <20190520134104.24575-1-narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> The BCM4359C0 BT/Wi-Fi compo chip needs an entry to be discovered
> by the btbcm driver.
> 
> Tested using an AP6398S module from Ampak.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> drivers/bluetooth/btbcm.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

