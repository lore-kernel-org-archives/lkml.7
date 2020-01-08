Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAF1C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCCA206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgAHJ2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:28:15 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41841 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbgAHJ2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:28:14 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1ip7dN-0000N0-2c; Wed, 08 Jan 2020 10:28:13 +0100
Message-ID: <b0a9e3473b869c273f923b7fb378362416570342.camel@pengutronix.de>
Subject: Re: [PATCH v3] reset: qcom-aoss: Allow CONFIG_RESET_QCOM_AOSS to be
 a tristate
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>
Date:   Wed, 08 Jan 2020 10:28:12 +0100
In-Reply-To: <20200108002311.GG738324@yoga>
References: <20200108001913.28485-1-john.stultz@linaro.org>
         <20200108002311.GG738324@yoga>
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

Hi John, Bjorn,

On Tue, 2020-01-07 at 16:23 -0800, Bjorn Andersson wrote:
> On Tue 07 Jan 16:19 PST 2020, John Stultz wrote:
> 
> > Allow CONFIG_RESET_QCOM_AOSS to be set as as =m to allow for the
> > driver to be loaded from a modules.
> > 
> > Also replaces the builtin_platform_driver() line with
> > module_platform_driver() and adds a MODULE_DEVICE_TABLE() entry.
> > 
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Alistair Delva <adelva@google.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Amit Pundir <amit.pundir@linaro.org>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Thank you, applied to reset/next.

regards
Philipp

