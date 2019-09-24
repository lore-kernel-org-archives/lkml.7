Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8400C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF6A21655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569366588;
	bh=7idn0CNbweKI57g3MD3qSJt3qBKkvSG9PWog91JNqN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qUhaLaBnSzrGet9t0QpJhXBy5ZzDFk/SPabDZQU8I3UYSfwOz6kNI+zgn9B7KQ+OH
	 stDm/DWOK7ON9cppyj3gB4hwmMOZ9NXZqaHWAj2OS1M6Xab3z4jtplsscu4Q3Bwgmq
	 NI1evOb2Je29yWddMU0NJHUe/83nkoJokZ9hPZow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442048AbfIXXJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 19:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389752AbfIXXJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:09:47 -0400
Received: from X250 (unknown [12.206.46.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF69207FD;
        Tue, 24 Sep 2019 23:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569366587;
        bh=7idn0CNbweKI57g3MD3qSJt3qBKkvSG9PWog91JNqN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iw258NMAJx2PrwN5WOxTbO1UzFqCksPNuBLVrdFkL7ZVd9AY21abrma1sulKJ8I25
         CJU+Dqx7PDtZ5DIg+JbgDlB9zcXtKqm1p+Skk2qUtnfONQt6ocnmj8Y2/MoNAwSCks
         QeHN5VMJ7egDrhdSStPkHQMOu/iv6bxRFreigK9E=
Date:   Tue, 24 Sep 2019 16:09:45 -0700
From:   Shawn Guo <shawnguo@kernel.org>
To:     Markus Kueffner <kueffner.markus@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-udoo: Add Pincfgs for OTG
Message-ID: <20190924230944.GA5271@X250>
References: <20190411065440.GB26817@dragon>
 <1555161577-1533-1-git-send-email-kueffner.markus@gmail.com>
 <20190415091150.GB18917@X250.skyworth_vap>
 <20190916130604.GA3140@ubuntu-buildhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916130604.GA3140@ubuntu-buildhost>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 01:06:04PM +0000, Markus Kueffner wrote:
> On Mon, Apr 15, 2019 at 05:11:51PM +0800, Shawn Guo wrote:
> > On Sat, Apr 13, 2019 at 03:19:36PM +0200, Markus Kueffner wrote:
> > > Add Pincfgs to enable the i.MX6's OTG feature for UDOO
> > > 
> > > Signed-off-by: Markus Kueffner <kueffner.markus@gmail.com>
> > 
> > Applied, thanks.
> 
> Hello, 
> 
> I was wondering when this might get merged into a release. 
> Is there anything else I need to fix?

I'm sorry, Markus.  There was something wrong on my side, and the patch
did not really get applied for 5.4. I just fixed it for the next
release.  Sorry about that!

Shawn
