Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EFDC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D5C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbfDRQJG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:09:06 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49375 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDRQJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:09:06 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id F29872000A;
        Thu, 18 Apr 2019 16:09:02 +0000 (UTC)
Date:   Thu, 18 Apr 2019 18:09:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: Fix sphinx syntax
Message-ID: <20190418180901.45a1d17a@xps13>
In-Reply-To: <20190321235242.32158-1-j.neuschaefer@gmx.net>
References: <20190321235242.32158-1-j.neuschaefer@gmx.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote on Fri, 22 Mar 2019
00:52:41 +0100:

> Sphinx doesn't handle expressions in identifier references.
> 
> This fixes the following warnings:
> 
> ./include/linux/mtd/rawnand.h:1184: WARNING: Inline strong start-string without end-string.
> ./include/linux/mtd/rawnand.h:1186: WARNING: Inline strong start-string without end-string.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---

Applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git 
branch nand/next.

Thanks, Miquèl
