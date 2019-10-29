Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5A6C47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EF52083E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="H3JkTksc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbfJ2JPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:15:13 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41732 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfJ2JPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iENbg+FdOJeAwjiRGinPqnU5SrOnnqln7JfFosCjnn4=; b=H3JkTkscyd9P7wDj27DHoHwRV
        ZRLlduecjL1PLM71TFPypN4uUjukvtpEwLe45Re5UyWtlmfQ55pC0oEwBwzNSBGA9mdpSKkar7DvS
        C8uZI25CEO34oBSLmWGrDtIOw8+XhRSUPcWrRS1VqFAnl6QiWXMCnSNRKG2I/w+l5yeK8Ve6ccaFd
        1kjTwJQC0uIRYBCqvwAKUUVFcjzl7zH1qSQfaUZ74Sd5xHV7727LW8I9aOM+ZO9u6CTKqyVE9H+5l
        yGLChwVob0lycs2Ve0oYi0oEp7pS8SKVsAdUf5ucOk+GdclZo0OQre6e+Gxy0LKFV0L1PNZImYAr5
        eJT2c0JBw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:48926)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iPNaK-0000fQ-HD; Tue, 29 Oct 2019 09:14:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iPNaD-0004Vk-Up; Tue, 29 Oct 2019 09:14:33 +0000
Date:   Tue, 29 Oct 2019 09:14:33 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     joern@lazybastard.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] mtd: devices: phram.c: Fix use true/false for bool type
Message-ID: <20191029091433.GG25745@shell.armlinux.org.uk>
References: <20191029032142.GA6758@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029032142.GA6758@saurav>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 08:51:42AM +0530, Saurav Girepunje wrote:
> Return type for security_extensions_enabled() is bool
> so use true/false.

This doesn't seem to bear any resemblence to the subject line.

> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  arch/arm/mm/nommu.c         |  2 +-
>  drivers/mtd/devices/phram.c | 11 +++++------
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index 24ecf8d30a1e..1fed74f93c66 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -56,7 +56,7 @@ static inline bool security_extensions_enabled(void)
>  	if ((read_cpuid_id() & 0x000f0000) == 0x000f0000)
>  		return cpuid_feature_extract(CPUID_EXT_PFR1, 4) ||
>  			cpuid_feature_extract(CPUID_EXT_PFR1, 20);
> -	return 0;
> +	return true;

This isn't explained in the commit.  You explain why it should return
true or false, but you don't explain why converting this from returning
0, aka false, to returning true is necessary.

>  }
>  
>  unsigned long setup_vectors_base(void)
> diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
> index 86ae13b756b5..931e5c2481b5 100644
> --- a/drivers/mtd/devices/phram.c
> +++ b/drivers/mtd/devices/phram.c
> @@ -239,27 +239,26 @@ static int phram_setup(const char *val)
>  
>  	ret = parse_name(&name, token[0]);
>  	if (ret)
> -		goto exit;
> +		return ret;
>  
>  	ret = parse_num64(&start, token[1]);
>  	if (ret) {
> +		kfree(name);
>  		parse_err("illegal start address\n");
> -		goto parse_err;
>  	}
>  
>  	ret = parse_num64(&len, token[2]);
>  	if (ret) {
> +		kfree(name);
>  		parse_err("illegal device length\n");
> -		goto parse_err;
>  	}
>  
>  	ret = register_device(name, start, len);
>  	if (!ret)
>  		pr_info("%s device: %#llx at %#llx\n", name, len, start);
> +	else
> +		kfree(name);
>  
> -parse_err:
> -	kfree(name);
> -exit:
>  	return ret;
>  }

At least this partially matches the subject line but it looks unrelated
to the other changes.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
