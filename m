Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFD5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 12:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC4520830
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 12:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfIVMEN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 08:04:13 -0400
Received: from ozlabs.org ([203.11.71.1]:50599 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbfIVMEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 08:04:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46bmMZ0TJPz9sCJ;
        Sun, 22 Sep 2019 22:04:09 +1000 (AEST)
Date:   Sun, 22 Sep 2019 22:03:59 +1000
User-Agent: K-9 Mail for Android
In-Reply-To: <CAPcyv4idejYpTS=ErsEJWgBxBsC1aS9=NCyvMEDO1rwqRktEmg@mail.gmail.com>
References: <1568988209.5576.199.camel@lca.pw> <87r24bhwng.fsf@linux.ibm.com> <1569003478.5576.202.camel@lca.pw> <CAPcyv4idejYpTS=ErsEJWgBxBsC1aS9=NCyvMEDO1rwqRktEmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: "Pick the right alignment default when creating dax devices" failed to build on powerpc
To:     Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
CC:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michael Ellerman <michael@ellerman.id.au>
Message-ID: <A619A864-511D-4782-8789-5AEC8797A111@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 September 2019 4:31:16 am AEST, Dan Williams <dan.j.williams@intel.com> wrote:
>On Fri, Sep 20, 2019 at 11:18 AM Qian Cai <cai@lca.pw> wrote:
>>
>> On Fri, 2019-09-20 at 19:55 +0530, Aneesh Kumar K.V wrote:
>> > Qian Cai <cai@lca.pw> writes:
>> >
>> > > The linux-next commit "libnvdimm/dax: Pick the right alignment
>default when
>> > > creating dax devices" causes powerpc failed to build with this
>config. Reverted
>> > > it fixed the issue.
>> > >
>> > > ERROR: "hash__has_transparent_hugepage"
>[drivers/nvdimm/libnvdimm.ko] undefined!
>> > > ERROR: "radix__has_transparent_hugepage"
>[drivers/nvdimm/libnvdimm.ko]
>> > > undefined!
>> > > make[1]: *** [scripts/Makefile.modpost:93: __modpost] Error 1
>> > > make: *** [Makefile:1305: modules] Error 2
>> > >
>> > > [1] https://patchwork.kernel.org/patch/11133445/
>> > > [2]
>https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
>> >
>> > Sorry for breaking the build. How about?
>>
>> It works fine.
>
>Thanks, but let's delay "libnvdimm/dax: Pick the right alignment
>default when creating dax devices" until after -rc1 to allow Michael
>time to ack/nak this new export.

Thanks Dan. It looks fine to me:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
