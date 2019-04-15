Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4613C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB9520874
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfDOIpF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:45:05 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37971 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOIpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:45:05 -0400
Received: from xps13 (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id DB8F2200019;
        Mon, 15 Apr 2019 08:45:00 +0000 (UTC)
Date:   Mon, 15 Apr 2019 10:44:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mtd: cfi_util: mark expected switch fall-throughs
Message-ID: <20190415104458.7faeec57@xps13>
In-Reply-To: <71df15e7-af2e-0326-78fe-0271a1e240fe@embeddedor.com>
References: <20190208180202.GA16603@embeddedor>
        <69083203-0720-1943-8549-ddf3cea6060e@embeddedor.com>
        <71df15e7-af2e-0326-78fe-0271a1e240fe@embeddedor.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Wed, 10 Apr
2019 16:16:51 -0500:

> Hi all,
> 
> If no one cares I'll add this to my tree for 5.2.

Which tree are you talking about?

Please let the MTD maintainers take patches through their tree. We
might be late but this is definitely not a good reason to bypass us.


Thanks,
Miquèl
