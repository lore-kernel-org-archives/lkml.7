Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E20220830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfDANxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:53:42 -0400
Received: from mailrelay4.webfaction.com ([185.20.51.6]:54582 "EHLO
        mailrelay4.webfaction.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbfDANxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:53:42 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Apr 2019 09:53:41 EDT
Received: from mailrelay3.webfaction.com (mailrelay3.webfaction.com [207.38.93.110])
        by mailrelay4.webfaction.com (Postfix) with ESMTPS id 0A014A5491
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 13:45:22 +0000 (UTC)
Received: from mailrelay1.webfaction.com (mailrelay1.webfaction.com [207.38.86.46])
        by mailrelay3.webfaction.com (Postfix) with ESMTPS id 983D8280936
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 13:45:20 +0000 (UTC)
Received: from smtp.webfaction.com (mail6.webfaction.com [31.170.123.134])
        by mailrelay1.webfaction.com (Postfix) with ESMTPS id 8FAEC1A051E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 13:45:19 +0000 (UTC)
Received: from [192.168.1.151] (dynamic-adsl-62-10-111-52.clienti.tiscali.it [62.10.111.52])
        by smtp.webfaction.com (Postfix) with ESMTPSA id D613E605829C9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2019 13:44:57 +0000 (UTC)
Subject: Re: [PATCH 0/4] Introduce the aural error reporting framework
To:     linux-kernel@vger.kernel.org
References: <20190401102456.11162-1-mcroce@redhat.com>
From:   Emiliano Russo <emiliano@verdebinario.org>
Message-ID: <6f0054fb-bc1a-b8f2-dccf-ec0088d1e382@verdebinario.org>
Date:   Mon, 1 Apr 2019 15:45:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190401102456.11162-1-mcroce@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Il 01/04/19 12:24, Matteo Croce ha scritto:

> These are all cases when the aural errors framework comes to help. This
> framework adds to the kernel a generic library to play sounds, which can
> be used to report errors or generic events.

hello Matteo,

this reminds me of a hack that Mr. Ferruccio Zulian (chief system 
architect for Olivetti, General Electric, Honeywell and IBM from 1965 to 
1990) told us about during an interview we made for our computer art 
exhibition "bin/art"

When testing the hardware of a new system, back in the mid-60s, the 
engineers hooked audio output to circuitry for debugging purposes.

They kept in mind how a set of correctly executed operations 
**literally** sounded like and therefore they were able to detect errors 
in later executions when something sounded "wrong".

This was way more easy than looking at the light panels commonly used 
for similar debugging activities, as listening to sounds does not force 
you to be in a particular place, looking at a particular object.

As explained in the interview, an interesting side effect of this hack 
led to the early computer music experiments with Pietro Grossi (a real 
giant in contemporary and electronic music) that ended up in the 
recording "GE-115 concerto" 7 inch vinyl, distributed as christmas gift 
to all Olivetti/General Electric employees in 1967.

here's the link to a webpage with the interview (in italian)

https://binart.eu/ge-115-concerto/

and to the recording itself

side A: https://www.youtube.com/watch?v=CXosSsSekaU
side B: https://www.youtube.com/watch?v=bf8jMA_zizc


...so, what does this curious anectode say to us?

it looks like history is on the side of this patch :-)

hope it gets in the mainline code!


Ciao!
Emiliano Russo
---------------
Museo Interattivo di Archeologia Informatica (MIAI)
Museo dell'Informatica Funzionante (MusIF)

Computer Musea :-)
