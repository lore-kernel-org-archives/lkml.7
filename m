Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C050C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C75120854
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfCMRva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:51:30 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60933 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfCMRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:51:30 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h482H-0001Eq-FW; Wed, 13 Mar 2019 18:51:25 +0100
Message-ID: <1552499485.2453.53.camel@pengutronix.de>
Subject: Re: [PATCH] regulator: Use of_node_name_eq for node name comparisons
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 13 Mar 2019 18:51:25 +0100
In-Reply-To: <CAOMZO5CwxZv=kAiqZ7YE2eRV1tTA13xbz1czUXOiScBoBfk75A@mail.gmail.com>
References: <20181205195050.4759-21-robh@kernel.org>
         <1552497686.2453.49.camel@pengutronix.de>
         <CAOMZO5CwxZv=kAiqZ7YE2eRV1tTA13xbz1czUXOiScBoBfk75A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

Am Mittwoch, den 13.03.2019, 14:36 -0300 schrieb Fabio Estevam:
> Hi Lucas,
> 
> > On Wed, Mar 13, 2019 at 2:22 PM Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> > Unfortunately this change causes a regression on systems with MC13xxx
> > regulators. The desc.name field is filled with an uppercase name of the
> > regulator, while the existing DTs (as far as I know) all use lowercase
> > node names, so the matching in the function above doesn't work anymore.
> > 
> > Any opinions about how to proceed here?
> 
> Does this patch fix the problem?
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20190306&id=ec520911ecc7eaf01a

I wasn't aware of this patch. I haven't tested it yet, but this looks
like it should fix the problem. I just wasn't sure if that's the route
we want to go, as I don't know if there are any out of tree DTs that
use uppercase node names.

But as there seems to be agreement to just change the regulator names
to lowercase, I consider this issue fixed.

Regards,
Lucas
