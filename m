Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F185DC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84D22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 20:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfFQUVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:21:23 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55577 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfFQUVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 16:21:23 -0400
Received: from [192.168.1.110] ([77.2.173.233]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MekrN-1iAeRt2PkD-00ajfZ; Mon, 17 Jun 2019 22:21:08 +0200
Subject: Re: [PATCH] drivers: Inline code in devm_platform_ioremap_resource()
 from two functions
To:     Markus Elfring <Markus.Elfring@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     cocci@systeme.lip6.fr, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
 <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
 <032e347f-e575-c89c-fa62-473d52232735@web.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <910a5806-9a08-adf4-4fba-d5ec2f5807ff@metux.net>
Date:   Mon, 17 Jun 2019 22:21:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <032e347f-e575-c89c-fa62-473d52232735@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:K5hGr7aDqN0OiD+j1BM/crsHbtdWkEiMkJveIo+Dzl/CLujnQAj
 5FroUnxU9FmzU4e3pM00kbhMxXtfzw3KBr/v8HQimfFjjti/8q3/bJNqoLbLQykYnS63Ivd
 f4g8n6pSMr05CBNmmyc84n4a/lEv3TAFV+C+8Msj+qnJMG+Kxak9rQDKtkgZuPRnsisEjqS
 n9N+AfJ2kqJV3Is7dtJ2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e4k+1UwuPpo=:pj4CdOIblCwSg8VC4aJl1l
 FITRwIlP0W6nc0gM1RzkgDuy0iFLEdXy2Pa4xhNkOnSY3dyoChSW78Y2saH9bzgr52viKms2+
 M33GE2TkDasOC8haG7j0zalrTirIclBUDsHdPKoGJPuTStXjwqa5qmNpSDhdWK38pJk/RV2Kp
 /GccJPSdVqacRQM7JTnh0jZQBds7UOhkn7cvk3ZkhgW3uIhLFxtnUyuF0rdJqxdeeUmJQ/GAc
 WxnNpa+cIc1gTBnOCwR7koFQK3ogiMM37hI1gI8I72TcrL0rj9B0DosmH2XmVmdjMcAlZ4u2n
 pwcjFn+t017QK5gMe51At24oFBfjRi/MhWTufUJvx9OIutEjiJZ2kof70gk/2N8RuZQA6FqJZ
 fQ6IaRRwwfxLQag3r9720gXWDfqne0TV+G68GSebAGgrZCsOKGESUBbzfavLkflcjRu4J+GL4
 CofipRYcSPzzrI0uGTCwRv9dfyn9DtpzTYGHxglzw+8qslcPh9klc2KYd6eatZjRUgiFmuQw6
 x7iKx3Q7rzo/XQ2wI2V0+s1lLCUvyvHZWsbH8jYNEiLlaJthgPN7pByOwEThLuC8HFiOdZ3qT
 upMNtQqxBe2PpRZtiIreb9Baz8LyOgx+IJOG4r2r4ciDHFf3Oz/SrUs2sxwDap/kwhPAXOHRa
 ii1b9XLsSPz6TA8ck7vz+Ee8HhU91iCVyokEAlkXGMljAokSKNo1w+zOKzi/vvqdOGkC/2C0G
 Uy8+l1fb11ahE7k85/i2K+vZW+BubgUHZp9Go6Bz1JSv0M+SDcQnhKA2aN8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.19 11:22, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 14 Jun 2019 11:05:33 +0200
> 
> Two function calls were combined in this function implementation.
> Inline corresponding code so that extra error checks can be avoided here.

What exactly is the purpose of this ?

Looks like a notable code duplication ... I thought we usually try to
reduce this, instead of introducing new ones.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
