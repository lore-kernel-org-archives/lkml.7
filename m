Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8E0C4CEC8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C6220830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfILVIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:08:21 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:42087 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728210AbfILVIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:08:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0F77D182CED5B;
        Thu, 12 Sep 2019 21:08:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: prose06_4875ac028f41a
X-Filterd-Recvd-Size: 1878
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 21:08:17 +0000 (UTC)
Message-ID: <4df0a07ec8f1391acfa987ecef184a50e7831000.camel@perches.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jeff Moyer <jmoyer@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 12 Sep 2019 14:08:16 -0700
In-Reply-To: <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
References: <cover.1568256705.git.joe@perches.com>
         <x498sqtvclx.fsf@segfault.boston.devel.redhat.com>
         <CANiq72kTsf=0rEufDMo7BzMNv1dqc5=ws7fSd=H_e=cpHR24Kg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 16:21 +0200, Miguel Ojeda wrote:

> As soon as you get accustomed to have formatting done and enforced
> automatically, it is great. Other major projects have done so for
> quite a while now.

Please name the major projects and then point to their
.clang-format equivalents.

Also note the size/scope/complexity of the major projects.

thanks.

> If doesn't think it is good enough, please let us know and, if it is
> close enough, we can look at going for a newer LLVM to match the style
> a bit more.

I used the latest one, and quite a bit of the conversion
was unpleasant to read.

>  Also note that one can disable formatting for some
> sections of code if really needed.

Marking sections _no_auto_format_ isn't really a
good solution is it?
.


