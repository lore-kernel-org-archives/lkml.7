Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0967C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C162208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 23:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfEMXOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 19:14:09 -0400
Received: from simcoe208srvr.owm.bell.net ([184.150.200.208]:50768 "EHLO
        torfep02.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726233AbfEMXOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 19:14:08 -0400
Received: from bell.net torfep02 184.150.200.158 by torfep02.bell.net
          with ESMTP
          id <20190513231406.ZXNA4684.torfep02.bell.net@torspm02.bell.net>;
          Mon, 13 May 2019 19:14:06 -0400
Received: from [192.168.2.49] (really [70.53.52.226]) by torspm02.bell.net
          with ESMTP
          id <20190513231406.QMCT30132.torspm02.bell.net@[192.168.2.49]>;
          Mon, 13 May 2019 19:14:06 -0400
Subject: Re: C3600, sata controller
To:     Carlo Pisani <carlojpisani@gmail.com>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190502074519.61272b42@canb.auug.org.au>
 <a645ff18-4c55-6b4c-0913-5b397ab83e03@gmx.de>
 <CA+QBN9A4PhPZ36otsk0TRaO9KKnKL=hfnskfFJGQJEbtb3=i=Q@mail.gmail.com>
 <f52cf203-c48a-fd04-5827-19903c3a192f@bell.net>
 <CA+QBN9AZHQHTGFVc21UfROHObKxAZz+bwCPeMf-Tpjn2UHmDNg@mail.gmail.com>
From:   John David Anglin <dave.anglin@bell.net>
Openpgp: preference=signencrypt
Message-ID: <66bf0e79-16a4-a411-19ba-cd7d5a232976@bell.net>
Date:   Mon, 13 May 2019 19:14:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+QBN9AZHQHTGFVc21UfROHObKxAZz+bwCPeMf-Tpjn2UHmDNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-Analysis: v=2.3 cv=O5JHQy1W c=1 sm=1 tr=0 cx=a_idp_f a=eekNWfHKKKZHbRJeTMr8Cw==:117 a=eekNWfHKKKZHbRJeTMr8Cw==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=E5NmQfObTbMA:10 a=5ypQrAzGAAAA:8 a=FBHGMhGWAAAA:8 a=gMXUH_YgnVnNn84jM3AA:9 a=QEXdDO2ut3YA:10 a=1owwN5pLhQMA:10 a=RW6egZ3iF6EA:10 a=QnlTcYk_iZbCEFXf-YqT:22 a=9gvnlMMaQFpL9xblJ6ne:22
X-CM-Envelope: MS4wfK4WAh+Fq4jLCtWs5OgHHMkWkHH9sKFtHVcfXHN5FKDl/AqcUjDjP6fkt0hpWzjYDKpR13dGH2F7Yil6hOJgnk+eAbsz9hkCwem6X8UhlCHVXmSehYqk iTHsCNoOIR9vnkB5Mk1EXI7GD9kXCPcWKMkNZQesJ7uwsjz1SZBvg1p4GBRD3tlUz1doZ8LAaFvf2DjjWTJpn0fbRkQg8rs9clkjzqUJm1hcOrBKFlgIzS3W g7X8KBUkaFtv9raac32h4gQcWuPNDYN/j/WPWcSb1V0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-12 5:15 p.m., Carlo Pisani wrote:
>> The c3600 doesn't have any PCI-X slots (only PCI) as far as I can tell from user manuals.
> PCI-32/33 device I/O bus
> PCI-64/33 high-performance device I/O bus <----------------- this is
> PCI-X, 64bit 5V
> PCI-64/66 high-performance graphics I/O bus <----------------- this is
> PCI-X, 64bit 3.3V
>
> https://www.openpa.net/systems/hp-visualize_b1000_c3000_c3600.html
I think that you are wrong.  HP would have said the slots were PCI-X compatible if they were.
They did in c8000.

The issue is probably the signalling voltage and clock rate capability.  33 MHz always uses 5V
signalling whereas PCX-X cards typically support 66 and 133 MHz.  Thus, I think PCI-X cards use
CMOS 3.3V signalling although they may accept 5V on their inputs.  If the c3600 uses older
TTL logic, it is likely that 3.3V CMOS logic can't provide the high level for 5V TTL logic.

I suspect the only slot that might work with a PCI-X card is the 3.3V SL2.  However, if you see I/O errors
in the PIM dump following a HPMC, then it's not compatible.

So, probably you would have better luck with the PCI Syba SD-SATA150R in c3600.  However, it is similar
to the Adaptec 1210SA which works.  Maybe they differ in RAID capability.

Dave

-- 
John David Anglin  dave.anglin@bell.net

