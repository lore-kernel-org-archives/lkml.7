Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39734C43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2892070B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfFSVMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:12:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40174 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSVMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:12:44 -0400
Received: from localhost (unknown [144.121.20.163])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A5BF7145E7462;
        Wed, 19 Jun 2019 14:12:43 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:12:41 -0400 (EDT)
Message-Id: <20190619.171241.1736506463260822121.davem@davemloft.net>
To:     puranjay12@gmail.com
Cc:     skhan@linuxfoundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn@helgaas.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] net: fddi: skfp: Include generic PCI definitions from
 pci_regs.h
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190619174556.21194-1-puranjay12@gmail.com>
References: <20190619174556.21194-1-puranjay12@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Jun 2019 14:12:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 19 Jun 2019 23:15:56 +0530

> Include the generic PCI definitions from include/uapi/linux/pci_regs.h
> change PCI_REV_ID to PCI_REVISION_ID to make it compatible with the
> generic define.
> This driver uses only one generic PCI define.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  drivers/net/fddi/skfp/drvfbi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/fddi/skfp/drvfbi.c b/drivers/net/fddi/skfp/drvfbi.c
> index bdd5700e71fa..38f6d943385d 100644
> --- a/drivers/net/fddi/skfp/drvfbi.c
> +++ b/drivers/net/fddi/skfp/drvfbi.c
> @@ -20,6 +20,7 @@
>  #include "h/supern_2.h"
>  #include "h/skfbiinc.h"
>  #include <linux/bitrev.h>
> +#include <uapi/linux/pci_regs.h>

You never need to use "uapi/" in header includes from the kernel source,
please just use "linux/pci_regs.h"

Thank you.
