Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86389C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D86A2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731774AbfGOWaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:30:20 -0400
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:43720 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730676AbfGOWaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:30:19 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id B473A8122D75
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 22:21:52 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 898708015544;
        Mon, 15 Jul 2019 22:21:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: push41_2d0a2f6b72544
X-Filterd-Recvd-Size: 5512
Received: from XPS-9350 (unknown [172.58.35.237])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Jul 2019 22:21:49 +0000 (UTC)
Message-ID: <5f8d2f42d770a11e1331605fb3f22df44c74574f.camel@perches.com>
Subject: Re: [PATCH] staging: kpc2000: whitespace and line length cleanup
From:   Joe Perches <joe@perches.com>
To:     john.hubbard@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon =?ISO-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        Geordan Neukum <gneukum1@gmail.com>,
        Jeremy Sowden <jeremy@azazel.net>,
        Vandana BN <bnvandana@gmail.com>, devel@driverdev.osuosl.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Date:   Mon, 15 Jul 2019 15:21:18 -0700
In-Reply-To: <20190715212123.432-2-jhubbard@nvidia.com>
References: <20190715212123.432-1-jhubbard@nvidia.com>
         <20190715212123.432-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 14:21 -0700, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> This commit was created by running indent(1):
>     `indent -linux`
> 
> ...and then applying some manual corrections and
> cleanup afterward, to keep it sane. No functional changes
> were made.

I don't find many of these whitespace changes "better".

Sometimes, it's just fine to have > 80 char lines.

Alignment formatting was OK before this and now has
many odd uses that make reading for a human harder
rather than simpler or easier.

> diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
[]
> @@ -33,9 +33,9 @@ MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Matt.Sickler@Daktronics.com");
>  
>  struct i2c_device {
> -	unsigned long           smba;
> -	struct i2c_adapter      adapter;
> -	unsigned int            features;
> +	unsigned long		smba;
> +	struct i2c_adapter	adapter;
> +	unsigned int		features;

Here the spaces before the identifier are converted to tab aligned 

>  };
>  
>  /*****************************
> @@ -52,9 +52,9 @@ struct i2c_device {
>  #define SMBHSTDAT0(p)   ((5  * REG_SIZE) + (p)->smba)
>  #define SMBHSTDAT1(p)   ((6  * REG_SIZE) + (p)->smba)
>  #define SMBBLKDAT(p)    ((7  * REG_SIZE) + (p)->smba)
> -#define SMBPEC(p)       ((8  * REG_SIZE) + (p)->smba)   /* ICH3 and later */
> -#define SMBAUXSTS(p)    ((12 * REG_SIZE) + (p)->smba)   /* ICH4 and later */
> -#define SMBAUXCTL(p)    ((13 * REG_SIZE) + (p)->smba)   /* ICH4 and later */
> +#define SMBPEC(p)       ((8  * REG_SIZE) + (p)->smba)	/* ICH3 and later */
> +#define SMBAUXSTS(p)    ((12 * REG_SIZE) + (p)->smba)	/* ICH4 and later */
> +#define SMBAUXCTL(p)    ((13 * REG_SIZE) + (p)->smba)	/* ICH4 and later */

But here the #define value still has spaces but the comment uses tabs.
Why tab align the comments but not the #define value?

> @@ -136,17 +138,21 @@ static int i801_check_pre(struct i2c_device *priv)
[]
>  	status &= STATUS_FLAGS;
>  	if (status) {
> -		//dev_dbg(&priv->adapter.dev, "Clearing status flags (%02x)\n", status);
> +		//dev_dbg(&priv->adapter.dev,
> +		//"Clearing status flags (%02x)\n", status);

This was better before.

An improvement might be to add more macros like:

#define i2c_err(priv, fmt, ...)
	dev_err(&(priv)->adapter.dev, fmt, ##__VA_ARGS__)
#define i2c_dbg(priv, fmt, ...)
	dev_dbg(&(priv)->adapter.dev, fmt, ##__VA_ARGS__)

So all these uses of dev_<level>(&priv->adapter.dev, ...)
become much shorter visually and the line wrapping becomes
rather better.

>  		outb_p(status, SMBHSTSTS(priv));
>  		status = inb_p(SMBHSTSTS(priv)) & STATUS_FLAGS;
>  		if (status) {
> -			dev_err(&priv->adapter.dev, "Failed clearing status flags (%02x)\n", status);
> +			dev_err(&priv->adapter.dev,
> +				"Failed clearing status flags (%02x)\n",
> +				status);

e.g.:
			i2c_err(priv, "Failed clearing status flags (%02x)\n",
				status);

etc...


[]

> @@ -301,7 +322,8 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
>  			else
>  				smbcmd = I801_BLOCK_LAST;
>  		} else {
> -			if (command == I2C_SMBUS_I2C_BLOCK_DATA && read_write == I2C_SMBUS_READ)
> +			if (command == I2C_SMBUS_I2C_BLOCK_DATA
> +			    && read_write == I2C_SMBUS_READ)

logic continuations should be at EOL.

			if (command == I2C_SMBUS_I2C_BLOCK_DATA &&
			    read_write == I2C_SMBUS_READ)

[]
> @@ -558,13 +614,14 @@ static u32 i801_func(struct i2c_adapter *adapter)
>  		I2C_FUNC_SMBUS_WORD_DATA         | /* _READ_WORD_DATA  _WRITE_WORD_DATA */
>  		I2C_FUNC_SMBUS_BLOCK_DATA        | /* _READ_BLOCK_DATA  _WRITE_BLOCK_DATA */
>  		!I2C_FUNC_SMBUS_I2C_BLOCK        | /* _READ_I2C_BLOCK  _WRITE_I2C_BLOCK */
> -		!I2C_FUNC_SMBUS_EMUL;              /* _QUICK  _BYTE  _BYTE_DATA  _WORD_DATA  _PROC_CALL  _WRITE_BLOCK_DATA  _I2C_BLOCK _PEC */
> +		/* _QUICK  _BYTE  _BYTE_DATA  _WORD_DATA  _PROC_CALL  _WRITE_BLOCK_DATA  _I2C_BLOCK _PEC : */
> +		!I2C_FUNC_SMBUS_EMUL;
>  	return f;
>  }
>  
>  static const struct i2c_algorithm smbus_algorithm = {
> -	.smbus_xfer     = i801_access,
> -	.functionality  = i801_func,
> +	.smbus_xfer = i801_access,
> +	.functionality = i801_func,

Many people prefer the aligned function names.

etc...


