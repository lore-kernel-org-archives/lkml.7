Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCAAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CA821670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 06:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfD3GdS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 02:33:18 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36395 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3GdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 02:33:18 -0400
X-Originating-IP: 81.185.165.117
Received: from xps13 (117.165.185.81.rev.sfr.net [81.185.165.117])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BF75B6000A;
        Tue, 30 Apr 2019 06:33:09 +0000 (UTC)
Date:   Tue, 30 Apr 2019 08:33:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Christophe Kerello <christophe.kerello@st.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Liang Yang <liang.yang@amlogic.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH 2/4] mtd: nand: Move ONFI code into nand/ directory
Message-ID: <20190430083308.1cd2d8ef@xps13>
In-Reply-To: <MN2PR08MB59511F374C25C091FF6EB316B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
References: <MN2PR08MB59511F374C25C091FF6EB316B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shivamurthy,

"Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com> wrote on
Tue, 26 Mar 2019 10:51:56 +0000:

> Move generic ONFI code to nand/ directory, which can be used by SPI
> NAND layer.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
