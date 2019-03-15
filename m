Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE8E2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="gvNGM8Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfCOMP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:15:56 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35880 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfCOMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:15:55 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id CF2D525BE91;
        Fri, 15 Mar 2019 23:15:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552652153; bh=7mYk6OdQWA5XRCwnmAtN0tWO741+789RMiZUnld+V5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gvNGM8WxBHlJr/7kIdYB8ygt6SsK6ozvkaQ8S0XoJapOVQjO4SRFzYWx3zmt7K/Nb
         FTOgJI/25zrtl5KhcJDwWruj1uwzS6uZS+nWEy9k+VnoaB6T1jLKYL9tx6f9ynTEQn
         Vod5HgxgyG4eUunH+xlpg3I9Vs4TKaWrzphAL4fM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 3AB2A9403F2; Fri, 15 Mar 2019 13:15:51 +0100 (CET)
Date:   Fri, 15 Mar 2019 13:15:51 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Keerthy <j-keerthy@ti.com>, Peter Rosin <peda@axentia.se>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Phil Reid <preid@electromag.com.au>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/7] i2c: apply coding style for struct i2c_adapter
Message-ID: <20190315121550.53hhzjy57hndp2w5@verge.net.au>
References: <20190302134735.4393-1-wsa+renesas@sang-engineering.com>
 <20190302134735.4393-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190302134735.4393-2-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 02:47:29PM +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  include/linux/i2c.h | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 383510b4f083..758a6db864c9 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -517,20 +517,23 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
>   * Documentation file Documentation/i2c/fault-codes.
>   */
>  struct i2c_algorithm {
> -	/* If an adapter algorithm can't do I2C-level access, set master_xfer
> -	   to NULL. If an adapter algorithm can do SMBus access, set
> -	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
> -	   using common I2C messages */
> -	/* master_xfer should return the number of messages successfully
> -	   processed, or a negative value on error */
> +	/*
> +	 * If an adapter algorithm can't do I2C-level access, set master_xfer
> +	 * to NULL. If an adapter algorithm can do SMBus access, set
> +	 * smbus_xfer. If set to NULL, the SMBus protocol is simulated
> +	 * using common I2C messages.
> +	 *
> +	 * master_xfer should return the number of messages successfully
> +	 * processed, or a negative value on error
> +	 */
>  	int (*master_xfer)(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  			   int num);
> -	int (*smbus_xfer) (struct i2c_adapter *adap, u16 addr,
> -			   unsigned short flags, char read_write,
> -			   u8 command, int size, union i2c_smbus_data *data);
> +	int (*smbus_xfer)(struct i2c_adapter *adap, u16 addr,
> +			  unsigned short flags, char read_write,
> +			  u8 command, int size, union i2c_smbus_data *data);
>  
>  	/* To determine what the adapter supports */
> -	u32 (*functionality) (struct i2c_adapter *);
> +	u32 (*functionality)(struct i2c_adapter *adap);
>  
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
>  	int (*reg_slave)(struct i2c_client *client);
> -- 
> 2.11.0
> 
