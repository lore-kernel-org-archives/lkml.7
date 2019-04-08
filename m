Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCCC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C4B2148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 22:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfDHWOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 18:14:48 -0400
Received: from namei.org ([65.99.196.166]:60896 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbfDHWOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 18:14:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x38MDfcA019064;
        Mon, 8 Apr 2019 22:13:41 GMT
Date:   Tue, 9 Apr 2019 08:13:41 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Subject: Re: [GIT PULL] tpmdd fixes for Linux v5.1
In-Reply-To: <CAA9_cmdyERPGwz-S3XuyJXnYrHM5V1fb_BCf_NS_kgQdN-YS=A@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1904090813230.18801@namei.org>
References: <20190329115544.GA27351@linux.intel.com> <alpine.LRH.2.21.1903300540530.2240@namei.org> <CAA9_cmdyERPGwz-S3XuyJXnYrHM5V1fb_BCf_NS_kgQdN-YS=A@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019, Dan Williams wrote:

> On Fri, Mar 29, 2019 at 11:42 AM James Morris <jmorris@namei.org> wrote:
> >
> > On Fri, 29 Mar 2019, Jarkko Sakkinen wrote:
> >
> > > Hi James,
> > >
> > > These are critical fixes for v5.1. Contains also couple of new selftests for
> > > v5.1 features (partial reads in /dev/tpm0). I hope these could still reach
> > > the release. Thanks.
> >
> > Applied to
> > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tpm
> 
> Hi James,
> 
> Friendly ping on when might this go to Linus?
> 
> I was hoping that 3d0b1a381f6e ("KEYS: trusted: allow trusted.ko to
> initialize w/o a TPM") would have hit -rc4. The NVDIMM subsystem has
> been broken since -rc1.

Oops, I queued these for the wrong tree, will send to Linus today.

-- 
James Morris
<jmorris@namei.org>

