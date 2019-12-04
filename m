Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41BDC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B441D2073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLDJFT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:05:19 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:37162 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfLDJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:05:19 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B2B2E60B302D;
        Wed,  4 Dec 2019 10:05:16 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wBeuTBKAYkpa; Wed,  4 Dec 2019 10:05:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 32AED6126B4B;
        Wed,  4 Dec 2019 10:05:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Cz8CAp_kOJsR; Wed,  4 Dec 2019 10:05:15 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id B283B60B302D;
        Wed,  4 Dec 2019 10:05:14 +0100 (CET)
Date:   Wed, 4 Dec 2019 10:05:14 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        naga suresh kumar <nagasureshkumarrelli@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        siva durga paladugu <siva.durga.paladugu@xililnx.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>
Message-ID: <944646339.106336.1575450314655.JavaMail.zimbra@nod.at>
In-Reply-To: <20191204071746.kfdflui4ziladmjg@pengutronix.de>
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com> <20191203084134.tgzir4mtekpm5xbs@pengutronix.de> <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com> <614898763.105471.1575364223372.JavaMail.zimbra@nod.at> <CALgLF9KPAk_AsecnTMmbdF5qbgqXe7HNOrNariNVbhSr6FVN2g@mail.gmail.com> <20191203104558.vpqav3oxsydoe4aw@pengutronix.de> <CAFLxGvywFxSrDLLGnLDW6+rMLVUA9Yoi=3sn7wdxqWMydy-w0g@mail.gmail.com> <20191204071746.kfdflui4ziladmjg@pengutronix.de>
Subject: Re: ubifs mount failure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs mount failure
Thread-Index: 9APKbxAFaVpw2zMCYjv1IuV9dZ0ZGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Sascha Hauer" <s.hauer@pengutronix.de>
>> Oh, looks good! Thanks for fixing, Sascha!
> 
> Will you apply this one? Otherwise I resend with the proper tags added.

Just checked in patchwork. It is unable to detect the patch, please resend. :-)

Thanks,
//richard
