Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E07C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC19207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388679AbfFJSB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:01:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:50525 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388381AbfFJSB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:01:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 11:01:25 -0700
X-ExtLoop1: 1
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga003.jf.intel.com with ESMTP; 10 Jun 2019 11:01:25 -0700
Date:   Mon, 10 Jun 2019 11:01:25 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] EDAC, ie31200: Add Intel Coffee Lake CPU support
Message-ID: <20190610180121.GA22428@agluck-desk2.amr.corp.intel.com>
References: <20190609151613.195164-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609151613.195164-1-elver@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 05:16:13PM +0200, Marco Elver wrote:

Marco,

Thanks for the patch. One comment below.

> -	{
> -		PCI_VEND_DEV(INTEL, IE31200_HB_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		IE31200},
> -	{
> -		PCI_VEND_DEV(INTEL, IE31200_HB_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		IE31200},
> -	{
> -		PCI_VEND_DEV(INTEL, IE31200_HB_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		IE31200},
> -	{
> -		PCI_VEND_DEV(INTEL, IE31200_HB_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		IE31200},
> -	{
> -		PCI_VEND_DEV(INTEL, IE31200_HB_5), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		IE31200},
> -	{
> -		PCI_VEND_DEV(INTEL, IE31200_HB_6), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		IE31200},
> -	{
> -		PCI_VEND_DEV(INTEL, IE31200_HB_7), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		IE31200},
> -	{
> -		PCI_VEND_DEV(INTEL, IE31200_HB_8), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		IE31200},
> -	{
> -		PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -		IE31200},
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_5), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_6), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_7), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_8), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  IE31200 },
> +	{ PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  IE31200 },

Are these lines just changing the formatting from three lines
per entry to two?

I'm not opposed to this cleanup, but it isn't mentioned in the
commit message.  If you *really* want to make this prettier
then a helper macro:

#define PCI_DEV_ENTRY(did, chip) PCI_VEND_DEV(INTEL, did), PCI_ANY_ID, PCI_ANY_ID, 0, 0, chip

would make it look like this:

static const struct pci_device_id ie31200_pci_tbl[] = {
	{ PCI_DEV_ENTRY(IE31200_HB_1, IE31200) },
	...
	{ PCI_DEV_ENTRY(IE31200_HB_CFL_10, IE31200) },
	{ 0, } /* 0 terminated list. */
};

Then make one patch that does the cleanup by adding the macro
and using it for existing entry (marked "no functional change").

Second patch to add the new bits for Coffee Lake.

Thanks

-Tony
