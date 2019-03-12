Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD0BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D55214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfCLU7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:59:31 -0400
Received: from pony.blueri.se ([163.172.214.9]:48694 "EHLO pony.blueri.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfCLU7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:59:31 -0400
Received: from nyx.fritz.box (p200300C1C7200A00AD75C33D18492A93.dip0.t-ipconnect.de [IPv6:2003:c1:c720:a00:ad75:c33d:1849:2a93])
        by pony.blueri.se (OpenSMTPD) with ESMTPSA id 2a8aa2eb (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 12 Mar 2019 21:59:25 +0100 (CET)
Date:   Tue, 12 Mar 2019 21:59:22 +0100
From:   Patrick Wildt <patrick@blueri.se>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and
 gaps
Message-ID: <20190312205921.GA2723@nyx.fritz.box>
References: <1551779342-2640-1-git-send-email-abel.vesa@nxp.com>
 <155181110921.20095.1641360339603928947@swboyd.mtv.corp.google.com>
 <20190306130941.dqf3swx66bchm5k2@fsr-ub1664-175>
 <155205894567.20095.2782332899458282059@swboyd.mtv.corp.google.com>
 <20190312073654.GA85609@thor.local>
 <155242319026.20095.4334777579139010310@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155242319026.20095.4334777579139010310@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 01:39:50PM -0700, Stephen Boyd wrote:
> Quoting Patrick Wildt (2019-03-12 00:36:54)
> > On Fri, Mar 08, 2019 at 07:29:05AM -0800, Stephen Boyd wrote:
> > > It's mostly about making sure that any existing dtbs don't have their
> > > numbers shifted around. So hopefully any overlapping identifiers aren't
> > > in use yet and then those ids can be changed while leaving the ones that
> > > are in use how they are.
> > 
> > In practice I bet no one uses Linux 5.0's i.MX8M device trees since they
> > lack too much support.  It's so basic it's not useful.  You'd still run
> > your existing non-mainline bindings until it is.  Thus I would argue
> > changing the ABI right now would be the only chance there is.
> > 
> > If you think that chance is gone, then I guess the reasonable thing is
> > to keep the numbers and only move those (to the end) which overlap.  Or
> > put them into that erreneous number gap.
> > 
> 
> The chance is quickly slipping away because we're going to be at -rc1
> soon. I'm not the one to decide what is and isn't being used by people
> out there, so I'm happy to apply this patch now before the next -rc1
> comes out as long as it doesn't break anything in arm-soc area. The
> confidence I'm getting isn't high though. Has anyone from NXP reviewed
> this change? Maybe I can get an ack from someone else that normally
> looks after the arm-soc/dts side of things here indicating that nothing
> should go wrong? That would increase my confidence levels.

The person that supplied the diff apparently is from NXP, which should
be enough to say that NXP reviewed it?

It's a bit of a shame that the ones that are CC'd keep quiet.  I would
take this chance and go ahead with it.  After 5.1/rc1 there will be no
chance to rectify this in a sane way.
