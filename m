Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939BDC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777A621479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfFSJgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:36:38 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:54387 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727068AbfFSJgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:36:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6B6F91803EF2F;
        Wed, 19 Jun 2019 09:36:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lake79_906b73ef29727
X-Filterd-Recvd-Size: 1631
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Jun 2019 09:36:32 +0000 (UTC)
Message-ID: <f22006fedb0204ad05858609bc9d3ed0abc6078e.camel@perches.com>
Subject: Re: [PATCH] net/ipv4: fib_trie: Avoid cryptic ternary expressions
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Date:   Wed, 19 Jun 2019 02:36:30 -0700
In-Reply-To: <CAKwvOd=i2qsEO90cHn-Zvgd7vbhK5Z4RH89gJGy=Cjzbi9QRMA@mail.gmail.com>
References: <20190618211440.54179-1-mka@chromium.org>
         <20190618230420.GA84107@archlinux-epyc>
         <CAKwvOd=i2qsEO90cHn-Zvgd7vbhK5Z4RH89gJGy=Cjzbi9QRMA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 16:23 -0700, Nick Desaulniers wrote:
> As a side note, I'm going to try to see if MAINTAINERS and
> scripts/get_maintainers.pl supports regexes on the commit messages in
> order to cc our mailing list

Neither.  Why should either?


