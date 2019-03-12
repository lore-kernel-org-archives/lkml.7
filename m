Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9836CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B092175B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 22:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552428178;
	bh=PqOnWunzXPGGnYnXEGoAPh0tJlvRU0jvDi1p8NQDXp8=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=I4rrAG8euZtJKiBiVpsjTWUIscitwA9Ejr5zmgCIpJGCGrIGug3Kvjz0dSJcD4QJ2
	 hZSonuE5XBbnN740ED7FbH0je2G2uXqYebrghr1xpZqaAaiUpgu21zBm9phnDX22Qe
	 cKXTj4ZNAsUL75Gt08wtLM9a5i66KGtYgjDqRPKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfCLWC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 18:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfCLWC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 18:02:56 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E662173C;
        Tue, 12 Mar 2019 22:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552428176;
        bh=PqOnWunzXPGGnYnXEGoAPh0tJlvRU0jvDi1p8NQDXp8=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=mrgxHUMDe0HpzsaFQkhriaGz5B98GgZiMATpWDqjy5lnMXVnm0kVu8EAPNZtHj8Ja
         Edy/hUIeoO2YxlW7nXIrcjcx1mzzsj1oxlzF486sVZovSZhy5qD7JulrWxIXRKFmHU
         5QVOIA8X3F9JhNN7cb8/fONygIaD0GKWuvElFe3w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190312205921.GA2723@nyx.fritz.box>
References: <1551779342-2640-1-git-send-email-abel.vesa@nxp.com> <155181110921.20095.1641360339603928947@swboyd.mtv.corp.google.com> <20190306130941.dqf3swx66bchm5k2@fsr-ub1664-175> <155205894567.20095.2782332899458282059@swboyd.mtv.corp.google.com> <20190312073654.GA85609@thor.local> <155242319026.20095.4334777579139010310@swboyd.mtv.corp.google.com> <20190312205921.GA2723@nyx.fritz.box>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: imx8mq: Fix numbering overlaps and gaps
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
To:     Patrick Wildt <patrick@blueri.se>
Message-ID: <155242817520.20095.13059579285743425243@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 12 Mar 2019 15:02:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Patrick Wildt (2019-03-12 13:59:22)
> On Tue, Mar 12, 2019 at 01:39:50PM -0700, Stephen Boyd wrote:
> > Quoting Patrick Wildt (2019-03-12 00:36:54)
> > > On Fri, Mar 08, 2019 at 07:29:05AM -0800, Stephen Boyd wrote:
> > > > It's mostly about making sure that any existing dtbs don't have the=
ir
> > > > numbers shifted around. So hopefully any overlapping identifiers ar=
en't
> > > > in use yet and then those ids can be changed while leaving the ones=
 that
> > > > are in use how they are.
> > >=20
> > > In practice I bet no one uses Linux 5.0's i.MX8M device trees since t=
hey
> > > lack too much support.  It's so basic it's not useful.  You'd still r=
un
> > > your existing non-mainline bindings until it is.  Thus I would argue
> > > changing the ABI right now would be the only chance there is.
> > >=20
> > > If you think that chance is gone, then I guess the reasonable thing is
> > > to keep the numbers and only move those (to the end) which overlap.  =
Or
> > > put them into that erreneous number gap.
> > >=20
> >=20
> > The chance is quickly slipping away because we're going to be at -rc1
> > soon. I'm not the one to decide what is and isn't being used by people
> > out there, so I'm happy to apply this patch now before the next -rc1
> > comes out as long as it doesn't break anything in arm-soc area. The
> > confidence I'm getting isn't high though. Has anyone from NXP reviewed
> > this change? Maybe I can get an ack from someone else that normally
> > looks after the arm-soc/dts side of things here indicating that nothing
> > should go wrong? That would increase my confidence levels.
>=20
> The person that supplied the diff apparently is from NXP, which should
> be enough to say that NXP reviewed it?
>=20
> It's a bit of a shame that the ones that are CC'd keep quiet.  I would
> take this chance and go ahead with it.  After 5.1/rc1 there will be no
> chance to rectify this in a sane way.

Ok. I'm just going to merge it and see if anyone complains. I'll send
the PR tomorrow.

