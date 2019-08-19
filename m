Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95229C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BD820874
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfHSGlO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:41:14 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46172 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSGlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:41:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9412E608311C;
        Mon, 19 Aug 2019 08:41:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PCfFbQ7R1CaL; Mon, 19 Aug 2019 08:41:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 19C92621FCDC;
        Mon, 19 Aug 2019 08:41:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dy3h6pf6zvpv; Mon, 19 Aug 2019 08:41:11 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C63FC6083139;
        Mon, 19 Aug 2019 08:41:10 +0200 (CEST)
Date:   Mon, 19 Aug 2019 08:41:10 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Message-ID: <1815240753.69632.1566196870672.JavaMail.zimbra@nod.at>
In-Reply-To: <CAK7LNATAmk1AxV0kmn6yTsJzSpqTivWHOZy9GjH7J-NL-oBmhQ@mail.gmail.com>
References: <20190618030926.30616-1-yamada.masahiro@socionext.com> <1318390798.95477.1560838785550.JavaMail.zimbra@nod.at> <CAK7LNARA62uqi8rkDeJ=zjA6vnruTAH2VGOBd4=sQMhF+FHMLA@mail.gmail.com> <957967732.18164.1561621143523.JavaMail.zimbra@nod.at> <CAK7LNAQLheA3E0UrjirNHzpS2x+xmjc2YCupCBMNoHOwviz6GQ@mail.gmail.com> <1574230514.38485.1563091693340.JavaMail.zimbra@nod.at> <CAK7LNATAmk1AxV0kmn6yTsJzSpqTivWHOZy9GjH7J-NL-oBmhQ@mail.gmail.com>
Subject: Re: [PATCH v2] jffs2: remove C++ style comments from uapi header
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: jffs2: remove C++ style comments from uapi header
Thread-Index: KGVI1X2kBlsaMBZdQrgIoGl0S7gG5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> This patch missed the fixes pull requests.
> Which version is this targeting for?   v5.4-rc1 ?

Damn, I forgot about this one.
I'll do another fixes PR this week for UBI/UBIFS, so it will be
in tree before the next merge window opens.

Sorry for the delay!

Thanks,
//richard
