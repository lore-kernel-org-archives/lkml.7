Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E616C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3048A217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbfDSUwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:52:07 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42358 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfDSUwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:52:06 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hHaUM-0007uD-Dy; Fri, 19 Apr 2019 22:52:02 +0200
Date:   Fri, 19 Apr 2019 22:52:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
cc:     Daniel Drake <drake@endlessm.com>, Len Brown <lenb@kernel.org>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux@endlessm.com, rjw@rjwysocki.net,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Detecting x86 LAPIC timer frequency from CPUID data
In-Reply-To: <20190419135037.5bf5750e@jacob-builder>
Message-ID: <alpine.DEB.2.21.1904192251230.3174@nanos.tec.linutronix.de>
References: <20190419083533.32388-1-drake@endlessm.com> <alpine.DEB.2.21.1904191042180.3174@nanos.tec.linutronix.de> <20190419135037.5bf5750e@jacob-builder>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019, Jacob Pan wrote:
> On Fri, 19 Apr 2019 10:57:10 +0200 (CEST)
> Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 19 Apr 2019, Daniel Drake wrote:
> > > 0x7FFFFF vs 0x7FFFFFFF, is that intentional?  
> > 
> > I don't think so. Looks like a failed copy and paste. Cc'ed Jacob, he
> > might know.
> > 
> At the time of v2.6.35 both places use 0x7FFFFF. But later this patch
> increased the latter to 0x7FFFFFFF but forgot the first part. So I
> guess it is not exactly a failed copy and paste.
> 
> commit 4aed89d6b515b9185351706ca95cd712c9d8d6a3
> Author: Pierre Tardy <pierre.tardy@intel.com>
> Date:   Thu Jan 6 16:23:29 2011 +0100
> 
>     x86, lapic-timer: Increase the max_delta to 31 bits

Indeed. Thanks for digging that up!

	tglx
