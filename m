Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E877FC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE5720856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558342477;
	bh=FuGxZEbM7oawCwQGwg2EzuoBzEWp6BCjit9mc9pQiog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DWhT4aHrBUNnS/bJgmpEX4vE+sJBYlenuaCGEW+6a7fxlIsJeF7WNjUY6tXd0rGSm
	 vfuYpgCitKIobipAFBFGWIe9UHujJfRpy+rp4emv1fLo4TgpCF1U0T23xlqS8DuzuJ
	 n3r+3UhFuhrSA0cCLqz++tk4tIuXzq1AgGe3a0O4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbfETIyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfETIye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:54:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94A5A204FD;
        Mon, 20 May 2019 08:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558342474;
        bh=FuGxZEbM7oawCwQGwg2EzuoBzEWp6BCjit9mc9pQiog=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLzPaHN+K3lBQVjwdAbX1ZdNL7JPs4n3Jt8lfUV+HGnTAkxTYCXC+zfsBripKgWpx
         EBpoX3l5HN2J3LuZZ3/xcm9XeyR+mS5/G4Iq6MZDfVjDcgSiaTdPxHG/onefYfoJfC
         2OplTTq3/IjIgqqXGTmmXM3YZMkjJCJnG1yU7UqM=
Date:   Mon, 20 May 2019 10:54:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Emanuel Bennici <benniciemanuel78@gmail.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Paolo Abeni <pabeni@redhat.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: os_dep: os_intfs: fix warning
 Unneeded variable: "status". Return "_SUCCESS"
Message-ID: <20190520085431.GC19183@kroah.com>
References: <20190519165758.GA6375@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190519165758.GA6375@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 10:27:58PM +0530, Hariprasad Kelam wrote:
> This patch fixes below warnings reported by coccicheck
> 
> drivers/staging/rtl8723bs/os_dep/os_intfs.c:228:6-12: Unneeded variable:
> "status". Return "_SUCCESS" on line 333
> drivers/staging/rtl8723bs/os_dep/os_intfs.c:607:4-7: Unneeded variable:
> "ret". Return "_SUCCESS" on line 669
> drivers/staging/rtl8723bs/os_dep/os_intfs.c:713:4-8: Unneeded variable:
> "ret8". Return "_SUCCESS" on line 743
> drivers/staging/rtl8723bs/os_dep/os_intfs.c:1379:5-8: Unneeded variable:
> "ret". Return "_SUCCESS" on line 1421
> drivers/staging/rtl8723bs/os_dep/os_intfs.c:1429:5-8: Unneeded variable:
> "ret". Return "_SUCCESS" on line 1451
> drivers/staging/rtl8723bs/os_dep/os_intfs.c:1300:5-8: Unneeded variable:
> "ret". Return "_SUCCESS" on line 1368
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/os_intfs.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> index 8a9d838..71dfac5 100644
> --- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> +++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
> @@ -225,7 +225,6 @@ static int netdev_close (struct net_device *pnetdev);
>  
>  static uint loadparam(struct adapter *padapter, _nic_hdl pnetdev)
>  {
> -	uint status = _SUCCESS;
>  	struct registry_priv  *registry_par = &padapter->registrypriv;
>  
>  	registry_par->chip_version = (u8)rtw_chip_version;
> @@ -330,7 +329,7 @@ static uint loadparam(struct adapter *padapter, _nic_hdl pnetdev)
>  	registry_par->qos_opt_enable = (u8)rtw_qos_opt_enable;
>  
>  	registry_par->hiq_filter = (u8)rtw_hiq_filter;
> -	return status;
> +	return _SUCCESS;
>  }

If this, or any of these other functions, can only return "success",
then why return anything at all?  These should be fixed up to either
properly return an error if one can happen, or be a void function and
fix up the caller function as well.

thanks,

greg k-h
