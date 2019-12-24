Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B5C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC81206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="QOR8w2if"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfLXKpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:45:08 -0500
Received: from mail.nic.cz ([217.31.204.67]:42568 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfLXKpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 05:45:08 -0500
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 36316140A69;
        Tue, 24 Dec 2019 11:45:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1577184306; bh=q9JcRnvVRFN2Kpu3lsOtU8eTAnkcYLLURVCH8NtB0Ks=;
        h=Date:From:To;
        b=QOR8w2ifoKjy+rOiyWuZCFtmh6Z0Yem9ycl5XBt/68uGUzIxiRuxZwPI1CtKBAofe
         Wtwvl4WZ8yMsjUXcvVDZ1IKRP4i36nMBQ2tNCmvD3jgvT6niVv8ThrBYsaEYaOOGqJ
         jFnGEGIH4N1kwNhDrnbiWmaafVNwzdMOHxg297Kk=
Date:   Tue, 24 Dec 2019 11:45:04 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     <andrew@lunn.ch>, <vivien.didelot@gmail.com>,
        <f.fainelli@gmail.com>, <davem@davemloft.net>,
        <linux@rempel-privat.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: drop pointless static qualifier in
 ar9331_sw_mbus_init
Message-ID: <20191224114504.2f256ab9@nic.cz>
In-Reply-To: <20191224024059.184847-1-maowenan@huawei.com>
References: <20191224024059.184847-1-maowenan@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao,
the commit title should be something of the form
  net: dsa: qca: ar9331: drop pointless static qualifier
or
  net: dsa: ar9331: drop pointless static qualifier

If it begins only with
  net: dsa:
then it makes people think you are changing stuff in main dsa code.

Marek

On Tue, 24 Dec 2019 10:40:59 +0800
Mao Wenan <maowenan@huawei.com> wrote:

> There is no need to have the 'T *v' variable static
> since new value always be assigned before use it.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/net/dsa/qca/ar9331.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/qca/ar9331.c b/drivers/net/dsa/qca/ar9331.c
> index 0d1a7cd85fe8..da3bece75e21 100644
> --- a/drivers/net/dsa/qca/ar9331.c
> +++ b/drivers/net/dsa/qca/ar9331.c
> @@ -266,7 +266,7 @@ static int ar9331_sw_mbus_read(struct mii_bus *mbus, int port, int regnum)
>  static int ar9331_sw_mbus_init(struct ar9331_sw_priv *priv)
>  {
>  	struct device *dev = priv->dev;
> -	static struct mii_bus *mbus;
> +	struct mii_bus *mbus;
>  	struct device_node *np, *mnp;
>  	int ret;
>  

