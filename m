Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C946FC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AD32080C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfFRG7b convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:59:31 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:34080 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfFRG7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:59:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A81DE60A3581;
        Tue, 18 Jun 2019 08:19:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9pWdrJ7_AVmW; Tue, 18 Jun 2019 08:19:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DA9546074CF4;
        Tue, 18 Jun 2019 08:19:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 87yI62wPtELB; Tue, 18 Jun 2019 08:19:45 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 99655611C994;
        Tue, 18 Jun 2019 08:19:45 +0200 (CEST)
Date:   Tue, 18 Jun 2019 08:19:45 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1318390798.95477.1560838785550.JavaMail.zimbra@nod.at>
In-Reply-To: <20190618030926.30616-1-yamada.masahiro@socionext.com>
References: <20190618030926.30616-1-yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] jffs2: remove C++ style comments from uapi header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: jffs2: remove C++ style comments from uapi header
Thread-Index: deI3m5cpEftGIaGOraBr3ypIKbYSRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Masahiro Yamada" <yamada.masahiro@socionext.com>
> An: "linux-mtd" <linux-mtd@lists.infradead.org>
> CC: "Boris Brezillon" <bbrezillon@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Brian Norris"
> <computersforpeace@gmail.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Marek Vasut" <marek.vasut@gmail.com>,
> "Masahiro Yamada" <yamada.masahiro@socionext.com>, "richard" <richard@nod.at>, "David Woodhouse" <dwmw2@infradead.org>,
> "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Dienstag, 18. Juni 2019 05:09:26
> Betreff: [PATCH v2] jffs2: remove C++ style comments from uapi header

> Linux kernel tolerates C++ style comments these days. Actually, the
> SPDX License tags for .c files start with //.
> 
> On the other hand, uapi headers are written in more strict C, where
> the C++ comment style is forbidden.
> 
> I simply dropped these lines instead of fixing the comment style.
> 
> This code has been always commented out since it was added around
> Linux 2.4.9 (i.e. commented out for more than 17 years).
> 
> 'Maybe later...' will never happen.

:-)
 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard
