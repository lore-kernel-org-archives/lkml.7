Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455B22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfD2ITe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:19:34 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:52681 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfD2ITe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:19:34 -0400
X-Originating-IP: 90.88.147.33
Received: from xps13 (aaubervilliers-681-1-27-33.w90-88.abo.wanadoo.fr [90.88.147.33])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 791EE20003;
        Mon, 29 Apr 2019 08:19:29 +0000 (UTC)
Date:   Mon, 29 Apr 2019 10:19:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kyungmin.park@samsung.com, bbrezillon@kernel.org, richard@nod.at,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] mtd: onenand/samsung: Add device tree support
Message-ID: <20190429101928.265998b5@xps13>
In-Reply-To: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190426164224.11327-1-pawel.mikolaj.chmiel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paweł,

Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote on Fri, 26 Apr 2019
18:42:19 +0200:

> This patchset adds device tree support to Samsung OneNAND driver.
> It was tested on Samsung Galaxy S and Samsung Galaxy S Fascinate 4G,
> an Samsung S5PV210 based mobile phones.
> 
> Tomasz Figa (5):
>   mtd: onenand/samsung: Unify resource order for controller variants
>   mtd: onenand/samsung: Make sure that bus clock is enabled
>   mtd: onenand/samsung: Add device tree support
>   dt-binding: mtd: onenand/samsung: Add device tree support
>   mtd: onenand/samsung: Set name field of mtd_info struct
> 
>  .../bindings/mtd/samsung-onenand.txt          | 46 +++++++++
>  drivers/mtd/nand/onenand/samsung.c            | 94 +++++++++++++------
>  2 files changed, 113 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-onenand.txt
> 

I think you should use "mtd: onenand: samsung:" as prefix.

Thanks,
Miquèl
