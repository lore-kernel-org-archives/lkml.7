Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D576C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24F120645
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfCOLrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:47:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:13577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfCOLrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:47:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 04:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,482,1544515200"; 
   d="scan'208";a="125722828"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.164])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2019 04:47:38 -0700
Date:   Fri, 15 Mar 2019 13:47:37 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
Subject: Re: Add support for TCG2 log format on UEFI systems
Message-ID: <20190315114737.GA4066@linux.intel.com>
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190314093515.GA11165@linux.intel.com>
 <CACdnJuuWMg6c1GJHR3EMobaZ1CwquNudjcgxwXNWczE=3DbQTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuuWMg6c1GJHR3EMobaZ1CwquNudjcgxwXNWczE=3DbQTg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 02:04:02PM -0700, Matthew Garrett wrote:
> On Thu, Mar 14, 2019 at 2:35 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Wed, Feb 27, 2019 at 12:26:54PM -0800, Matthew Garrett wrote:
> > > Identical to V4, but based on tpmdd-next
> >
> > This is not found /sys/kernel/security/tpm0/ascii_bios_measurements
> 
> That's expected - the existing kernel TCG2 log code doesn't expose
> ascii_bios_measurements, only binary_bios_measurements. This patchset
> doesn't change that.

Oops, I meant to point out that the binary_bios_measurents is not found
(i.e. ascii was a typo). The whole tpm0 directory is missing.

I'll try to pinpoint next week where things might go wrong on my system.

/Jarkko
