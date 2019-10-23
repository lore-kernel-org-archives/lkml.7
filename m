Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8414CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6F720650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 11:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391145AbfJWLvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 07:51:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:18128 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732092AbfJWLvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:51:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 04:51:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="201967601"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.121])
  by orsmga006.jf.intel.com with ESMTP; 23 Oct 2019 04:51:51 -0700
Date:   Wed, 23 Oct 2019 14:51:51 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     ivan.lazeev@gmail.com, jsnitsel@redhat.com
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] tpm_crb: fix fTPM on AMD Zen+ CPUs
Message-ID: <20191023115151.GF21973@linux.intel.com>
References: <20191016182814.18350-1-ivan.lazeev@gmail.com>
 <20191021155735.GA7387@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021155735.GA7387@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 06:57:35PM +0300, Jarkko Sakkinen wrote:
> Almost tested this today. Unfortunately the USB stick at hand was
> broken.  I'll retry tomorrow or Wed depending on which day I visit at
> the office and which day I WFH.
> 
> At least the AMI BIOS had all the TPM stuff in it. The hardware I'll be
> using is Udoo Bolt V8 (thanks Jerry for pointing me out this device)
> with AMD Ryzen Embedded V1605B [1]
> 
> Thanks for the patience with your patch.
> 
> [1] https://en.wikichip.org/wiki/amd/ryzen_embedded/v1605b

Jerry, are you confident to give this tested-by?

I'm still in process of finding what I should put to .config in order
to get USB keyboard working with UDOO BOLT.

/Jarkko
