Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C96C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349292173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbfLLS56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:57:58 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:42650 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbfLLS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:57:58 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5B71E153DFA32;
        Thu, 12 Dec 2019 10:57:57 -0800 (PST)
Date:   Thu, 12 Dec 2019 10:57:56 -0800 (PST)
Message-Id: <20191212.105756.1578737891054881785.davem@davemloft.net>
To:     cristian.birsan@microchip.com
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: Fix suspend/resume PHY register
 access error
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191212115247.26728-1-cristian.birsan@microchip.com>
References: <20191212115247.26728-1-cristian.birsan@microchip.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 12 Dec 2019 10:57:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>
Date: Thu, 12 Dec 2019 13:52:47 +0200

> Lan78xx driver accesses the PHY registers through MDIO bus over USB
> connection. When performing a suspend/resume, the PHY registers can be
> accessed before the USB connection is resumed. This will generate an
> error and will prevent the device to resume correctly.
> This patch adds the dependency between the MDIO bus and USB device to
> allow correct handling of suspend/resume.
> 
> Fixes: ce85e13ad6ef ("lan78xx: Update to use phylib instead of mii_if_info.")
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>

Applied and queued up for -stable.
