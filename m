Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A70C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57CB204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfCNNYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:24:22 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:26528 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfCNNYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:24:22 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id D46F64CC39;
        Thu, 14 Mar 2019 14:24:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id saod4cv0iiA9; Thu, 14 Mar 2019 14:24:14 +0100 (CET)
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in
 spi-mt7621.c
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Armando Miraglia <arma2ff0@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Neil Brown <neil@brown.name>, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Sankalp Negi <sankalpnegi2310@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190313122403.248873-1-armax@google.com>
 <20190313123454.GB2202@kadam> <20190314111313.GB8034@google.com>
 <f620e4ef-3d9e-4230-30e8-5cc608710695@denx.de>
 <CAOcbMd3tfFiVjvPE+mvCjP22-a6oY2LJRig05PJPRAL4DvpCMA@mail.gmail.com>
 <96fb1765-971b-2329-bccd-88e0517f6f23@gmail.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <ae1cea3e-9790-1ce0-a43a-5cfe588a2fd6@denx.de>
Date:   Thu, 14 Mar 2019 14:24:11 +0100
MIME-Version: 1.0
In-Reply-To: <96fb1765-971b-2329-bccd-88e0517f6f23@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.03.19 14:14, Matthias Brugger wrote:
> 
> 
> On 14/03/2019 12:37, Armando Miraglia wrote:
>> Absolutely!
> 
> Please don't top post :)
> 
>>
>> Cheers,
>> A.
>>
>> On Thu, Mar 14, 2019 at 12:36 PM Stefan Roese <sr@denx.de> wrote:
> [...]
>>>
>>> Would it be possible for you to wait a bit with this minor cleanup?
>>> As I'm preparing a patch to move this driver out of staging right
>>> now. You can definitely follow-up with your cleanup, once this move
>>> is done. Otherwise the move might be delayed even more.
>>>
> 
> Hm but shouldn't style issues be a criteria for not accepting a move out of
> staging?

I would agree, if those style issues where non trivial. In the end we
are talking about one non-optimal identation now.

> I think so. You could add Armandos patch in your series or rebase your
> series against Greg's tree, once he took the clean-up. Normally Greg is
> incredibly fast :)

I should have included the history here to make this more clean. I've
started pulling this driver out of staging a few weeks ago:

https://patchwork.kernel.org/patch/10790537/
...

Here you find Greg's comment, that the style patches should be merged
first before the move out of staging. This is what I worked on after
this first patch series:

https://patchwork.kernel.org/patch/10792455/
...

Now these 9 style issue patches from me have been merged and I would
like to proceed with the driver move.

Thanks,
Stefan
