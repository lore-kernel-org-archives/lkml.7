Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C8CC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016702073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfLDKIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:08:49 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43571 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfLDKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:08:48 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1icRaP-0006Nf-QN; Wed, 04 Dec 2019 11:08:45 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1icRaO-0006iO-Sp; Wed, 04 Dec 2019 11:08:44 +0100
Date:   Wed, 4 Dec 2019 11:08:44 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     naga suresh kumar <nagasureshkumarrelli@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        siva.durga.paladugu@xilinx.com
Subject: Re: ubifs mount failure
Message-ID: <20191204100844.jvyvhbgthqycjq6g@pengutronix.de>
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <20191203084134.tgzir4mtekpm5xbs@pengutronix.de>
 <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
 <614898763.105471.1575364223372.JavaMail.zimbra@nod.at>
 <CALgLF9KPAk_AsecnTMmbdF5qbgqXe7HNOrNariNVbhSr6FVN2g@mail.gmail.com>
 <20191203104558.vpqav3oxsydoe4aw@pengutronix.de>
 <CALgLF9+H-8BdZ0BkmpcEL8B1G1cpPsC+=5oqz6ErnTOhnG7yZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALgLF9+H-8BdZ0BkmpcEL8B1G1cpPsC+=5oqz6ErnTOhnG7yZQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:08:04 up 149 days, 16:18, 149 users,  load average: 0.21, 0.23,
 0.19
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 04:23:34PM +0530, naga suresh kumar wrote:
> Hi Sascha,
> 
> Tested this patch. and it worked.
> Thanks for your quick response.

Ok, I take this as a:

Tested-by: Naga Sureshkumar Relli <nagasure@xilinx.com>

Thanks

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
