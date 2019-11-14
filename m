Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D4DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79368206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfKNKA6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:00:58 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:53869 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfKNKA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:00:58 -0500
Received: from xps13 (lfbn-tou-1-421-123.w86-206.abo.wanadoo.fr [86.206.246.123])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id B1ABC24000E;
        Thu, 14 Nov 2019 10:00:54 +0000 (UTC)
Date:   Thu, 14 Nov 2019 11:00:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <gregkh@linuxfoundation.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] ubi: remove unused variable 'err'
Message-ID: <20191114110053.4fbeb918@xps13>
In-Reply-To: <20191114072236.15104-1-yuehaibing@huawei.com>
References: <20191114072236.15104-1-yuehaibing@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

YueHaibing <yuehaibing@huawei.com> wrote on Thu, 14 Nov 2019 15:22:36
+0800:

> drivers/mtd/ubi/debug.c:512:6: warning: unused variable 'err' [-Wunused-variable]
> 
> commit 3427dd213259 ("mtd: no need to check return value
> of debugfs_create functions") leave this variable not used.

Thanks for the fix but I already fixed this trivial issue, I just
did not had time yesterday night to push it, now it is done. It will
be part of tomorrow's linux-next release.

Cheers,
Miquèl
