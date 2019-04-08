Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E13BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6532083E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbfDHStE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:49:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:49134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfDHStE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:49:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2564FADE2;
        Mon,  8 Apr 2019 18:49:02 +0000 (UTC)
Date:   Mon, 8 Apr 2019 20:48:47 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     David Miller <davem@davemloft.net>
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        dmitry.torokhov@gmail.com, lee.jones@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/6] MIPS: SGI-IP27: remove setup of RTC platform device
Message-Id: <20190408204847.d9f0c870a690aec8179f0615@suse.de>
In-Reply-To: <20190408.100528.608078178525055072.davem@davemloft.net>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
        <20190408142100.27618-3-tbogendoerfer@suse.de>
        <20190408.100528.608078178525055072.davem@davemloft.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Apr 2019 10:05:28 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Date: Mon,  8 Apr 2019 16:20:54 +0200
> 
> > RTC platform device will be setup by new IOC3 MFD driver, therefore
> > remove it from IP27 platform code.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> 
> You cannot break the driver like this.
> 
> Your patch series must be fully bisectable, which means that after
> this patch is applied things still must continue working properly.

I see your point and the ethernet driver itself will work properly, but of
course IP27 will be working again after applying the whole series. One
way I can see to solve this to also add the addition of the serial driver
into it. Then we are on par with the current driver. Does this solve your
concern ?

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
