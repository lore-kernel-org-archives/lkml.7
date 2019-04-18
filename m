Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51112C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B864218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389706AbfDRQZm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:25:42 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57487 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDRQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:25:42 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 481316000C;
        Thu, 18 Apr 2019 16:25:39 +0000 (UTC)
Date:   Thu, 18 Apr 2019 18:25:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        marek.vasut@gmail.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, bbrezillon@kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH 1/2 v2] mtd: nandsim: Embed struct nand_chip in struct
 nandsim
Message-ID: <20190418182537.41f7e7ee@xps13>
In-Reply-To: <20190417185433.29666-1-richard@nod.at>
References: <20190417185433.29666-1-richard@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

Richard Weinberger <richard@nod.at> wrote on Wed, 17 Apr 2019 20:54:32
+0200:

> We will need struct nand_controller soon, so more stuff need to
> be parts of struct nandsim.
> While we are here, rename "nand" to "ns" to use the same naming scheme
> everywhere in nandsim.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---


Both patches applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git 
branch nand/next.

Thanks,
Miquèl
