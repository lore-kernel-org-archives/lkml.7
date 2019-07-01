Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3F9C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF7A20652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 07:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfGAHOZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 03:14:25 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:39403 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbfGAHOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 03:14:25 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 43710240008;
        Mon,  1 Jul 2019 07:14:16 +0000 (UTC)
Date:   Mon, 1 Jul 2019 09:14:16 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        bbrezillon@kernel.org, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, linux-mtd@lists.infradead.org,
        vigneshr@ti.com, tglx@linutronix.de, frieder.schrempf@kontron.de,
        allison@lohutok.net, juliensu@mxic.com.tw
Subject: Re: [PATCH v3] mtd: rawnand: Add Macronix NAND read retry support
Message-ID: <20190701091416.701e9bca@xps13>
In-Reply-To: <1559529724-5454-1-git-send-email-masonccyang@mxic.com.tw>
References: <1559529724-5454-1-git-send-email-masonccyang@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

Mason Yang <masonccyang@mxic.com.tw> wrote on Mon,  3 Jun 2019 10:42:04
+0800:

> Add support for Macronix NAND read retry.
> 
> Macronix NANDs support specific read operation for data recovery,
> which can be enabled with a SET_FEATURE.
> Driver checks byte 167 of Vendor Blocks in ONFI parameter page table
> to see if this high-reliability function is supported.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---


Applied to nand/next, thanks.

Miquèl
