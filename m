Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B6C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBE423E45
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559341155;
	bh=7x5d5BUU6Eua1GcaZ9iVc3X2KCatlvwlQ+HrL0rUJtE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Jp7n5wqVJS7eIeSjxLsz/9ia5x+bsI7v45+uffdaIgSoXiOe+ow70z3LYIglXZiLm
	 9sEngYX0PSdGfE7PCHK0JQAFdDjGaCaouf57WFs1gg7umaIx6BW0x8mwhYvQdv424q
	 VqeaFGru0GktH2hb12m+6r3xBLv2QbZA9BFE78TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfEaWTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 18:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfEaWTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 18:19:14 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1712D2229C;
        Fri, 31 May 2019 22:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559341154;
        bh=7x5d5BUU6Eua1GcaZ9iVc3X2KCatlvwlQ+HrL0rUJtE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=d/+sdNEWM4ADrG4PU/C/JsHLejWW8U8XpteeYoonvtxxthtEM/Uih3Ce9qHsfNY3/
         I58neI4F1iA+2ORdoHxY9Z5ibKFSmTkmBbQTvKkLJ6PAC5FEykIYRLzPCqhvm7oKPf
         8JiVjF6p5VITCsNYmvFti6w2JVcWnsWgI/26sHno=
Date:   Sat, 1 Jun 2019 00:19:11 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joseph Salisbury <Joseph.Salisbury@microsoft.com>
Subject: Re: [PATCH] drivers: hid: Add a module description line to the
 hid_hyperv driver
In-Reply-To: <20190530173720.17994-1-sashal@kernel.org>
Message-ID: <nycvar.YFH.7.76.1906010018310.1962@cbobk.fhfr.pm>
References: <20190530173720.17994-1-sashal@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2019, Sasha Levin wrote:

> From: Joseph Salisbury <Joseph.Salisbury@microsoft.com>
> 
> This patch only adds a MODULE_DESCRIPTION statement to the driver.
> This change is only cosmetic, so there should be no runtime impact.
> 
> Signed-off-by: Joseph Salisbury <joseph.salisbury@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/hid/hid-hyperv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> index 704049e62d58a..d3311d714d359 100644
> --- a/drivers/hid/hid-hyperv.c
> +++ b/drivers/hid/hid-hyperv.c
> @@ -614,5 +614,7 @@ static void __exit mousevsc_exit(void)
>  }
>  
>  MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Microsoft Hyper-V Synthetic HID Driver");
> +

Is there a reason why you didn't CC Joseph on this submission?

CCing Joseph and applying. Thanks,

-- 
Jiri Kosina
SUSE Labs

