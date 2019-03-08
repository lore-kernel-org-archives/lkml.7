Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC28C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E6A20840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCHA1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:27:25 -0500
Received: from smtprelay0066.hostedemail.com ([216.40.44.66]:48817 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbfCHA1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:27:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id F2085181D3403;
        Fri,  8 Mar 2019 00:27:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: jail11_7a595f8329b3a
X-Filterd-Recvd-Size: 2024
Received: from XPS-9350 (unknown [149.142.244.224])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Mar 2019 00:27:20 +0000 (UTC)
Message-ID: <31b6d5bdfda9cbadffa6d8cb3ad0991e237a364c.camel@perches.com>
Subject: Re: [PATCH] signal: fix building with clang
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-mips@vger.kernel.org
Date:   Thu, 07 Mar 2019 16:27:19 -0800
In-Reply-To: <CAKwvOd=nyhM72CxdO-YYSsXr7rh3LUALn_ezVNzyiBaOD7KZkA@mail.gmail.com>
References: <20190307091218.2343836-1-arnd@arndb.de>
         <20190307152805.GA25101@redhat.com>
         <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
         <20190307164647.GC25101@redhat.com>
         <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
         <CAKwvOd=nyhM72CxdO-YYSsXr7rh3LUALn_ezVNzyiBaOD7KZkA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 16:22 -0800, Nick Desaulniers wrote:
> On Thu, Mar 7, 2019 at 1:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > I'd have to try, but I think you are right. It was probably an
> > overoptimization back in 1997 when the code got added to
> > linux-2.1.68pre1, and compilers have become smarter in the
> > meantime ;-)
> 
> How do you track history pre-git (2.6.XX)?

https://landley.net/kdocs/fullhist/


