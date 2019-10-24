Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4AD20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 08:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438504AbfJXIw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 04:52:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56943 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730467AbfJXIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 04:52:28 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iNYr4-0004F0-Tm; Thu, 24 Oct 2019 10:52:26 +0200
Message-ID: <89218b542cc366322798262215c30388cf02fda4.camel@pengutronix.de>
Subject: Re: [PATCH] reset: improve of_xlate documentation
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de
Date:   Thu, 24 Oct 2019 10:52:26 +0200
In-Reply-To: <64c30c47-454d-40a3-9112-4cda26fc3e79@infradead.org>
References: <20191022163024.17005-1-p.zabel@pengutronix.de>
         <64c30c47-454d-40a3-9112-4cda26fc3e79@infradead.org>
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

On Tue, 2019-10-22 at 12:01 -0700, Randy Dunlap wrote:
> Hi,
> minor fix below:
> 
> On 10/22/19 9:30 AM, Philipp Zabel wrote:
> > Mention of_reset_simple_xlate as the default if of_xlate is not set.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/reset/core.c             | 6 ++++--
> >  include/linux/reset-controller.h | 3 ++-
> >  2 files changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 660e0b07feca..3066f12f70db 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> > @@ -77,8 +77,10 @@ static const char *rcdev_name(struct reset_controller_dev *rcdev)
> >   * @rcdev: a pointer to the reset controller device
> >   * @reset_spec: reset line specifier as found in the device tree
> >   *
> > - * This simple translation function should be used for reset controllers
> > - * with 1:1 mapping, where reset lines can be indexed by number without gaps.
> > + * This static translation function is be used by default if of_xlate in
> 
>                               function is used by default

Thank you, fixed up and applied to reset/next.

regards
Philipp

