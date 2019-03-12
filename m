Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BF3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D222171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552423193;
	bh=4qhycFzAwOPZnCQDp0DZHxXSlYD2uhdMyLp2P9MCpI8=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=lITbVWfKwLm4LBHtdOMSzEMnC28WCBoTO/PieqAp8MHelXWVK6NwuQZum1xBbk1AZ
	 N6uRaRLApJGEYEqEAAylbZuylhmoDq0OlGTqgLK8DgGoKmMApIOLzjZzOdsMX83Axf
	 HYlVIhmblpZrGtFllP0Mg2UpAYhi21JVjvt6O0KU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCLUjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfCLUjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:39:52 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E612147C;
        Tue, 12 Mar 2019 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552423191;
        bh=4qhycFzAwOPZnCQDp0DZHxXSlYD2uhdMyLp2P9MCpI8=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=bsfYGpM7qWgX1AnLnI6WcuKmpvbMEczr6vfGeHSN6AeV/38gIoki90KN63RQ1jQ7D
         Jw4xOdINspw4/N7cTDRn+0HGMb3hlkTk2BgoeTzdqlZTR8b6q81BUJsglRuEJw8O7L
         qTDNMwdTpC7LlLZzlrjcILEsoR3chxZm5l9E53Zc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190312073654.GA85609@thor.local>
References: <1551779342-2640-1-git-send-email-abel.vesa@nxp.com> <155181110921.20095.1641360339603928947@swboyd.mtv.corp.google.com> <20190306130941.dqf3swx66bchm5k2@fsr-ub1664-175> <155205894567.20095.2782332899458282059@swboyd.mtv.corp.google.com> <20190312073654.GA85609@thor.local>
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
Message-ID: <155242319026.20095.4334777579139010310@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 12 Mar 2019 13:39:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Patrick Wildt (2019-03-12 00:36:54)
> On Fri, Mar 08, 2019 at 07:29:05AM -0800, Stephen Boyd wrote:
> > It's mostly about making sure that any existing dtbs don't have their
> > numbers shifted around. So hopefully any overlapping identifiers aren't
> > in use yet and then those ids can be changed while leaving the ones that
> > are in use how they are.
>=20
> In practice I bet no one uses Linux 5.0's i.MX8M device trees since they
> lack too much support.  It's so basic it's not useful.  You'd still run
> your existing non-mainline bindings until it is.  Thus I would argue
> changing the ABI right now would be the only chance there is.
>=20
> If you think that chance is gone, then I guess the reasonable thing is
> to keep the numbers and only move those (to the end) which overlap.  Or
> put them into that erreneous number gap.
>=20

The chance is quickly slipping away because we're going to be at -rc1
soon. I'm not the one to decide what is and isn't being used by people
out there, so I'm happy to apply this patch now before the next -rc1
comes out as long as it doesn't break anything in arm-soc area. The
confidence I'm getting isn't high though. Has anyone from NXP reviewed
this change? Maybe I can get an ack from someone else that normally
looks after the arm-soc/dts side of things here indicating that nothing
should go wrong? That would increase my confidence levels.

