Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D02ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC8420854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 16:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbfJNQr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 12:47:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:7621 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730030AbfJNQr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 12:47:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 09:47:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="396530204"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga006.fm.intel.com with ESMTP; 14 Oct 2019 09:47:57 -0700
Message-ID: <0c18136df4c261afaa55debc72f9a2d3249771e1.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/6] Add CascadeLake-N Support
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>, andriy.shevchenko@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Oct 2019 09:47:56 -0700
In-Reply-To: <67aaedb2-dc74-7a60-7345-1c160e6b08e5@redhat.com>
References: <20191007193100.36934-1-srinivas.pandruvada@linux.intel.com>
         <67aaedb2-dc74-7a60-7345-1c160e6b08e5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-10-14 at 09:15 -0400, Prarit Bhargava wrote:
> 
> On 10/7/19 3:30 PM, Srinivas Pandruvada wrote:
> > Add support for SST-BF on CascadeLake-N support.  The CascadeLake-N
> > processor only support SST-BF and not other SST functionality.
> > 
> 
> Sorry Srinivas, was away from keyboard all last week :(
> 
> > v3:
> > Fix crash due to geline
> 
> ^^^ curious how you hit this?  I was repeatedly testing and couldn't
> get it to happen.
I guess this depend on weather the local variable happen to be NULL.
This happens 100% on the system I am testing.

Thanks,
Srinivas

> 
> > Fix display to perf-profile info and base-freq info command
> > Fix output for coremask
> > Fix base frequency CPU list. This should be displayed for a package
> > Auto mode support for base-freq enable/disable
> > One of the patch for config only change folded to next one where it
> > is
> > used.
> > 
> > The patch 1 has nothing to do with the CLX-N. It saves some bytes
> > in the
> > size.
> > 
> 
> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> 
> P.

