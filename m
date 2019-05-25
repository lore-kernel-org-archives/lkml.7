Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D757FC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A150D217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 05:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558760477;
	bh=K2x3V9gQMbEthWVgYRvaGovpqU7FYDu4zGAHQOI+UrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ub7/QPg//UI/7dpZZTsndImZCdRYmaWLEu3LYfXQHab8RvX6Eklh119+FQxsQEUML
	 5YwCCD9t9H8vhNkU5fqCX2aozRJswUtid1606CbMOzkU8o8JI0VGLA1BullC/fAbdB
	 UKHTQExma94kWcxCtM/E/X3Dxk5a6rRzD5G6vMjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfEYFBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 01:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfEYFBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 01:01:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 684B62177E;
        Sat, 25 May 2019 05:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558760475;
        bh=K2x3V9gQMbEthWVgYRvaGovpqU7FYDu4zGAHQOI+UrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q4JBXx4G+eF3CTr+DPwu9g2B9C+QAoRWW1ijSdSJ8IHIw0N5ST7MDyutvA47SRJlm
         bwuquF4sH/nuYrzNX2mdHkC4RXIiHGdqHEwNwp88SK5C2OAbrQv1G5yl7STZOnBNRj
         /O1c1NPeGh5UlhvyK2yoOXLXmLccvVflZfZ3i3EA=
Date:   Sat, 25 May 2019 07:01:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     jeremy@azazel.net, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] staging: =?utf-8?Q?Remove_?=
 =?utf-8?Q?set_but_not_used_variable_=E2=80=98status=E2=80=99?=
Message-ID: <20190525050113.GB18684@kroah.com>
References: <20190525042642.78482-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190525042642.78482-1-maowenan@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 12:26:42PM +0800, Mao Wenan wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/staging/kpc2000/kpc_spi/spi_driver.c: In function
> ‘kp_spi_transfer_one_message’:
> drivers/staging/kpc2000/kpc_spi/spi_driver.c:282:9: warning: variable
> ‘status’ set but not used [-Wunused-but-set-variable]
>      int status = 0;
>          ^~~~~~
> The variable 'status' is not used any more, remve it.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/staging/kpc2000/kpc_spi/spi_driver.c | 3 ---
>  1 file changed, 3 deletions(-)

What is [PATCH net] in the subject for?  This is not a networking driver
:(

