Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC09CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AC420879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDHS6j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:58:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:52000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725983AbfDHS6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:58:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD873AD78;
        Mon,  8 Apr 2019 18:58:36 +0000 (UTC)
Date:   Mon, 8 Apr 2019 20:58:35 +0200
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
Message-Id: <20190408205835.9b6f29b17d8ccb17c70d712d@suse.de>
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

sorry didn't realize your are talking about RTC. I'll check, if there
is a chance to move after the MFD driver addition.

Thomas.

-- 
SUSE Linux GmbH
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
