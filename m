Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A6EC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E8920835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 10:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731716AbfDQKFH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 06:05:07 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58937 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDQKFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 06:05:07 -0400
X-Originating-IP: 90.88.160.238
Received: from xps13 (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 0531C40011;
        Wed, 17 Apr 2019 10:05:04 +0000 (UTC)
Date:   Wed, 17 Apr 2019 12:05:04 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] mtd: nand: Cleanup flags and fields for bad
 block marker position
Message-ID: <20190417120504.105ffcb5@xps13>
In-Reply-To: <20190218104122.18788-4-frieder.schrempf@kontron.de>
References: <20190218104122.18788-1-frieder.schrempf@kontron.de>
        <20190218104122.18788-4-frieder.schrempf@kontron.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frieder,

Schrempf Frieder <frieder.schrempf@kontron.de> wrote on Mon, 18 Feb
2019 10:42:43 +0000:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Now that we have moved the information to the chip level, let's
> remove all the unused flags and fields.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
