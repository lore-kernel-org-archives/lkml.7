Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414EEC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1886C2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 17:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfDURXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:23:23 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46791 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDURXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 13:23:23 -0400
X-Originating-IP: 93.23.249.69
Received: from localhost (69.249.23.93.rev.sfr.net [93.23.249.69])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 60455240010;
        Sun, 21 Apr 2019 17:23:12 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: Re: [PATCH 2/3] ARM: mvebu: drop return from void function
In-Reply-To: <1555217391-3552-2-git-send-email-hofrat@osadl.org>
References: <1555217391-3552-1-git-send-email-hofrat@osadl.org> <1555217391-3552-2-git-send-email-hofrat@osadl.org>
Date:   Sun, 21 Apr 2019 19:23:11 +0200
Message-ID: <878sw38e80.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

> The return statement is unnecessary here - so drop it.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Applied on mvebu/arm

Thanks,

Gregory

> ---
>
> Problem reported by checkpatch
>
> WARNING: void function return statements are not generally useful
> #141: FILE: arch/arm/mach-mvebu/board-v7.c:141:
> +       return;
> +}
>
> Patch was compile-tested: mvebu_v7_defconfig (implies MACH_MVEBU_ANY=y)
> (with some unrelated sparse warnings about missing syscalls)
>
> Patch is against 5.1-rc4 (localversion-next is 20190412)
>
>  arch/arm/mach-mvebu/board-v7.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> index 37f8cb6..28fd256 100644
> --- a/arch/arm/mach-mvebu/board-v7.c
> +++ b/arch/arm/mach-mvebu/board-v7.c
> @@ -137,7 +137,6 @@ static void __init i2c_quirk(void)
>  
>  		of_update_property(np, new_compat);
>  	}
> -	return;
>  }
>  
>  static void __init mvebu_dt_init(void)
> -- 
> 2.1.4
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
