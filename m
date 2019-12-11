Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF10C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AAA208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbfLKKjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:39:51 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39359 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfLKKju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:39:50 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iezPG-0006AW-1c; Wed, 11 Dec 2019 11:39:46 +0100
Message-ID: <34a73e049624751c0a2c1ae569c224e07ce9fe03.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] Couple of reset-brcmstb fixes
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Dec 2019 11:39:45 +0100
In-Reply-To: <ccb1a422-21a0-88b3-0874-67b7c6c54d4a@gmail.com>
References: <20191104181502.15679-1-f.fainelli@gmail.com>
         <159380b7ec799f15269a4a6e8f2482a02748e6fd.camel@pengutronix.de>
         <ccb1a422-21a0-88b3-0874-67b7c6c54d4a@gmail.com>
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

Hi Florian,

On Tue, 2019-12-10 at 09:51 -0800, Florian Fainelli wrote:
> On 11/6/19 1:01 AM, Philipp Zabel wrote:
> > Hi Florian,
> > 
> > On Mon, 2019-11-04 at 10:15 -0800, Florian Fainelli wrote:
> > > Hi Philipp,
> > > 
> > > This series replaces the previously submitted fixes to the reset-brcmstb
> > > driver and also fix the dt binding example.
> > > 
> > > Thank you!
> > 
> > Thank you. Both applied to reset/fixes.
> 
> Philipp, when do you expect these patches to hit Linus' tree? Thanks!

I have just sent out a pull request for v5.5, I hope we can get them
into -rc2.

regards
Philipp

