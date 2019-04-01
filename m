Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977B3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F32520880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbfDAP1i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:27:38 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:54167 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfDAP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:27:38 -0400
Received: from xps13 (aaubervilliers-681-1-91-136.w90-88.abo.wanadoo.fr [90.88.32.136])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 296F3100008;
        Mon,  1 Apr 2019 15:27:34 +0000 (UTC)
Date:   Mon, 1 Apr 2019 17:27:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-mtd@lists.infradead.org,
        bbrezillon@kernel.org, liang.yang@amlogic.com, richard@nod.at,
        jianxin.pan@amlogic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] meson-nand: two small memory related fixes
Message-ID: <20190401172733.17131e3e@xps13>
In-Reply-To: <20190318204722.9901-1-martin.blumenstingl@googlemail.com>
References: <20190318204722.9901-1-martin.blumenstingl@googlemail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote on Mon,
18 Mar 2019 21:47:20 +0100:

> While trying to add support for older Meson SoCs to the meson-nand
> driver I was experiencing a crash in meson_nfc_read_buf(). While trying
> to find out why that happened I inspected the code in that function and
> found that there's:
> - a missing check on the return value of a kzalloc() call
> - a potential memory leak in it
> 
> Both fixes have nothing to do with my original crash (for which I'll
> open a separate thread).
> 
> 
> Changes since v1:
> - collected Liang's Acked-by's (thank you!)
> - rebased on top of v5.1-rc1
> 
> 
> Martin Blumenstingl (2):
>   mtd: rawnand: meson: add missing ENOMEM check in meson_nfc_read_buf()
>   mtd: rawnand: meson: fix a potential memory leak in meson_nfc_read_buf
> 
>  drivers/mtd/nand/raw/meson_nand.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 


Applied to git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
on nand/next.


Thanks,
Miquèl
