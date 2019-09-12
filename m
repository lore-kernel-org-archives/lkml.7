Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E26C4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB5320830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfILWin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:38:43 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:57107 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbfILWim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:38:42 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id DEFFE181D3377;
        Thu, 12 Sep 2019 22:38:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stone95_85d3c9f42163a
X-Filterd-Recvd-Size: 2128
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 22:38:39 +0000 (UTC)
Message-ID: <4f759f8c4f4d59fd60008e833334e29b0da0869c.camel@perches.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 12 Sep 2019 15:38:38 -0700
In-Reply-To: <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
References: <cover.1568256705.git.joe@perches.com>
         <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
         <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
         <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
         <CANiq72mgbepmw=G5pM7iSRf-Eob7AHFzLw=76uFivpNGtccyKw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 23:58 +0200, Miguel Ojeda wrote:
> On Thu, Sep 12, 2019 at 11:08 PM Joe Perches <joe@perches.com> wrote:
> > Please name the major projects and then point to their
> > .clang-format equivalents.
> > 
> > Also note the size/scope/complexity of the major projects.
> 
> Mozilla, WebKit, LLVM and Microsoft. They have their style distributed
> with the official clang-format, not sure if they enforce it.

At least for LLVM, it appears not.

I just tried a very small portion of the clang compiler:

$ git ls-files llvm/lib/CodeGen/ | wc -l
293
$ git ls-files llvm/lib/CodeGen/ | xargs clang-format -i

and got:

$ git diff --shortstat
 245 files changed, 19519 insertions(+), 17794 deletions(-)

btw: that seems a pretty small ~7% of the overall lines

$ git ls-files llvm/lib/CodeGen/ | xargs wc -l | tail -1
 251034 total


