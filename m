Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BCBC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF81520989
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfELVQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 17:16:27 -0400
Received: from belmont80srvr.owm.bell.net ([184.150.200.80]:49469 "EHLO
        mtlfep02.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726664AbfELVQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 17:16:26 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 May 2019 17:16:26 EDT
Received: from bell.net mtlfep01 184.150.200.30 by mtlfep01.bell.net
          with ESMTP
          id <20190512211007.PJE4947.mtlfep01.bell.net@mtlspm02.bell.net>;
          Sun, 12 May 2019 17:10:07 -0400
Received: from [192.168.2.49] (really [70.53.52.226]) by mtlspm02.bell.net
          with ESMTP
          id <20190512211007.NNZJ21689.mtlspm02.bell.net@[192.168.2.49]>;
          Sun, 12 May 2019 17:10:07 -0400
Subject: Re: C3600, sata controller
To:     Carlo Pisani <carlojpisani@gmail.com>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190502074519.61272b42@canb.auug.org.au>
 <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
 <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
From:   John David Anglin <dave.anglin@bell.net>
Openpgp: preference=signencrypt
Message-ID: <f52cf203-c48a-fd04-5827-19903c3a192f@bell.net>
Date:   Sun, 12 May 2019 17:10:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-Analysis: v=2.3 cv=bJBo382Z c=1 sm=1 tr=0 cx=a_idp_f a=eekNWfHKKKZHbRJeTMr8Cw==:117 a=eekNWfHKKKZHbRJeTMr8Cw==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=E5NmQfObTbMA:10 a=FBHGMhGWAAAA:8 a=ReoYV_r7ABfIaPUG8vIA:9 a=QEXdDO2ut3YA:10 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4wfBh0+9ztLhlPK6JpM85nU3RMHM4SQEuolp551HznoTaWC+jfVOi3+hpxMJrfM5bKX4tWgcVVs2ZF+6Im50//tmRYLgNRCDwl4/kgySyY1E1Arv6zELfg yZleUPx3/x46e+LhVkBM96BBW7zRIebAi9/0O4zz9p+KabTWwPJvjQzMcY1x62TZT0bwLAtCIX/MK5I7jN+K7ptw/94+dCU4cpCal3njF+84tOdgkz1BBdLk ZNoarLQxe0osyRjDaQvMeYLSA4IxGPne2Kahj0Yr+UQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The c3600 doesn't have any PCI-X slots (only PCI) as far as I can tell from user manuals.

The SY-PCX40009 PCI-X card that I have says it supports two models: 32-bit at 66 MHz and 64-bit
at 133 MHz.  The 32-bit slots in c3600 are 33 MHz.  Whether the card will work at 33 MHz is not
clear.  The card says it's backward compatible to PCI 2.3.

On 2019-05-12 4:44 p.m., Carlo Pisani wrote:
> guys,
> I asked a friend to lend us his card, which is the card2 listed below
> and not things are becoming really weird
>
> card1, Silicon Image, Inc. Adaptec AAR-1210SA
> card2, Silicon Image, Inc. SiI 3124 PCI-X Serial ATA
>
> the card1 is a PCI32 bit card, and uses the "sata_sil" driver
> the card2 is a PCI64 bit card, and uses the "sata_sil24" driver
>
> card1 is installed in a PCI32 slot, and it's moving 32Gbyte in a loop
> without any issue
>
> I have just tested card2 in each of the PCI-X slot (including the 3.3V
> one) and ... it has always triggered the HPMC unit, crashing the
> machine
>
> the hardware is different, and drivers are also different, but  ....
> maybe the problem is related to 32 vs 64bit?
>
> I am going to repeat the test with card2 installed in a PCI32 slot.
> This should force it to 32bit: will it work correctly?
> (hope this makes sense)
>
> ---
>
> we have also checked if the kernel is correctly handling the ram
> we have a C3600 with 8Gbyte of ram
>
> mount -t tmpfs -o size=7G tmpfs /mnt/ramdrive/
> dd if=/dev/zero of=/mnt/ramdrive/test.bin
> badblocks -swv /mnt/ramdrive/test.bin
>
> checking for bad blocks in read-write mode
> >From block 0 to 7340031
> Testing with pattern 0xaa: done
> Reading and comparing: done
> Testing with pattern 0x55: done
> Reading and comparing: done
> Testing with pattern 0xff: done
> Reading and comparing: done
> Testing with pattern 0x00: done
> Reading and comparing: done
> Pass completed, 0 bad blocks found.
>
> no problems found
>


-- 
John David Anglin  dave.anglin@bell.net

