Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74C3C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0DCE20679
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfKYP56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:57:58 -0500
Received: from ms.lwn.net ([45.79.88.28]:57114 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbfKYP56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:57:58 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 51F582D6;
        Mon, 25 Nov 2019 15:57:57 +0000 (UTC)
Date:   Mon, 25 Nov 2019 08:57:56 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: riscv: add patch acceptance guidelines
Message-ID: <20191125085756.75b8088d@lwn.net>
In-Reply-To: <alpine.DEB.2.21.9999.1911241841210.22625@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com>
        <20191123092552.1438bc95@lwn.net>
        <alpine.DEB.2.21.9999.1911231523390.14532@viisi.sifive.com>
        <CAPcyv4hmagCVLCTYmmv0U8-YD5BEoQPV=wtm5hbp3MxqwZRQUA@mail.gmail.com>
        <alpine.DEB.2.21.9999.1911231546450.14532@viisi.sifive.com>
        <CAPcyv4hBNfabaZmKs0XF+UT9Py8zJqpNdu5KsToqp305NASKNA@mail.gmail.com>
        <alpine.DEB.2.21.9999.1911231637510.14532@viisi.sifive.com>
        <CAPcyv4iqTR8s0v8jH7haWCBQAzhZinUEsypiH7Ts9FCf+F9Bvg@mail.gmail.com>
        <alpine.DEB.2.21.9999.1911241841210.22625@viisi.sifive.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019 18:48:54 -0800 (PST)
Paul Walmsley <paul.walmsley@sifive.com> wrote:

> On Sat, 23 Nov 2019, Dan Williams wrote:
> 
> > I'm open to updating the headers to make a section heading that
> > matches what you're trying to convey, however that header definition
> > should be globally agreed upon. I don't want the document that tries
> > to clarify per-subsystem behaviours itself to have per-subsystem
> > permutations. I think we, subsystem maintainers, at least need to be
> > able to agree on the topics we disagree on.  
> 
> Unless you're planning to, say, follow up with some kind of automated 
> process working across all of the profile documents in such a way that it 
> would make technical sense for the different sections to be standardized, 
> I personally don't see any need at all for profile document 
> standardization.  As far as I can tell, these documents are meant for 
> humans, rather than computers, to read.  And in the absence of a strong 
> technical rationale to limit how maintainers express themselves here, I 
> don't think it's justified.

Patch changelogs are (mostly) meant for humans to read too, but we have
some standards for how we want them formatted.  I don't think the
maintainer profiles should be all that tightly specified, but it would be
a whole lot better if cross-subsystem developers knew where to look to
quickly find the information they need.  So I'd prefer it if we could find
a way to conform to a set of loose guidelines for these files.

Thanks,

jon
