Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A582087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCMQzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:55:02 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:43660 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfCMQzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:55:01 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 18D594C9B1;
        Wed, 13 Mar 2019 17:54:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id gZ_X3-KEJclM; Wed, 13 Mar 2019 17:54:44 +0100 (CET)
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in
 spi-mt7621.c
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     Armando Miraglia <arma2ff0@gmail.com>, NeilBrown <neil@brown.name>,
        Armando Miraglia <armax@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sankalpnegi2310@gmail.com, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190313122403.248873-1-armax@google.com>
 <eb85ea17-babd-fe3a-f0ff-9c7f13498bd1@gmail.com>
 <CAJsYDVKF-3jZo4E3EMiYOqeWXVLu0hBra6Qp0sFoCz8y=BAjSw@mail.gmail.com>
 <4789d739-d2b5-357b-b9d8-bfaf587d33fc@gmail.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <4172ce05-8dfc-c956-6af0-47c8367c215e@denx.de>
Date:   Wed, 13 Mar 2019 17:54:43 +0100
MIME-Version: 1.0
In-Reply-To: <4789d739-d2b5-357b-b9d8-bfaf587d33fc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.19 17:46, Matthias Brugger wrote:
> 
> 
> On 13/03/2019 17:34, Chuanhong Guo wrote:
>> Hi!
>> On Wed, Mar 13, 2019 at 8:28 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>>>
>>>
>>>
>>> On 13/03/2019 13:24, Armando Miraglia wrote:
>>> [...]
>>> Apart from fixing styling issues it would be usefull to see if we can add
>>> support for mt7621 to drivers/spi/spi-mt65xx.c
>> It's impossible. They are completely different IPs.
> 
> Thanks for the info. Do you know the status of the rest of the drivers in staging?

Just to inform you. We are using this SPI driver from staging
in one of our customer projects and I will try to move this
driver out of staging into drivers/spi very shortly.

Thanks,
Stefan
