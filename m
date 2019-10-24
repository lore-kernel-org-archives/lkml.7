Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09EFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBB9205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438326AbfJXInl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:43:41 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44713 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfJXInl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:43:41 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iNYiY-0003Gf-LS; Thu, 24 Oct 2019 10:43:38 +0200
Message-ID: <cba736f135f150d685ab4efee625d69aa800d1c8.camel@pengutronix.de>
Subject: Re: [RFC] docs: add a reset controller chapter to the driver API
 docs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ramiro Oliveira <Ramiro.Oliveira@synopsys.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Date:   Thu, 24 Oct 2019 10:43:36 +0200
In-Reply-To: <8e964179-4515-33ea-bdc4-f27daa311267@infradead.org>
References: <20191022164547.22632-1-p.zabel@pengutronix.de>
         <8e964179-4515-33ea-bdc4-f27daa311267@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

thank you for the corrections!

On Tue, 2019-10-22 at 20:56 -0700, Randy Dunlap wrote:
> On 10/22/19 9:45 AM, Philipp Zabel wrote:
> > Add initial reset controller API documentation. This is mostly indented
> 
>                                                                  intended

:) Makes me smile every time.

[...]
> > +====================
> > +Reset controller API
> > +====================
> > +
> > +Introduction
> > +============
> > +
> > +Reset controllers are central units that control the reset signals to multiple
> > +peripherals.
> > +The reset controller API is split in two parts:
> 
>                  I prefer            into two parts:

Ok. I think this might have come from "split in half".

[...]
> > +Consumer driver interface
> > +=========================
> > +
> > +This interface offers a similar API to the kernel clock framework.
> 
> or:
>   This interface provides an API that is similar to the kernel clock framework.

Yes, this is better as well. I'll change all three in the next version.

[...]
> > +.. kernel-doc:: drivers/reset/core.c
> > +   :functions: of_reset_simple_xlate
> > +               reset_controller_register
> > +               reset_controller_unregister
> > +               devm_reset_controller_register
> > +               reset_controller_add_lookup
> 
> These header and source files cause a number of kernel-doc warnings
> for which I am sending a patch.

Thank you, I have already sent fixes for the build warnings.
In hindsight, they probably should have been included as a series.

regards
Philipp

