Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1636BC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12302084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404167AbfIJMe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:34:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:55125 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbfIJMe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:34:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2019 05:34:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="185495499"
Received: from mweingar-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.26])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2019 05:34:54 -0700
Date:   Tue, 10 Sep 2019 13:34:52 +0100
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: tpm_crb: enhance command and response buffer
 size calculation code
Message-ID: <20190910123452.GC7484@linux.intel.com>
References: <20190909090906.28700-1-kkamagui@gmail.com>
 <20190909090906.28700-2-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909090906.28700-2-kkamagui@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 06:09:05PM +0900, Seunghun Han wrote:
> The purpose of crb_fixup_cmd_size() function is to work around broken
> BIOSes and get the trustable size between the ACPI region and register.
> When the TPM has a command buffer and response buffer independently,
> the crb_map_io() function calls crb_fixup_cmd_size() twice to calculate
> each buffer size.  However, the current implementation of it considers
> one of two buffers.
> 
> To support independent command and response buffers, I changed
> crb_check_resource() function for storing ACPI TPB regions to a list.
> I also changed crb_fixup_cmd_size() to use the list for calculating each
> buffer size.
> 
> Signed-off-by: Seunghun Han <kkamagui@gmail.com>

I think as far as the tpm_crb goes I focus on getting Vanya's change
landed because it is better structured, more mature and the first
version was sent couple of weeks earlier. You are welcome to make
your remarks on that patch.

/Jarkko
