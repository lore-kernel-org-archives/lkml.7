Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ACBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EEF2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfCNG5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:57:44 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:45959 "EHLO
        6.mo173.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfCNG5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:57:43 -0400
Received: from player731.ha.ovh.net (unknown [10.109.146.76])
        by mo173.mail-out.ovh.net (Postfix) with ESMTP id 5DB4BF9D5A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:52:22 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player731.ha.ovh.net (Postfix) with ESMTPSA id 939E538B7730;
        Thu, 14 Mar 2019 06:51:35 +0000 (UTC)
Date:   Thu, 14 Mar 2019 07:50:55 +0100
From:   Greg Kurz <groug@kaod.org>
To:     "Alastair D'Silva" <alastair@au1.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/5] ocxl: Remove some unused exported symbols
Message-ID: <20190314075055.6c4eb970@bahia.lan>
In-Reply-To: <1dd6d24f3ee5a2029ee6fbb2890356197e881101.camel@au1.ibm.com>
References: <20190227045741.21412-1-alastair@au1.ibm.com>
        <20190313040702.14276-1-alastair@au1.ibm.com>
        <20190313040702.14276-6-alastair@au1.ibm.com>
        <20190313101045.6712f156@bahia.lan>
        <1dd6d24f3ee5a2029ee6fbb2890356197e881101.camel@au1.ibm.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 18025094560251812171
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrhedugddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2019 13:23:21 +1100
"Alastair D'Silva" <alastair@au1.ibm.com> wrote:

> On Wed, 2019-03-13 at 10:10 +0100, Greg Kurz wrote:
> > On Wed, 13 Mar 2019 15:07:01 +1100
> > "Alastair D'Silva" <alastair@au1.ibm.com> wrote:
> >   
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > Remove some unused exported symbols.
> > > 
> > > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > > ---
> > >  drivers/misc/ocxl/config.c        |  2 --
> > >  drivers/misc/ocxl/ocxl_internal.h | 23 +++++++++++++++++++++++
> > >  include/misc/ocxl.h               | 23 -----------------------
> > >  3 files changed, 23 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/misc/ocxl/config.c
> > > b/drivers/misc/ocxl/config.c
> > > index 026ac2ac4f9c..c90c2e4875bf 100644
> > > --- a/drivers/misc/ocxl/config.c
> > > +++ b/drivers/misc/ocxl/config.c
> > > @@ -299,7 +299,6 @@ int ocxl_config_check_afu_index(struct pci_dev
> > > *dev,
> > >  	}
> > >  	return 1;
> > >  }
> > > -EXPORT_SYMBOL_GPL(ocxl_config_check_afu_index);
> > >  
> > >  static int read_afu_name(struct pci_dev *dev, struct
> > > ocxl_fn_config *fn,
> > >  			struct ocxl_afu_config *afu)
> > > @@ -535,7 +534,6 @@ int ocxl_config_get_pasid_info(struct pci_dev
> > > *dev, int *count)
> > >  {
> > >  	return pnv_ocxl_get_pasid_count(dev, count);
> > >  }
> > > -EXPORT_SYMBOL_GPL(ocxl_config_get_pasid_info);
> > >  
> > >  void ocxl_config_set_afu_pasid(struct pci_dev *dev, int pos, int
> > > pasid_base,
> > >  			u32 pasid_count_log)
> > > diff --git a/drivers/misc/ocxl/ocxl_internal.h
> > > b/drivers/misc/ocxl/ocxl_internal.h
> > > index 321b29e77f45..06fd98c989c8 100644
> > > --- a/drivers/misc/ocxl/ocxl_internal.h
> > > +++ b/drivers/misc/ocxl/ocxl_internal.h
> > > @@ -107,6 +107,29 @@ void ocxl_pasid_afu_free(struct ocxl_fn *fn,
> > > u32 start, u32 size);
> > >  int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size);
> > >  void ocxl_actag_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
> > >  
> > > +/*
> > > + * Get the max PASID value that can be used by the function
> > > + */
> > > +int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
> > > +
> > > +/*
> > > + * Check if an AFU index is valid for the given function.
> > > + *
> > > + * AFU indexes can be sparse, so a driver should check all indexes
> > > up
> > > + * to the maximum found in the function description
> > > + */
> > > +int ocxl_config_check_afu_index(struct pci_dev *dev,
> > > +				struct ocxl_fn_config *fn, int
> > > afu_idx);
> > > +
> > > +/**  
> > 
> > Two *s ?
> >   
> 
> These are Sphinx formatted comments (similar, but not quite the same as
> Doxygen).
> 

Oh... should the other comments be converted to this format for consistency ?

> > Also, this results in an ocxl_internal.h header file where only these
> > three functions are documented... which looks a bit weird IMHO. Since
> > these are ocxl internals, do we _really_ need to keep the comments ?  
> 
> I believe we should, it's a courtesy to the next person who has to work
> in the area.
> 
> There are more documentation comments coming in further series.
> 

Fair enough.

Reviewed-by: Greg Kurz <groug@kaod.org>
