Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DDBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F88206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 00:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLKACD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:02:03 -0500
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:45817 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbfLKACC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 19:02:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 2F575182CF666;
        Wed, 11 Dec 2019 00:02:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: loaf54_4b49ceef1b95b
X-Filterd-Recvd-Size: 1455
Received: from XPS-9350 (unknown [66.178.38.77])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Dec 2019 00:01:56 +0000 (UTC)
Message-ID: <4f3e350d0fcef89e25350f7d68ea96f33dc4e3f0.camel@perches.com>
Subject: Re: get_maintainer.pl produces non-deterministic results
From:   Joe Perches <joe@perches.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vegard Nossum <vegard.nossum@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Date:   Tue, 10 Dec 2019 16:01:15 -0800
In-Reply-To: <CACT4Y+YcCW=xwys6tvhOLXiND=2Cwe-NFkn0MDKHi=8HdGWppg@mail.gmail.com>
References: <CACT4Y+YcCW=xwys6tvhOLXiND=2Cwe-NFkn0MDKHi=8HdGWppg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-12-10 at 14:47 +0100, Dmitry Vyukov wrote:
> Hi Joe,
> 
> scripts/get_maintainer.pl fs/proc/task_mmu.c
> non-deterministically gives me from 13 to 16 results, different number
> every time (on upstream 6794862a). Perl v5.28.1. Michael confirmed
> this with v5.28.2.
> Vergard suggested to check PERL_HASH_SEED=0. Indeed it fixes
> non-determinism. But I guess it's not the right solution, there should
> be some logical problem.
> My perl-fo is weak, I appreciate if somebody with proper perl-fo takes a look.
> 
> Thanks

https://lkml.org/lkml/2017/7/13/789


