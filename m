Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A73C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E6E2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfDPVx2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:53:28 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:54637 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbfDPVx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:53:28 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 6B355200009;
        Tue, 16 Apr 2019 21:53:24 +0000 (UTC)
Date:   Tue, 16 Apr 2019 23:53:22 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: nand: Kconfig: correct the MTD_NAND_ECC_SW_BCH
 select
Message-ID: <20190416235322.3b88df99@xps13>
In-Reply-To: <20190410195852.4066-1-anders.roxell@linaro.org>
References: <20190410195852.4066-1-anders.roxell@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anders,

Anders Roxell <anders.roxell@linaro.org> wrote on Wed, 10 Apr 2019
21:58:51 +0200:

> Config fragments should not have the prefix 'CONFIG_'.
> 
> Rework to remove the prefix 'CONFIG_' from 'CONFIG_MTD_NAND_ECC_SW_BCH'.
> 
> Fixes: 51ef1d0b2095 ("mtd: nand: Clarify Kconfig entry for software BCH ECC algorithm")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---

Thanks for both patches, do you mind if I squash these with the faulty
commits which are still in nand/next?

Thanks,
Miquèl
