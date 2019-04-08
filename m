Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD42C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5786720880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfDHRFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:05:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37010 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfDHRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:05:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3E2FE14013D3B;
        Mon,  8 Apr 2019 10:05:29 -0700 (PDT)
Date:   Mon, 08 Apr 2019 10:05:28 -0700 (PDT)
Message-Id: <20190408.100528.608078178525055072.davem@davemloft.net>
To:     tbogendoerfer@suse.de
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        dmitry.torokhov@gmail.com, lee.jones@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/6] MIPS: SGI-IP27: remove setup of RTC platform device
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190408142100.27618-3-tbogendoerfer@suse.de>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
        <20190408142100.27618-3-tbogendoerfer@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 08 Apr 2019 10:05:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Date: Mon,  8 Apr 2019 16:20:54 +0200

> RTC platform device will be setup by new IOC3 MFD driver, therefore
> remove it from IP27 platform code.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

You cannot break the driver like this.

Your patch series must be fully bisectable, which means that after
this patch is applied things still must continue working properly.
