Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00865C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17D22070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfFQQi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:38:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:60244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725863AbfFQQiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:38:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8CE35AE54;
        Mon, 17 Jun 2019 16:38:54 +0000 (UTC)
Subject: Re: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, devicetree@vger.kernel.org,
        linus.walleij@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
 <20190617163015.GD5316@sirena.org.uk>
 <20190617163413.GA16152@Mani-XPS-13-9360>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <a38d26d1-213c-31ef-9cc7-1d4bdda4ceab@suse.de>
Date:   Mon, 17 Jun 2019 18:38:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617163413.GA16152@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 17.06.19 um 18:34 schrieb Manivannan Sadhasivam:
> On Mon, Jun 17, 2019 at 05:30:15PM +0100, Mark Brown wrote:
>> On Mon, Jun 17, 2019 at 09:20:10PM +0530, Manivannan Sadhasivam wrote:
>>
>>> +++ b/drivers/regulator/atc260x-regulator.c
>>> @@ -0,0 +1,389 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Regulator driver for ATC260x PMICs
>>
>> Please make the entire comment a C++ one so this looks more intentional.

No, this is intentional and the official style requested by GregKH.

He suggested I patch the SPDX documentation to make this clearer, but I
did not find time for this yet (and am not the one making this rule).

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
