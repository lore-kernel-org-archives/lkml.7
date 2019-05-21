Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E341FC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8572173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfEUH5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:57:43 -0400
Received: from smtprelay0034.hostedemail.com ([216.40.44.34]:37087 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbfEUH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:57:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EA649180178A1;
        Tue, 21 May 2019 07:57:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sort67_430d7b49e2635
X-Filterd-Recvd-Size: 1832
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 May 2019 07:57:40 +0000 (UTC)
Message-ID: <38aa2fcceaf7c2c7c6cd7c3abe2999fe7ef98a44.camel@perches.com>
Subject: Re: [PATCH] powerpc/mm: mark more tlb functions as __always_inline
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 21 May 2019 00:57:39 -0700
In-Reply-To: <CAK7LNAQNp+wsvNK84oYcGwR24=Kf=_N8WJdyZ2aUL9T3qDsVsA@mail.gmail.com>
References: <20190521061659.6073-1-yamada.masahiro@socionext.com>
         <16d967dd-9f8f-4e9e-97fd-3f9761e5d97c@c-s.fr>
         <CAK7LNAQNp+wsvNK84oYcGwR24=Kf=_N8WJdyZ2aUL9T3qDsVsA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-21 at 16:27 +0900, Masahiro Yamada wrote:
> On Tue, May 21, 2019 at 3:54 PM Christophe Leroy
> > powerpc accepts lines up to 90 chars, see arch/powerpc/tools/checkpatch.pl
> 
> Ugh, I did not know this. Horrible.
> 
> The Linux coding style should be global in the kernel tree.
> No subsystem should adopts its own coding style.

I don't see a problem using 90 column lines by arch/<foo>

There are other subsystem specific variations like the net/

	/* multiline comments without initial blank comment lines
	 * look like this...
	 */

If there were arch specific drivers with style variations
in say drivers/net, then that might be more of an issue.

