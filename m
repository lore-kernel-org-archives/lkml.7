Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C0FC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADC6206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 10:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfEBKZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 06:25:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:32860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbfEBKZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 06:25:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C0C1ADF0;
        Thu,  2 May 2019 10:25:38 +0000 (UTC)
Subject: Re: [PATCH] clk: actions: Use the correct style for SPDX License
 Identifier
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
References: <20190501070707.GA5619@nishad>
 <057d9b37-7475-1902-bce7-6d519c2e0fdf@suse.de>
 <20190502070746.GA16247@kroah.com>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <315de620-b638-aea4-d8d2-e00f5a493625@suse.de>
Date:   Thu, 2 May 2019 12:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502070746.GA16247@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.05.19 um 09:07 schrieb Greg Kroah-Hartman:
> On Wed, May 01, 2019 at 10:20:44PM +0200, Andreas Färber wrote:
>> + linux-actions
>>
>> Am 01.05.19 um 09:07 schrieb Nishad Kamdar:
>>> This patch corrects the SPDX License Identifier style
>>> in header files related to Clock Drivers for Actions Semi Socs.
>>> For C header files Documentation/process/license-rules.rst
>>> mandates C-like comments (opposed to C source files where
>>> C++ style should be used)
>> [...]
>>>  drivers/clk/actions/owl-common.h       | 2 +-
>>>  drivers/clk/actions/owl-composite.h    | 2 +-
>>>  drivers/clk/actions/owl-divider.h      | 2 +-
>>>  drivers/clk/actions/owl-factor.h       | 2 +-
>>>  drivers/clk/actions/owl-fixed-factor.h | 2 +-
>>>  drivers/clk/actions/owl-gate.h         | 2 +-
>>>  drivers/clk/actions/owl-mux.h          | 2 +-
>>>  drivers/clk/actions/owl-pll.h          | 2 +-
>>>  drivers/clk/actions/owl-reset.h        | 2 +-
>>>  9 files changed, 9 insertions(+), 9 deletions(-)
>>
>> Where's the practical benefit of this patch? These are all private
>> headers used from C files, so they can handle C++ comments just fine,
>> otherwise we would've seen build failures.
> 
> Please read Documentation/process/license-rules.rst, the section
> entitled "Style", for what the documented formats are for SPDX lines,
> depending on the file type.

That does in no way answer my question! You conveniently dropped my
paragraph indicating that I understand why we would do that for public
headers in include/, but none of these private headers here are included
in .lds files. So there really seems to be no benefit of switching from
one style to another for in-tree code.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
