Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4ADC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF7020811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556022577;
	bh=cDptc8aEDTmaUT1n9OKte/YRRWplKxN5Ix+1/koIl6g=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=DCQyrxceu9LwLjRDWwXobBmyI3HfJtoF/rGI2I46XaAEULsXByzqovaTqinwN7QuN
	 CPPyrOwFR+h9JocNmKn+B25Hbg1OHCpsHw0RiqLoUd9E77kbgi2PtMy3bjeUYc6wSk
	 OtBLYKxeZTkp0eXxvrqilf2GDxmaBw2xYiYJDnqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfDWM3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDWM3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:29:36 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58FE320811;
        Tue, 23 Apr 2019 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556022575;
        bh=cDptc8aEDTmaUT1n9OKte/YRRWplKxN5Ix+1/koIl6g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kyO4kDjJPnLwHRuuPVQIV00Y1DuHQS9VFEWKIQbL++xmvMa4Fx19GTdQFHvjzgtg7
         gVO+Tepv/vwXiGFb9RtmIsQzdlrq5aJhM+cWzcy8avUgUKBMC28MEPBbUSbuIQNi5d
         lNtIIhr2OYjvNeT4ag5t2sB2b80YaaITFXb7bFA0=
Date:   Tue, 23 Apr 2019 14:29:32 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: Add Comet Lake PCI device ID
In-Reply-To: <20190420020031.58410-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1904231429190.9803@cbobk.fhfr.pm>
References: <20190420020031.58410-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019, Srinivas Pandruvada wrote:

> Added Comet Lake PCI device ID to the supported device list.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> index 08a8327dfd22..523c0cbd44a4 100644
> --- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> +++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> @@ -31,6 +31,7 @@
>  #define CNL_H_DEVICE_ID		0xA37C
>  #define ICL_MOBILE_DEVICE_ID	0x34FC
>  #define SPT_H_DEVICE_ID		0xA135
> +#define CML_LP_DEVICE_ID	0x02FC
>  
>  #define	REVISION_ID_CHT_A0	0x6
>  #define	REVISION_ID_CHT_Ax_SI	0x0
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index a6e1ee744f4d..ac0a179daf23 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -40,6 +40,7 @@ static const struct pci_device_id ish_pci_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_H_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ICL_MOBILE_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, SPT_H_DEVICE_ID)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CML_LP_DEVICE_ID)},
>  	{0, }

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

