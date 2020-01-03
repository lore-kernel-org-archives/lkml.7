Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9865C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4D822B48
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgACWzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:55:37 -0500
Received: from mga01.intel.com ([192.55.52.88]:13776 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbgACWzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:55:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 14:55:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,392,1571727600"; 
   d="scan'208";a="245026331"
Received: from hkarray-mobl.ger.corp.intel.com ([10.252.22.101])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jan 2020 14:55:32 -0800
Message-ID: <f315a90f51ec6521e31f53ed24b40ebac93fc934.camel@linux.intel.com>
Subject: Re: Patch "tpm_tis: reserve chip for duration of tpm_tis_core_init"
 has been added to the 5.4-stable tree
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christian Bundy <christianbundy@fraction.io>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        stable-commits@vger.kernel.org, linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 04 Jan 2020 00:55:26 +0200
In-Reply-To: <CAPcyv4gPEu+D+hRqG4HOU24+6xGpZsOb4Po8V+asvvFU-hk6ng@mail.gmail.com>
References: <CAPcyv4jfpOX85GWgNTyugWksU=e-j=RhU_fcrcHBo4GMZ8_bhw@mail.gmail.com>
         <c6ce34b130210d2d1330fc4079d6d82bd74dcef1.camel@linux.intel.com>
         <50217a688ffa56cf5f150ffd358daba2a88cad48.camel@linux.intel.com>
         <20191228151526.GA6971@linux.intel.com>
         <CAPcyv4i_frm8jZeknniPexp8AAmGsaq0_DHegmL4XZHQi1ThxA@mail.gmail.com>
         <CAPcyv4iyQeXBWvp8V_UPBsOk29cfmTVZGYrrDgyYYqzsQvTjNA@mail.gmail.com>
         <2c4a80e0d30bf1dfe89c6e3469d1dbfb008275fa.camel@linux.intel.com>
         <20191231010256.kymv4shwmx5jcmey@cantor>
         <20191231155944.GA4790@linux.intel.com>
         <be07a1e4-c290-4185-8c23-d97050279564@www.fastmail.com>
         <20200102171922.GA20989@linux.intel.com>
         <CAPcyv4hXwujZ-+8f-5q2UthNOSszeHfNQxxjNVPQjOWeT0KDQg@mail.gmail.com>
         <CAPcyv4gPEu+D+hRqG4HOU24+6xGpZsOb4Po8V+asvvFU-hk6ng@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-02 at 21:04 -0800, Dan Williams wrote:
> On Thu, Jan 2, 2020 at 11:20 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > On Thu, Jan 2, 2020 at 9:21 AM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > > On Tue, Dec 31, 2019 at 11:47:37AM -0800, Christian Bundy wrote:
> > > > > Christian, were you having any issues with interrupts? You system was going
> > > > > into this code as well.
> > > > 
> > > > Unfortunately I'm now unable to test, sorry for the trouble. I replaced my BIOS
> > > > with UEFI firmware and the problem has disappeared. Please let me know if there
> > > > is anything else I can do to help.
> > > > 
> > > > Christian
> > > 
> > > Takashi wrote yesterday [*]:
> > > 
> > > "I'm building a test kernel package based on 5.5-rc4 with Jarkko's revert
> > > patches"
> > 
> > Nice, I also built one of those. Just waiting for access to the system
> > again to gather results.
> 
> Ok, it looks good.
> 
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Xiaoping Zhou <xiaoping.zhou@intel.com>

Thank you.

/Jarkko

