Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07B1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773E42083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553010028;
	bh=ufjsWosZYHoCLbS9dWVFBNVPSH2Iyu7iY3hDV6YgSak=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wNsZpINyKJlt3ij22VV1qS3pRFQkg47Lqzvo54r0NGVKYTHjLRvejbnq+fVsSWu+K
	 Cxp8MUEW64aTVTJtIXR2jnS1u17YI1uYwP+MgYS5V1rlg7vGTGLGdcMlzUaj5ArUaF
	 naONeDoHntPmvT+pKp5e5KGHIuYVjm6Zc2NqxulA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCSPk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:40:27 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33533 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:40:27 -0400
Received: by mail-oi1-f196.google.com with SMTP id e22so9192480oiy.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 08:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBl/tQxRxac9HSSTFMgE7JBJKVWGWtdvo7T89h3N5MA=;
        b=CiUu6s0rs76YvwfMyAkspkfY50QwL6wsOe6Lbm55ZxJyr4qp5K9LAFIevqkW+InLN+
         APAjN7Bai/JDxA2Z9NH4wFBPJecJFqfNdRXL6Y/HZIVQhgwmzGcQ3IjOQpSaTOBdpGCl
         4u2cPNpjw9DVV5xhyqR/t/oUkRn7EleJRO5+v8/dlqpJnVUb9gyYRfPnZAlTW5oNTEse
         sUiWJeJ84ulizA7E57bLzVU0RQVQIDuibxvX5jV1pnGa8nC+KyPgk/MKwI1/TMxP0MHV
         0jEyFfuwbvkd6o+84osBZaLNsb1FuLi5oR4Wm4yKGujOn2YEzN4ZM1ZuGAQA/6ZcmkaA
         wsqA==
X-Gm-Message-State: APjAAAUygRCYMLV3BnlQOmQ992SVyw+P2c7M9W36hrCkrtfMkL7W1zB6
        wQ66qKemAgsvIZS61cSxJcTYo85fY9IamctQ4bY=
X-Google-Smtp-Source: APXvYqz3bi4kA6knlOedAe2095++gBqz6XAGqhwtaFvvNHJhTumOwbdbafAkuo5CPvVqTa6GPgf77vIeLa2knBMD+kc=
X-Received: by 2002:aca:5c55:: with SMTP id q82mr1614728oib.95.1553010026021;
 Tue, 19 Mar 2019 08:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190319152042.9780-1-yuehaibing@huawei.com>
In-Reply-To: <20190319152042.9780-1-yuehaibing@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 Mar 2019 16:40:14 +0100
Message-ID: <CAJZ5v0jSPD-jypMCQFOeLEE3nKpyaV=XEC6Gq=0vZ7DYcDM_1w@mail.gmail.com>
Subject: Re: [PATCH -next] drivers: base: swnode: Make two functions static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 4:20 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warning:
>
> drivers/base/swnode.c:475:22: warning: symbol 'software_node_get_parent' was not declared. Should it be static?
> drivers/base/swnode.c:484:22: warning: symbol 'software_node_get_next_child' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

I'll queue this up as device properties material for -rc2, thanks!

> ---
>  drivers/base/swnode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 1fad929..7fc5a18 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -472,7 +472,7 @@ static int software_node_read_string_array(const struct fwnode_handle *fwnode,
>                                                 val, nval);
>  }
>
> -struct fwnode_handle *
> +static struct fwnode_handle *
>  software_node_get_parent(const struct fwnode_handle *fwnode)
>  {
>         struct software_node *swnode = to_software_node(fwnode);
> @@ -481,7 +481,7 @@ software_node_get_parent(const struct fwnode_handle *fwnode)
>                         NULL;
>  }
>
> -struct fwnode_handle *
> +static struct fwnode_handle *
>  software_node_get_next_child(const struct fwnode_handle *fwnode,
>                              struct fwnode_handle *child)
>  {
> --
