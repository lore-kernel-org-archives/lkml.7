Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEEEC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9B420881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfENWIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:08:07 -0400
Received: from mx.allycomm.com ([138.68.30.55]:43247 "EHLO mx.allycomm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfENWIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:08:07 -0400
Received: from jkletsky-mbp15.guidewire.com (inet.guidewire.com [199.91.42.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.allycomm.com (Postfix) with ESMTPSA id 34FB83B926;
        Tue, 14 May 2019 15:08:06 -0700 (PDT)
Subject: Re: [PATCH] mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <20190510121727.29834-1-lede@allycomm.com>
 <3cb32209-f246-e562-2aee-fdf566a60b30@kontron.de>
 <1023ba21-b188-1dcc-3ecc-c563d4cb8a67@allycomm.com>
 <e53a0569-6eca-4385-007d-baffc3f5c7ea@kontron.de>
 <20190514220136.5f4624ee@xps13>
From:   Jeff Kletsky <lede@allycomm.com>
Message-ID: <e38f0f4b-1881-0e2f-22ad-5f5c4fccaa4b@allycomm.com>
Date:   Tue, 14 May 2019 15:08:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514220136.5f4624ee@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/19 1:01 PM, Miquel Raynal wrote:

> Hi Schrempf,
>
> Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Tue, 14 May
> 2019 16:11:28 +0000:
>
>> Hi Jeff,
>>
>> On 14.05.19 17:42, Jeff Kletsky wrote:
>>> On 5/13/19 6:56 AM, Schrempf Frieder wrote:
>>>    
>>>> Hi Jeff,
>>>>
>>>> [...]
>>>> Maybe it would be better to split this patch into three parts:
>>>> * Add support for two-byte device IDs
>>>> * Add #define-s for three-byte addressing for read ops
>>>> * Add support for GD5F1GQ4UFxxG
>>>>
>>>> Anyway the content looks good to me, so:
>>>>
>>>> Reviewed-by: Frieder Schrempf<frieder.schrempf@kontron.de>
>>>>
>>>> [...]
>>> [...]
> I agree with Frieder, if you don't mind, please split this commit in
> three.
>
> Thanks,
> Miquèl
>
Split and superseded by
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=107874

Jeff

