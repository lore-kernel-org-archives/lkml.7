Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC301C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08EA23429
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S+L15B5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfH3S4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:56:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39894 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfH3S4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qB7bQSi53I1npLxvR85xOF8bwwpMOBJ2wphwbJZyjGA=; b=S+L15B5KsQ25awTQMTHSrXwK9
        /RlRLGUliPs9cgBcRwLZBX3Oq1glIaqAd2PBaeBgKNwUpGTgVwzgH9m0vt04PbrkKHLaMpcTeBBT/
        5eUmmbxDx4R1vvawFUfAhlW2pb6tJ08qrOjqdsxGoOd6u7jNBnnlVVnXlm+VDX6vzAD0RCGfYYU+B
        JvotsCSLtfZUkXdhAXqblkk19snm9UXOmSofvPsKc3u/AfBJPmiWD0WgPe3AT+EWozWDeN3UpkEQM
        gSr7V4mznJ9sbFPirjliyxnSl55tXKtBktjB4x6t1PAhOBMHlwfM2bVw5p34Pag7RjXQ6ZKUc4QjE
        /MOVr8Pvw==;
Received: from [2601:1c0:6200:6e8::4f71]
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i3m4M-0002I2-Ou; Fri, 30 Aug 2019 18:56:22 +0000
Subject: Re: [PATCH] soundwire: slave: Fix unused function warning on !ACPI
To:     Michal Suchanek <msuchanek@suse.de>, alsa-devel@alsa-project.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20190830185212.25144-1-msuchanek@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f8c58d45-e641-5071-33bf-2927a61cb419@infradead.org>
Date:   Fri, 30 Aug 2019 11:56:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830185212.25144-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/19 11:52 AM, Michal Suchanek wrote:
> Fixes the following warning on !ACPI systems:
> 
> drivers/soundwire/slave.c:16:12: warning: ‘sdw_slave_add’ defined but
> not used [-Wunused-function]
>  static int sdw_slave_add(struct sdw_bus *bus,
>             ^~~~~~~~~~~~~
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

I was about to send the same patch.
Thanks.

> ---
>  drivers/soundwire/slave.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
> index f39a5815e25d..34c7e65831d1 100644
> --- a/drivers/soundwire/slave.c
> +++ b/drivers/soundwire/slave.c
> @@ -6,6 +6,7 @@
>  #include <linux/soundwire/sdw_type.h>
>  #include "bus.h"
>  
> +#if IS_ENABLED(CONFIG_ACPI)
>  static void sdw_slave_release(struct device *dev)
>  {
>  	struct sdw_slave *slave = dev_to_sdw_dev(dev);
> @@ -60,7 +61,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
>  	return ret;
>  }
>  
> -#if IS_ENABLED(CONFIG_ACPI)
>  /*
>   * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
>   * @bus: SDW bus instance
> 


-- 
~Randy
