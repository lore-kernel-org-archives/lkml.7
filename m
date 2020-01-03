Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD599C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2470222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 23:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgACXaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 18:30:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:21899 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgACXaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 18:30:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 15:30:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,392,1571727600"; 
   d="scan'208";a="216899921"
Received: from hkarray-mobl.ger.corp.intel.com ([10.252.22.101])
  by fmsmga008.fm.intel.com with ESMTP; 03 Jan 2020 15:30:20 -0800
Message-ID: <eb3635587fa765825825adfe9be81e1f69916fec.camel@linux.intel.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 04 Jan 2020 01:30:19 +0200
In-Reply-To: <2f4850d8ab10fbe421deff11e8c3b18bfeaace65.camel@linux.intel.com>
References: <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
         <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
         <20191228151526.GA6971@linux.intel.com>
         <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
         <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
         <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
         <20191231010256.kymv4shwmx5jcmey@cantor>
         <20191231155944.GA4790@linux.intel.com>
         <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
         <20200102171922.GA20989@linux.intel.com>
         <20200103202458.lhd5qu2onl67kilb@cantor>
         <2f4850d8ab10fbe421deff11e8c3b18bfeaace65.camel@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-01-04 at 01:07 +0200, Jarkko Sakkinen wrote:
> > You can add my ack to the reverts.
> 
> I'll actually send a patch set to linux-integrity (ETA 1-2h) and
> you can tag it then.
> 
> Better to have sanity check before I send the PR so please check the
> patches and give your feedback ASAP. Please also the check that the
> commit messages look good and also that the cover letter as I'll use
> that as basis for my pull request message.

They are out.

/Jarkko

