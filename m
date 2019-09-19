Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D243C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F721907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 06:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbfISGUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 02:20:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47899 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbfISGUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 02:20:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iApnJ-0002d9-8T; Thu, 19 Sep 2019 08:19:57 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iApn6-00018G-1u; Thu, 19 Sep 2019 08:19:44 +0200
Date:   Thu, 19 Sep 2019 08:19:44 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Peter Rosin <peda@axentia.se>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] of: restore old handling of cells_name=NULL in
 of_*_phandle_with_args()
Message-ID: <20190919061943.ga7jwdn4ednulvgs@pengutronix.de>
References: <20190918063837.8196-1-u.kleine-koenig@pengutronix.de>
 <b00ca30f-2c06-7722-96b2-123d15751cb6@axentia.se>
 <20190918084748.hnjkiq7wc5b35wjh@pengutronix.de>
 <CAL_JsqJuJrOj+D4xkGACC1=zaB5OUkt=SNzCOiOiTVtM9E9z+A@mail.gmail.com>
 <20190918201954.2phyqxqhoj5jwklt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190918201954.2phyqxqhoj5jwklt@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:19:54PM +0200, Uwe Kleine-König wrote:
> On Wed, Sep 18, 2019 at 03:09:06PM -0500, Rob Herring wrote:
> > Can I get a proper patch please.
> 
> I don't understand what is wrong with my patch. Can you please expand
> what you are missing? I just tried to git-am it and the result looks
> fine.

I see that the commit this patch is fixing isn't in Linus' tree yet. Do
you want instead of this commit fixing the previous one a single good
patch that replaces e42ee61017f5 ("of: Let of_for_each_phandle fallback
to non-negative cell_count")?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
