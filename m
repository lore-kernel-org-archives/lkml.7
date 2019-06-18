Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43FAC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821E92085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560849342;
	bh=gA2YgqZkn0Wi5r13BQk+BBwL1hF7Y6PBm5f+5w9qDqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mCJpAL3mdbxoe04vY8SBuYyaD/iW6/SUZ1JNGAzrqgJgUrMjutehHoBHZpwfODYsQ
	 X1EMWYhtHkegPdvXdiINlkwNDVLuMZs8/N1j8QSOWwfLc6Ig7/SqGrNqv85LfEuKIN
	 wTwae0ssZkMPQNDaGlzvJGsRCfGk6uUrzTrjkNfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfFRJPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbfFRJPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:15:40 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55CE4206BA;
        Tue, 18 Jun 2019 09:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560849340;
        bh=gA2YgqZkn0Wi5r13BQk+BBwL1hF7Y6PBm5f+5w9qDqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pp6ieOAEYOEwunUaoY5CXNUYhXinz+c5vNQxqrWJvgbFUtPzEsYuJwy9EBfV3oHKr
         M6OXEtFbG+jD1EGPrZYfF1JCua1MXePEbLHYapmQVdSNnP8bmY3YzL7Mme5OwCe4no
         wHteUl8FhhCoZnjFrT2v3738Im/QqoU1mk6jZjTk=
Date:   Tue, 18 Jun 2019 17:14:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, viresh.kumar@linaro.org,
        abel.vesa@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 2/2] soc: imx8: Use existing of_root directly
Message-ID: <20190618091442.GM29881@dragon>
References: <20190614080748.32997-1-Anson.Huang@nxp.com>
 <20190614080748.32997-2-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614080748.32997-2-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 04:07:48PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> There is common of_root for reference, no need to find it
> from DT again, use of_root directly to make driver simple.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

It cannot be applied.  Please resend by basing on my imx/drivers branch.

Shawn

> ---
> No changes.
> ---
>  drivers/soc/imx/soc-imx8.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8.c b/drivers/soc/imx/soc-imx8.c
> index 5c7f330..b459bf2 100644
> --- a/drivers/soc/imx/soc-imx8.c
> +++ b/drivers/soc/imx/soc-imx8.c
> @@ -105,7 +105,6 @@ static int __init imx8_soc_init(void)
>  {
>  	struct soc_device_attribute *soc_dev_attr;
>  	struct soc_device *soc_dev;
> -	struct device_node *root;
>  	const struct of_device_id *id;
>  	u32 soc_rev = 0;
>  	const struct imx8_soc_data *data;
> @@ -117,12 +116,11 @@ static int __init imx8_soc_init(void)
>  
>  	soc_dev_attr->family = "Freescale i.MX";
>  
> -	root = of_find_node_by_path("/");
> -	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
> +	ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
>  	if (ret)
>  		goto free_soc;
>  
> -	id = of_match_node(imx8_soc_match, root);
> +	id = of_match_node(imx8_soc_match, of_root);
>  	if (!id) {
>  		ret = -ENODEV;
>  		goto free_soc;
> @@ -147,8 +145,6 @@ static int __init imx8_soc_init(void)
>  		goto free_rev;
>  	}
>  
> -	of_node_put(root);
> -
>  	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
>  		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
>  
> @@ -159,7 +155,6 @@ static int __init imx8_soc_init(void)
>  		kfree(soc_dev_attr->revision);
>  free_soc:
>  	kfree(soc_dev_attr);
> -	of_node_put(root);
>  	return ret;
>  }
>  device_initcall(imx8_soc_init);
> -- 
> 2.7.4
> 
