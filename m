Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743042073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 09:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfLCJK0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:10:26 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:49176 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 04:10:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E9DB9605A912;
        Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0EnEESTuRsEP; Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8DB626094C4B;
        Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id td6hCF_Ij_Kf; Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6AD28605A912;
        Tue,  3 Dec 2019 10:10:23 +0100 (CET)
Date:   Tue, 3 Dec 2019 10:10:23 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Michal Simek <michals@xilinx.com>,
        siva durga paladugu <siva.durga.paladugu@xililnx.com>
Message-ID: <614898763.105471.1575364223372.JavaMail.zimbra@nod.at>
In-Reply-To: <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <MN2PR02MB5727000CBE70BAF31F60FEE4AF420@MN2PR02MB5727.namprd02.prod.outlook.com> <20191203084134.tgzir4mtekpm5xbs@pengutronix.de> <MN2PR02MB57272E3343CA62ADBA0F97E5AF420@MN2PR02MB5727.namprd02.prod.outlook.com>
Subject: Re: ubifs mount failure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs mount failure
Thread-Index: AdWpk0w1vXoILfyXR5WMh1O5WbDMxgAIiuAAAABceaAxSwJwoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Naga Sureshkumar Relli" <nagasure@xilinx.com>
> https://elixir.bootlin.com/linux/v5.4/source/fs/ubifs/sb.c#L164
> we are trying to allocate 4325376 (~4MB)

4MiB? Is ->min_io_size that large?

Thanks,
//richard
