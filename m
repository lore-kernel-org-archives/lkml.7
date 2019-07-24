Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE61C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463F5218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfGXFjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:39:40 -0400
Received: from gofer.mess.org ([88.97.38.141]:46635 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfGXFjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:39:39 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 432CE60E91; Wed, 24 Jul 2019 06:39:37 +0100 (BST)
Date:   Wed, 24 Jul 2019 06:39:37 +0100
From:   Sean Young <sean@mess.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 04/13] media: rc: sunxi: Add RXSTA bits definition
Message-ID: <20190724053937.4ic5n35xtw2chjdy@gofer.mess.org>
References: <20190607231100.5894-1-peron.clem@gmail.com>
 <20190607231100.5894-5-peron.clem@gmail.com>
 <20190610095243.7xwp4xhauds22qzw@flea>
 <CAJiuCcfyjGTBbsjZQYj2p3KD6O-WaXhFe5NZrnKQwJYACmatUw@mail.gmail.com>
 <20190715121244.2vrsw6qa4fgp72fn@gofer.mess.org>
 <20190723062557.hnbi6hgrg4ecawkn@gofer.mess.org>
 <20190723070440.nfmhbrfykumxayjj@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190723070440.nfmhbrfykumxayjj@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:04:40AM +0200, Maxime Ripard wrote:
> Hi Sean,
> 
> On Tue, Jul 23, 2019 at 07:25:57AM +0100, Sean Young wrote:
> > On Mon, Jul 15, 2019 at 01:12:45PM +0100, Sean Young wrote:
> > > On Sun, Jul 14, 2019 at 04:32:22PM +0200, Clément Péron wrote:
> > > > Hi Sean,
> > > >
> > > > You acked the whole v3 series but this patch has been introduced in v5
> > > > could you ack this one too?
> > >
> > > Acked-by: Sean Young <sean@mess.org>
> >
> > So who's tree should this series go through? It seems mostly device tree.
> > Alternatively I'm happy to try it get merged via the media tree.
> 
> Ideally the media bits should go through the media tree, the DT bits
> will go through arm-soc
> 
> So you can apply the patches 1-4, 7 and 10, I'll apply the rest.
> 
> Does that work for you?

Works for me, I'll add them to my next pull request to Mauro.

Thanks,

Sean
