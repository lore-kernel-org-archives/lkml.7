Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8274EC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66817222DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfKRTbu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:31:50 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:54806 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfKRTbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:31:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 36751608325B;
        Mon, 18 Nov 2019 20:31:47 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id niBS_obFIVVT; Mon, 18 Nov 2019 20:31:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BB3D86083279;
        Mon, 18 Nov 2019 20:31:44 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 55IZcHZgzvVo; Mon, 18 Nov 2019 20:31:44 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 94045608325B;
        Mon, 18 Nov 2019 20:31:44 +0100 (CET)
Date:   Mon, 18 Nov 2019 20:31:44 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>
Message-ID: <884028732.91086.1574105504462.JavaMail.zimbra@nod.at>
In-Reply-To: <20191118202257.6cfd1a7e@xps13>
References: <20191117202435.28127-1-sudipm.mukherjee@gmail.com> <20191118114657.GA228826@kroah.com> <1505628642.90849.1574081270290.JavaMail.zimbra@nod.at> <20191118202257.6cfd1a7e@xps13>
Subject: Re: [PATCH v2] {tty: serial, nand: onenand}: samsung: rename to fix
 build warning
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: {tty: serial, nand: onenand}: samsung: rename to fix build warning
Thread-Index: sktL5Ddmg4OIdetI4bmxUiXBom0npg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> An: "richard" <richard@nod.at>
> CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Sudip Mukherjee" <sudipm.mukherjee@gmail.com>, "Kyungmin Park"
> <kyungmin.park@samsung.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Jiri Slaby" <jslaby@suse.com>, "linux-kernel"
> <linux-kernel@vger.kernel.org>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-serial"
> <linux-serial@vger.kernel.org>
> Gesendet: Montag, 18. November 2019 20:22:57
> Betreff: Re: [PATCH v2] {tty: serial, nand: onenand}: samsung: rename to fix build warning

> Hi all,
> 
> Richard Weinberger <richard@nod.at> wrote on Mon, 18 Nov 2019 13:47:50
> +0100 (CET):
> 
>> ----- Ursprüngliche Mail -----
>> >> I was not sure if this should have been two different patch, but since
>> >> this will be fixing the same problem so it seems its better to have them
>> >> in a single patch.
>> >> 
>> >>  drivers/mtd/nand/onenand/Makefile                     | 2 +-
>> >>  drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} | 0
>> >>  drivers/tty/serial/Makefile                           | 2 +-
>> >>  drivers/tty/serial/{samsung.c => samsung_tty.c}       | 0
>> >>  4 files changed, 2 insertions(+), 2 deletions(-)
>> >>  rename drivers/mtd/nand/onenand/{samsung.c => samsung_mtd.c} (100%)
>> >>  rename drivers/tty/serial/{samsung.c => samsung_tty.c} (100%)
>> > 
>> > I can take this in the tty tree if the mtd maintainer gives an ack for
>> > it...
>> 
>> Acked-by: Richard Weinberger <richard@nod.at>
> 
> If it is not too late, I am not a big fan of the new naming which is
> rather not descriptive. Files in the onenand subdirectory are:
> * onenand_<something>.c for the base files
> * <vendor>.c for the vendors files (currently: omap2.c and samsung.c).

Well, I'm fine with the naming either way. :-)

Thanks,
//richard
