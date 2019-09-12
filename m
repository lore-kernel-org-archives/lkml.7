Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00BCC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7986E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 14:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbfILOvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 10:51:43 -0400
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:38680 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732444AbfILOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 10:51:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 92CC1831D72C;
        Thu, 12 Sep 2019 14:51:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: yard89_8305e22eeb808
X-Filterd-Recvd-Size: 2937
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 14:51:40 +0000 (UTC)
Message-ID: <9d4633cf0bbf531393ce170444d607eb2e915f48.camel@perches.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 12 Sep 2019 07:51:39 -0700
In-Reply-To: <CAPcyv4iu13D5P+ExdeW8OGMV8g49fMUy52xbYZM+bewwVSwhjg@mail.gmail.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
         <20190911184332.GL20699@kadam>
         <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
         <CAPcyv4ij3s+9uO0f9aLHGj3=ACG7hAjZ0Rf=tyFmpt3+uQyymw@mail.gmail.com>
         <CANiq72k2so3ZcqA3iRziGY=Shd_B1=qGoXXROeAF7Y3+pDmqyA@mail.gmail.com>
         <e9cb9bc8bd7fe38a5bb6ff7b7222b512acc7b018.camel@perches.com>
         <5eebafcb85a23a59f01681e73c83b387c59f4a4b.camel@perches.com>
         <CAPcyv4iu13D5P+ExdeW8OGMV8g49fMUy52xbYZM+bewwVSwhjg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-12 at 07:17 -0700, Dan Williams wrote:

> Ok, good to confirm that we do not yet have an objective standard for
> coding style. This means it's not yet something process documentation
> can better standardize for contributors and will be subject to ongoing
> taste debates. Lets reclaim the time to talk about objective items
> that *can* clarified across maintainers.

No, let's not and just clarify whether or not whitespace
style patches are acceptable patch submissions.

Coding style fragmentation is not otherwise acceptable to me.

nvdimm mandating 2 tab indentation when nvdimm itself is not
at all consistent in that regard is also whitespace noise.

> As for libnvdimm at this point I'd rather start with objective
> checkpatch error cleanups and defer the personal taste items.

Fine by me.

I do want to avoid documenting per-subsystem coding styles.

How about adding something to MAINTAINERS like:

A:	Accepting patches by newbies or CodingStyle strict

and checkpatch could be changed turn off a bunch of
whitespace rules on a subsystem basis when run with
-f for files or without -f for a patch.

Most of this comes down to whitespace like

	a = b + c

where it hardly matters if the CodingStyle mandated
space around + is used or

	foo = bar(baz,
			qux)

where qux position is not really important.


