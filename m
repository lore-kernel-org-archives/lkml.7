Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D07CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A399121D7C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfJSWNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 18:13:30 -0400
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:48808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbfJSWNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 18:13:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 60D29181D2FC9;
        Sat, 19 Oct 2019 22:13:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pull40_1de9676909547
X-Filterd-Recvd-Size: 2185
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Oct 2019 22:13:25 +0000 (UTC)
Message-ID: <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
Subject: Re: coccinelle: api/devm_platform_ioremap_resource: remove useless
 script
From:   Joe Perches <joe@perches.com>
To:     Marc Zyngier <maz@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>
Date:   Sat, 19 Oct 2019 15:13:24 -0700
In-Reply-To: <868spgzcti.wl-maz@kernel.org>
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr>
         <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de>
         <868spgzcti.wl-maz@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-19 at 21:43 +0100, Marc Zyngier wrote:
> Providing Coccinelle scripts that scream about perfectly valid code is
> pointless, and the result is actively harmful.

Doubtful.

If the new code is smaller object code and correct
than the conversion is worthwhile.

fyi:

There are already ~450 uses of this function and maybe
~800 possible additional conversions.

> If said script was providing a correct semantic patch instead of being
> an incentive for people to churn untested patches that span the whole
> tree, that'd be a different story.

Right.


