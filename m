Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04920C04AA8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1394205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfEAUUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:20:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48656 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfEAUUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:20:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EB1BAD12;
        Wed,  1 May 2019 20:20:45 +0000 (UTC)
Subject: Re: [PATCH] clk: actions: Use the correct style for SPDX License
 Identifier
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
References: <20190501070707.GA5619@nishad>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <057d9b37-7475-1902-bce7-6d519c2e0fdf@suse.de>
Date:   Wed, 1 May 2019 22:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501070707.GA5619@nishad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-actions

Am 01.05.19 um 09:07 schrieb Nishad Kamdar:
> This patch corrects the SPDX License Identifier style
> in header files related to Clock Drivers for Actions Semi Socs.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used)
[...]
>  drivers/clk/actions/owl-common.h       | 2 +-
>  drivers/clk/actions/owl-composite.h    | 2 +-
>  drivers/clk/actions/owl-divider.h      | 2 +-
>  drivers/clk/actions/owl-factor.h       | 2 +-
>  drivers/clk/actions/owl-fixed-factor.h | 2 +-
>  drivers/clk/actions/owl-gate.h         | 2 +-
>  drivers/clk/actions/owl-mux.h          | 2 +-
>  drivers/clk/actions/owl-pll.h          | 2 +-
>  drivers/clk/actions/owl-reset.h        | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)

Where's the practical benefit of this patch? These are all private
headers used from C files, so they can handle C++ comments just fine,
otherwise we would've seen build failures.

I could understand if you were patching files in include/ but not here.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
