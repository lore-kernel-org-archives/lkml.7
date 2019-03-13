Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228D8214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mXUWvgFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfCMMfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:35:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59320 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:35:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2DCT6YO043920;
        Wed, 13 Mar 2019 12:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=yqXXhLKBXv+VD6/efvt5pYadwc3/H5MeWffrineRJTw=;
 b=mXUWvgFpIj8ZLWL53j7GpZzd+UcaZHYGSMRQBojwZoLP/xXT21I9+8vzOBKWV36nDR56
 Noho5QwB0+jq29LjxTOkj8JxBTbMUIBbv/4qO3kF3zz96FSHY7NFbMEGsGhM78gTyL9v
 hDyidco7YmUN0jrXcGkwZH8LuOEsSfeBX2vrKMTn0l0rSJorcFp6jT78lndyxwb6QTZQ
 /in6Dr24DPVv/IBA0LX3x2/nGvvDR1zTuOchG3M210nzoPfEyZ4ZiiGy15Puwbuu9Mok
 Fz8wlO7zSaGVuAuIn/JWXebNjkfOrkp6JLHZvT/+SX7YWs7OvJjePBqDovjqk1T1Us3W bA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2r44wuakc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 12:35:10 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2DCZA0W011277
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Mar 2019 12:35:10 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2DCZ9oK009741;
        Wed, 13 Mar 2019 12:35:09 GMT
Received: from kadam (/197.157.0.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Mar 2019 05:35:08 -0700
Date:   Wed, 13 Mar 2019 15:34:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Armando Miraglia <arma2ff0@gmail.com>
Cc:     neil@brown.name, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Armando Miraglia <armax@google.com>,
        linux-mediatek@lists.infradead.org, sankalpnegi2310@gmail.com,
        matthias.bgg@gmail.com, sr@denx.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: mediatek: Attempt to address style issues in
 spi-mt7621.c
Message-ID: <20190313123454.GB2202@kadam>
References: <20190313122403.248873-1-armax@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313122403.248873-1-armax@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9193 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903130091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 01:24:04PM +0100, Armando Miraglia wrote:
> Running Lindent on the mt7621-spi.c file in drivers/staging I noticed that the
> file contained style issues. This change attempts to address such style
> problems.
> 

Don't run lindent.  I think checkpatch.pl has a --fix option that might
be better, but once the code is merged then our standard become much
higher for follow up patches.

> Signed-off-by: Armando Miraglia <armax@google.com>
> ---
> NOTE: resend this patch to include all mainteners listed by get_mantainers.pl.
>  drivers/staging/mt7621-spi/spi-mt7621.c | 27 +++++++++++++------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
> index b509f9fe3346..03d53845f8c5 100644
> --- a/drivers/staging/mt7621-spi/spi-mt7621.c
> +++ b/drivers/staging/mt7621-spi/spi-mt7621.c
> @@ -52,14 +52,14 @@
>  #define MT7621_LSB_FIRST	BIT(3)
>  
>  struct mt7621_spi {
> -	struct spi_master	*master;
> -	void __iomem		*base;
> -	unsigned int		sys_freq;
> -	unsigned int		speed;
> -	struct clk		*clk;
> -	int			pending_write;
> -
> -	struct mt7621_spi_ops	*ops;
> +	struct spi_master *master;
> +	void __iomem *base;
> +	unsigned int sys_freq;
> +	unsigned int speed;
> +	struct clk *clk;
> +	int pending_write;
> +
> +	struct mt7621_spi_ops *ops;

The original is fine.  I don't encourage people to do fancy indenting
with their local variable declarations inside functions but for a struct
the declarations aren't going to change a lot so people can get fancy
if they want.

The problem with a local is if you need to add a new variable then you
have to re-indent a bunch of unrelated lines or have one out of
alignment line.  Most people know this intuitively so they don't get
fancy.

>  };
>  
>  static inline struct mt7621_spi *spidev_to_mt7621_spi(struct spi_device *spi)
> @@ -303,7 +303,7 @@ static int mt7621_spi_setup(struct spi_device *spi)
>  	struct mt7621_spi *rs = spidev_to_mt7621_spi(spi);
>  
>  	if ((spi->max_speed_hz == 0) ||
> -		(spi->max_speed_hz > (rs->sys_freq / 2)))
> +	    (spi->max_speed_hz > (rs->sys_freq / 2)))

Yeah.  Lindent is correct here.

>  		spi->max_speed_hz = (rs->sys_freq / 2);
>  
>  	if (spi->max_speed_hz < (rs->sys_freq / 4097)) {
> @@ -316,9 +316,10 @@ static int mt7621_spi_setup(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id mt7621_spi_match[] = {
> -	{ .compatible = "ralink,mt7621-spi" },
> +	{.compatible = "ralink,mt7621-spi"},

The original was better.

>  	{},
>  };
> +
>  MODULE_DEVICE_TABLE(of, mt7621_spi_match);

No need for a blank.  These are closely related.

>  
>  static int mt7621_spi_probe(struct platform_device *pdev)
> @@ -408,9 +409,9 @@ MODULE_ALIAS("platform:" DRIVER_NAME);
>  
>  static struct platform_driver mt7621_spi_driver = {
>  	.driver = {
> -		.name = DRIVER_NAME,
> -		.of_match_table = mt7621_spi_match,
> -	},
> +		   .name = DRIVER_NAME,
> +		   .of_match_table = mt7621_spi_match,
> +		   },

The new indenting is very wrong.

regards,
dan carpenter
