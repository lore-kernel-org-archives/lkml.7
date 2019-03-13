Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAAAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC3B2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfCMJRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:17:25 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:49339 "EHLO
        5.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfCMJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:17:24 -0400
X-Greylist: delayed 2901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2019 05:17:22 EDT
Received: from player746.ha.ovh.net (unknown [10.109.160.217])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 2A900121CF4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 10:10:54 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player746.ha.ovh.net (Postfix) with ESMTPSA id 9C41D3B66DD2;
        Wed, 13 Mar 2019 09:10:46 +0000 (UTC)
Date:   Wed, 13 Mar 2019 10:10:45 +0100
From:   Greg Kurz <groug@kaod.org>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Alastair D'Silva <alastair@d-silva.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] ocxl: Remove some unused exported symbols
Message-ID: <20190313101045.6712f156@bahia.lan>
In-Reply-To: <20190313040702.14276-6-alastair@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
        <20190313040702.14276-1-alastair@au1.ibm.com>
        <20190313040702.14276-6-alastair@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14492020652318759243
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrhedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 15:07:01 +1100
"Alastair D'Silva" <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Remove some unused exported symbols.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/misc/ocxl/config.c        |  2 --
>  drivers/misc/ocxl/ocxl_internal.h | 23 +++++++++++++++++++++++
>  include/misc/ocxl.h               | 23 -----------------------
>  3 files changed, 23 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index 026ac2ac4f9c..c90c2e4875bf 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -299,7 +299,6 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
>  	}
>  	return 1;
>  }
> -EXPORT_SYMBOL_GPL(ocxl_config_check_afu_index);
>  
>  static int read_afu_name(struct pci_dev *dev, struct ocxl_fn_config *fn,
>  			struct ocxl_afu_config *afu)
> @@ -535,7 +534,6 @@ int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count)
>  {
>  	return pnv_ocxl_get_pasid_count(dev, count);
>  }
> -EXPORT_SYMBOL_GPL(ocxl_config_get_pasid_info);
>  
>  void ocxl_config_set_afu_pasid(struct pci_dev *dev, int pos, int pasid_base,
>  			u32 pasid_count_log)
> diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
> index 321b29e77f45..06fd98c989c8 100644
> --- a/drivers/misc/ocxl/ocxl_internal.h
> +++ b/drivers/misc/ocxl/ocxl_internal.h
> @@ -107,6 +107,29 @@ void ocxl_pasid_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
>  int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size);
>  void ocxl_actag_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
>  
> +/*
> + * Get the max PASID value that can be used by the function
> + */
> +int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
> +
> +/*
> + * Check if an AFU index is valid for the given function.
> + *
> + * AFU indexes can be sparse, so a driver should check all indexes up
> + * to the maximum found in the function description
> + */
> +int ocxl_config_check_afu_index(struct pci_dev *dev,
> +				struct ocxl_fn_config *fn, int afu_idx);
> +
> +/**

Two *s ?

Also, this results in an ocxl_internal.h header file where only these
three functions are documented... which looks a bit weird IMHO. Since
these are ocxl internals, do we _really_ need to keep the comments ?

> + * Update values within a Process Element
> + *
> + * link_handle: the link handle associated with the process element
> + * pasid: the PASID for the AFU context
> + * tid: the new thread id for the process element
> + */
> +int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
> +
>  struct ocxl_context *ocxl_context_alloc(void);
>  int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
>  			struct address_space *mapping);
> diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
> index 4544573cc93c..9530d3be1b30 100644
> --- a/include/misc/ocxl.h
> +++ b/include/misc/ocxl.h
> @@ -56,15 +56,6 @@ struct ocxl_fn_config {
>  int ocxl_config_read_function(struct pci_dev *dev,
>  				struct ocxl_fn_config *fn);
>  
> -/*
> - * Check if an AFU index is valid for the given function.
> - *
> - * AFU indexes can be sparse, so a driver should check all indexes up
> - * to the maximum found in the function description
> - */
> -int ocxl_config_check_afu_index(struct pci_dev *dev,
> -				struct ocxl_fn_config *fn, int afu_idx);
> -
>  /*
>   * Read the configuration space of a function for the AFU specified by
>   * the index 'afu_idx'. Fills in a ocxl_afu_config structure
> @@ -74,11 +65,6 @@ int ocxl_config_read_afu(struct pci_dev *dev,
>  				struct ocxl_afu_config *afu,
>  				u8 afu_idx);
>  
> -/*
> - * Get the max PASID value that can be used by the function
> - */
> -int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
> -
>  /*
>   * Tell an AFU, by writing in the configuration space, the PASIDs that
>   * it can use. Range starts at 'pasid_base' and its size is a multiple
> @@ -188,15 +174,6 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
>  		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
>  		void *xsl_err_data);
>  
> -/**
> - * Update values within a Process Element
> - *
> - * link_handle: the link handle associated with the process element
> - * pasid: the PASID for the AFU context
> - * tid: the new thread id for the process element
> - */
> -int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid);
> -
>  /*
>   * Remove a Process Element from the Shared Process Area for a link
>   */

