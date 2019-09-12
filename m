Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF7C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEC520830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 23:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfILX0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 19:26:41 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:42011 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726905AbfILX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 19:26:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 9A7731801A086;
        Thu, 12 Sep 2019 23:26:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: skin44_742702c58da54
X-Filterd-Recvd-Size: 1793
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 23:26:38 +0000 (UTC)
Message-ID: <fdd69f54908d90cd0c93af7b5d80a6c3ca3b5817.camel@perches.com>
Subject: clang-format and 'clang-format on' and 'clang-format off'
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm-dev@lists.llvm.org
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 12 Sep 2019 16:26:37 -0700
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

> > Marking sections _no_auto_format_ isn't really a
> > good solution is it?
> 
> I am thinking about special tables that are hand-crafted or very
> complex macros. For those, yes, I think it is a fine solution.

Can the 'clang-format on/off' trigger be indirected into
something non-clang specific via a macro?

Not every project is going to use only the clang-format tool.

