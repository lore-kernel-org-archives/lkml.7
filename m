Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EF2CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF2120856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438072AbfJXISV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:18:21 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfJXISV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:18:21 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iNYK2-0000XE-Qr; Thu, 24 Oct 2019 10:18:18 +0200
Message-ID: <d3c9bbc44167009f647772e38168a51d2def36d5.camel@pengutronix.de>
Subject: Re: [RFC] docs: add a reset controller chapter to the driver API
 docs
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Date:   Thu, 24 Oct 2019 10:18:14 +0200
In-Reply-To: <20191022110036.5c2edc05@lwn.net>
References: <20191022164547.22632-1-p.zabel@pengutronix.de>
         <20191022110036.5c2edc05@lwn.net>
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

Hi Jonathan,

On Tue, 2019-10-22 at 11:00 -0600, Jonathan Corbet wrote:
> On Tue, 22 Oct 2019 18:45:47 +0200
> Philipp Zabel <p.zabel@pengutronix.de> wrote:
> 
> > Add initial reset controller API documentation. This is mostly indented
> > to describe the concepts to users of the consumer API, and to tie the
> > kerneldoc comments we already have into the driver API documentation.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> One quick comment...
> 
> >  Documentation/driver-api/index.rst |   1 +
> >  Documentation/driver-api/reset.rst | 217 +++++++++++++++++++++++++++++
> >  2 files changed, 218 insertions(+)
> >  create mode 100644 Documentation/driver-api/reset.rst
> > 
> 
> [...]
> 
> > +Shared and exclusive resets
> > +---------------------------
> > +
> > +The reset controller API provides either reference counted deassertion and
> > +assertion or direct, exclusive control.
> > +The distinction between shared and exclusive reset controls is made at the time
> > +the reset control is requested, either via :c:func:`devm_reset_control_get_shared`
> > +or via :c:func:`devm_reset_control_get_exclusive`.
> 
> :c:func: isn't needed anymore, and is actively discouraged - the function
> references will be linked anyway.  So just say function() rather than
> :c:func:`function` everywhere, please.

That is great, thank you! I'll change them all in the next version.

regards
Philipp

