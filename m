Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F8C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE36620679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfHMHnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:43:18 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:43637 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726810AbfHMHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:43:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BBDD75009;
        Tue, 13 Aug 2019 07:43:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: van78_1c3a8abe7f93e
X-Filterd-Recvd-Size: 2204
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Aug 2019 07:43:13 +0000 (UTC)
Message-ID: <2a6c7952793a7973c7edc6b2c44ac3c2587562fd.camel@perches.com>
Subject: Re: [PATCH v2] kbuild: Change fallthrough comments to attributes
From:   Joe Perches <joe@perches.com>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Tue, 13 Aug 2019 00:43:12 -0700
In-Reply-To: <3078e553a777976655f72718d088791363544caa.camel@perches.com>
References: <20190812214711.83710-1-nhuck@google.com>
         <20190812221416.139678-1-nhuck@google.com>
         <814c1b19141022946d3e0f7e24d69658d7a512e4.camel@perches.com>
         <CAKwvOdnpXqoQDmHVRCh0qX=Yh-8UpEWJ0C3S=syn1KN8rB3OGQ@mail.gmail.com>
         <20190813063327.GA46858@archlinux-threadripper>
         <3078e553a777976655f72718d088791363544caa.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-13 at 00:04 -0700, Joe Perches wrote:
> On Mon, 2019-08-12 at 23:33 -0700, Nathan Chancellor wrote:
[]
> > a disagreement between GCC and Clang on
> > emitting a warning when falling through to a case statement that is
> > either the last one and empty or simply breaks..
[]
> > I personally think that GCC is right and Clang should adapt but I don't
> > know enough about the Clang codebase to know how feasible this is.
> 
> I think gcc is wrong here and code like
> 
> 	switch (foo) {
> 	case 1:
> 		bar = 1;
> 	default:
> 		break;
> 	}
> 
> should emit a fallthrough warning.

btw: I just filed https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91432


