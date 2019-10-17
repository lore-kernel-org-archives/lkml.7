Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACFDFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B60020872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571328835;
	bh=IYCmMbOcSXngGHz0Xq4hExv5bvmoYiih8+0UkyZlyhk=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=vuq3dQXr1qxvYdnC7lO2x6l/jE51nUHHllsh1HIPbKJaX4eo1xCQseKTJy4FGbzXr
	 eHNGL6BU67BGzbEbzjW8cdDcITyvTypFBFsJ7eI+K7xTusaZr09EAodt6+nS5BnTPR
	 3k66O80Y+0i8TGGkmx18COcPHC3A4ZacRonR6dR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406499AbfJQQNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:13:54 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:40971 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404522AbfJQQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:13:54 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iL8PM-0000EA-01; Thu, 17 Oct 2019 18:13:48 +0200
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] coccinelle: =?UTF-8?Q?api/devm=5Fplatform=5Fioremap?=  =?UTF-8?Q?=5Fresource=3A=20remove=20useless=20script?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Oct 2019 17:13:47 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        <kernel-janitors@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
References: <20191017142237.9734-1-alexandre.belloni@bootlin.com>
Message-ID: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: alexandre.belloni@bootlin.com, julia.lawall@lip6.fr, himanshujha199640@gmail.com, torvalds@linuxfoundation.org, kernel-janitors@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-17 15:22, Alexandre Belloni wrote:
> While it is useful for new drivers to use 
> devm_platform_ioremap_resource,
> this script is currently used to spam maintainers, often updating 
> very old
> drivers. The net benefit is the removal of 2 lines of code in the 
> driver
> but the review load for the maintainers is huge. As of now, more that 
> 560
> patches have been sent, some of them obviously broken, as in:
>
> 
> https://lore.kernel.org/lkml/9bbcce19c777583815c92ce3c2ff2586@www.loen.fr/
>
> Remove the script to reduce the spam.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

I think part of the issue is that the script reports a WARNING for 
something
that is definitely correct code, and could instead be simply toned 
down.

Anyway, FWIW:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
