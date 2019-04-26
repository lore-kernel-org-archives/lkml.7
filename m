Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDA0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424E82084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfDZPeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:34:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37766 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfDZPeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:21 -0400
Received: from localhost (unknown [12.154.31.190])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7153E145E74FB;
        Fri, 26 Apr 2019 08:34:20 -0700 (PDT)
Date:   Fri, 26 Apr 2019 11:34:18 -0400 (EDT)
Message-Id: <20190426.113418.432887547498785267.davem@davemloft.net>
To:     linux@roeck-us.net
Cc:     linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbnet: ipheth: Simplify device detection
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1556128704-10831-1-git-send-email-linux@roeck-us.net>
References: <1556128704-10831-1-git-send-email-linux@roeck-us.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 26 Apr 2019 08:34:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 24 Apr 2019 10:58:24 -0700

> All Apple products use the same protocol for tethering over USB.
> To simplify the code and make it future proof, use
> USB_VENDOR_AND_INTERFACE_INFO() instead of
> USB_DEVICE_AND_INTERFACE_INFO() to automatically detect and support
> all existing and future Apple products using the same interface.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to net-next, thanks.
