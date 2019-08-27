Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3703CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176442186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbfH0SPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:15:03 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:39296 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbfH0SPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:15:03 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23992798AbfH0SPAV-MII (ORCPT
        <rfc822;kernel-janitors@vger.kernel.org> + 2 others);
        Tue, 27 Aug 2019 20:15:00 +0200
Date:   Tue, 27 Aug 2019 20:14:57 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kishore Kadiyala <kishore.kadiyala@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Balaji T K <balajitk@ti.com>,
        Benoit Cousson <b-cousson@ti.com>,
        Paul Walmsley <paul@pwsan.com>,
        Nikolaus Schaller <hns@goldelico.com>
Subject: Re: [PATCH] ARM: OMAP2+: Delete an unnecessary kfree() call in
 omap_hsmmc_pdata_init()
Message-ID: <20190827181457.GA16333@lenoch>
References: <69025c8c-8d84-6686-138b-cde59467b802@web.de>
 <20190826162050.GX52127@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826162050.GX52127@atomide.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 09:20:50AM -0700, Tony Lindgren wrote:
> * Markus Elfring <Markus.Elfring@web.de> [190826 06:31]:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 26 Aug 2019 15:05:31 +0200
> > 
> > A null pointer would be passed to a call of the function "kfree" directly
> > after a call of the function "kzalloc" failed at one place.
> > Remove this superfluous function call.
> > 
> > This issue was detected by using the Coccinelle software.
> 
> Applying into omap-for-v5.4/soc thanks.

Is it really wise touching almost dead code? Last user is pandora board, so
+Cc: Nikolaus Schaller <hns@goldelico.com>
