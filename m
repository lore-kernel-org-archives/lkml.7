Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B6FC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C980C2798D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559495610;
	bh=6mDr/6XBq7ILp4Yhxkt7FRrOd7ZnzgCrmHeDNSC21p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NU2hPjzVqFUYFMrNqJdQl9Pgd7/BAfCmbZ49VPQTl2hpwY5imYySysnnMccw8Yjtz
	 kI0WCEQh4tzI4dWF7CvDMxYwtChDONOAsmH1rBlDn6MEpzlzolnyoePKhxqcoQEh4q
	 U4E6m18nuTBQFP6WL7NOrsZ22rFZ4409pmMd8r9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfFBRN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfFBRN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:13:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C08627987;
        Sun,  2 Jun 2019 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559495608;
        bh=6mDr/6XBq7ILp4Yhxkt7FRrOd7ZnzgCrmHeDNSC21p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2B1eJ4bonj62mbv2l7//yYOz/zvRqC3E2vB0ch3syTK80jE+7DCFL4gtoLGF73Pb
         PXC2pS/L3xSs4XOo9dI6qTNF+MWefP6SOi+lLO/E1hHkHP3uO1D4YMBMZ1+ptcESOo
         dfVz8HPuB6uPapYZYFF8UlqzSRFvUNB9PWV7Wi78=
Date:   Sun, 2 Jun 2019 19:13:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepak Mishra <linux.dkm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, joe@perches.com, wlanfae@realtek.com,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        himadri18.07@gmail.com, straube.linux@gmail.com
Subject: Re: [PATCH v2 6/9] staging: rtl8712: Fixed CamelCase renames
 xmitThread and recvThread
Message-ID: <20190602171326.GD19671@kroah.com>
References: <cover.1559470737.git.linux.dkm@gmail.com>
 <bd1a47583876c33a3a6a087c085f958ffdf406f3.1559470738.git.linux.dkm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd1a47583876c33a3a6a087c085f958ffdf406f3.1559470738.git.linux.dkm@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 03:55:35PM +0530, Deepak Mishra wrote:
> This patch fixes CamelCase as reported by checkpatch.pl
> xmitThread renamed to xmit_thread
> recvThread renamed to recv_thread
> 
> Signed-off-by: Deepak Mishra <linux.dkm@gmail.com>
> ---
>  drivers/staging/rtl8712/drv_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/drv_types.h b/drivers/staging/rtl8712/drv_types.h
> index a5060a020b2b..1f8aa0358b77 100644
> --- a/drivers/staging/rtl8712/drv_types.h
> +++ b/drivers/staging/rtl8712/drv_types.h
> @@ -154,8 +154,8 @@ struct _adapter {
>  	u8	hw_init_completed;
>  	struct task_struct *cmd_thread;
>  	pid_t evt_thread;
> -	struct task_struct *xmitThread;
> -	pid_t recvThread;
> +	struct task_struct *xmit_thread;
> +	pid_t recv_thread;
>  	uint (*dvobj_init)(struct _adapter *adapter);
>  	void (*dvobj_deinit)(struct _adapter *adapter);
>  	struct net_device *pnetdev;

Again, please just remove the fields entirely.

thanks,

greg k-h
