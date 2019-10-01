Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF85ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7D221855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388862AbfJAN4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:56:01 -0400
Received: from ms.lwn.net ([45.79.88.28]:36920 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfJAN4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:56:01 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 32FD6491;
        Tue,  1 Oct 2019 13:56:00 +0000 (UTC)
Date:   Tue, 1 Oct 2019 07:55:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C. Harding" <me@tobin.cc>, Olof Johansson <olof@lixom.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Joe Perches <joe@perches.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        vishal.l.verma@intel.com, linux-nvdimm@lists.01.org,
        ksummit-discuss@lists.linuxfoundation.org
Subject: Re: [PATCH v2 2/3] Maintainer Handbook: Maintainer Entry Profile
Message-ID: <20191001075559.629eb059@lwn.net>
In-Reply-To: <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
        <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 08:48:54 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> As presented at the 2018 Linux Plumbers conference [1], the Maintainer
> Entry Profile (formerly Subsystem Profile) is proposed as a way to reduce
> friction between committers and maintainers and encourage conversations
> amongst maintainers about common best practices. While coding-style,
> submit-checklist, and submitting-drivers lay out some common expectations
> there remain local customs and maintainer preferences that vary by
> subsystem.
> 
> The profile contains short answers to some of the common policy questions a
> contributor might have that are local to the subsystem / device-driver, or
> otherwise not covered by the top-level process documents.
> 
> Overview: General introduction to how the subsystem operates
> Submit Checklist Addendum: Mechanical items that gate submission staging
> Key Cycle Dates:
>  - Last -rc for new feature submissions: Expected lead time for submissions
>  - Last -rc to merge features: Deadline for merge decisions
> Coding Style Addendum: Clarifications of local style preferences
> Resubmit Cadence: When to ping the maintainer
> Checkpatch / Style Cleanups: Policy on pure cleanup patches

So I'm finally back home after my European tour, and I have it on good
authority that my bag might even get here eventually too.  That means I'm
digging through a pile of docs stuff I've been neglecting badly...

My intention is to apply these patches.  But as I was reading through
them, one little nagging thing came to mind...

> See Documentation/maintainer/maintainer-entry-profile.rst for more details,
> and a follow-on example profile for the libnvdimm subsystem.

Thus far, the maintainer guide is focused on how to *be* a maintainer.
This document, instead, is more about how to deal with specific
maintainers.  So I suspect that Documentation/maintainer might be the
wrong place for it.

Should we maybe place it instead under Documentation/process, or even
create a new top-level "book" for this information?

Thanks,

jon
