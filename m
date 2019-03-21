Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D36AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A128218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553138078;
	bh=Gey+SnUTAuLKOvwiD+J3mBVX4CeINpCaIUQaZBPU0X4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r6h2eCeyqVZnaOLMV5SP9T+0sFd7iHbj8xKG/aWc/Oz/XKZMRk9CSjXyJCpVOJfZS
	 IyZ3+CLVcjsdCVyJejhhdlVv213niM7gYnWcL8YeDTJVPSF+7cqzrD/97m+g/3FozE
	 HX1tCbOCeIKR7MWJzZbILHR6QEh/QuWLKQb4lqyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfCUDOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:14:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUDOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:14:36 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0983B1869;
        Thu, 21 Mar 2019 03:14:34 +0000 (UTC)
Date:   Wed, 20 Mar 2019 20:14:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        linuxppc-dev@lists.ozlabs.org, Daniel Walker <dwalker@fifo99.com>,
        Maksym Kokhan <maksym.kokhan@globallogic.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/4] add generic builtin command line
Message-Id: <20190320201433.6c5c4782f4432d280c0e8361@linux-foundation.org>
In-Reply-To: <20190320232328.3bijcxek2yg43a25@zorba>
References: <20190319232448.45964-2-danielwa@cisco.com>
        <20190320155319.2cd3c0f73ef3cdefb65d5d1e@linux-foundation.org>
        <20190320232328.3bijcxek2yg43a25@zorba>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 16:23:28 -0700 Daniel Walker <danielwa@cisco.com> wrote:

> On Wed, Mar 20, 2019 at 03:53:19PM -0700, Andrew Morton wrote:
> > On Tue, 19 Mar 2019 16:24:45 -0700 Daniel Walker <danielwa@cisco.com> wrote:
> > 
> > > This code allows architectures to use a generic builtin command line.
> > 
> > I wasn't cc'ed on [2/4].  No mailing lists were cc'ed on [0/4] but it
> > didn't say anything useful anyway ;)
> > 
> > I'll queue them up for testing and shall await feedback from the
> > powerpc developers.
> > 
> 
> You weren't CC'd , but it was To: you,
> 
>  35 From: Daniel Walker <danielwa@cisco.com>
>  36 To: Andrew Morton <akpm@linux-foundation.org>,
>  37         Christophe Leroy <christophe.leroy@c-s.fr>,
>  38         Michael Ellerman <mpe@ellerman.id.au>,
>  39         Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
>  40         linuxppc-dev@lists.ozlabs.org, Frank Rowand <frowand.list@gmail.com>
>  41 Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
>  42 Subject: [PATCH 2/4] drivers: of: generic command line support

hm.

> Thanks for picking it up.

The patches (or some version of them) are already in linux-next,
which messes me up.  I'll disable them for now.

