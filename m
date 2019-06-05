Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1ABC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D8F820883
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559739060;
	bh=JSeIBq6ZiFjaRzjEJ70TfUzwWmolhL4j4abxIjOCx5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SXKpGR9Lu3fLk7RSNAcAxfpbVH6DNXUKX7G7cMVw8keUkOd/TgmIj7oeY2ZeO5LMh
	 Yr1RwL2lkXvDNTZ/mwPDRRIKPxwNugLJIAvUiKBzCiFWGM6XMW9VSXnSIJplKsJXWk
	 Mlj8MKwPcttl1I4rdFsmdA8PNOC94p0xPKQjdRjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfFEMu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727642AbfFEMu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:50:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36165206BB;
        Wed,  5 Jun 2019 12:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559739058;
        bh=JSeIBq6ZiFjaRzjEJ70TfUzwWmolhL4j4abxIjOCx5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdbKkJEi+iPLE58t7c0yL9UBKb932TnYaxj8GoFsQJ0wUFA4UlkWbtV1MMkgtp9R7
         bbFNT8ayYVlSjGF4MK6hmIKXPYnceTVQ4JnCb26vhqb+q2Q4TweZnyYO4aZr8n3FR9
         1WgksYAJifGBJLs49go7Rd/H2gjfZQ9aJuT0FlHk=
Date:   Wed, 5 Jun 2019 14:50:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     nicolas.ferre@microchip.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, robh+dt@kernel.org,
        davem@davemloft.net, shawn.lin@rock-chips.com, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dwmw@amazon.co.uk, benh@kernel.crashing.org, jonnyc@amazon.com,
        hhhawa@amazon.com, ronenk@amazon.com, hanochu@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v2 2/2] irqchip: al-fic: Introduce Amazon's Annapurna
 Labs Fabric Interrupt Controller Driver
Message-ID: <20190605125055.GA3184@kroah.com>
References: <1559731921-14023-1-git-send-email-talel@amazon.com>
 <1559731921-14023-3-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559731921-14023-3-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 01:52:01PM +0300, Talel Shenhar wrote:
> --- /dev/null
> +++ b/drivers/irqchip/irq-al-fic.c
> @@ -0,0 +1,289 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**

No need for kernel-doc format style here.

> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

"or its affiliates"?  You know the answer to this, don't keep us in
suspense.  Put the proper copyright holder here please, otherwise this
is totally useless.

Well, copyright notices are technically useless anyway, but lawyers like
to cargo-cult with the best of them, so it should be correct at the
least.

thanks,

greg k-h
