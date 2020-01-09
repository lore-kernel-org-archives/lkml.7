Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFDEC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3910D2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgAITUS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:20:18 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:50339 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgAITUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:20:17 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B3382200006;
        Thu,  9 Jan 2020 19:20:15 +0000 (UTC)
Date:   Thu, 9 Jan 2020 20:20:14 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Piotr Sroka <piotrs@cadence.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mtd: rawnand: cadence: Change types of function
 parameters keeping DMA address
Message-ID: <20200109202003.44ec5102@xps13>
In-Reply-To: <1575546963-436-1-git-send-email-piotrs@cadence.com>
References: <1575546963-436-1-git-send-email-piotrs@cadence.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

Piotr Sroka <piotrs@cadence.com> wrote on Thu, 5 Dec 2019 12:55:58
+0100:

> It was changed to avoid compilation warnings during type casting.
> 
> Signed-off-by: Piotr Sroka <piotrs@cadence.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---

I just realized that I received three patches for the same issue about
a month ago, yours was totally valid but I choose to apply the one from
someone not contributing a lot to encourage him, hope you don't mind :)

Cheers,
Miquèl
