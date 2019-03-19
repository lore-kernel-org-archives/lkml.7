Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA69C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9BB20854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="JibBT9P/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCSJk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:40:57 -0400
Received: from mail2.skidata.com ([91.230.2.91]:11344 "EHLO mail2.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfCSJk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:40:57 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Mar 2019 05:40:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1552988456; x=1584524456;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=pH1iyEMKmz7n5W/eUIYRFrO/gL7CW34g/2pLR7o03TU=;
  b=JibBT9P/0Qk0EjNBRn2I8pSv5yasSmwrCOuNKyzSpCzloAAqIVdz94yS
   SsnZafY9QNZ3Ot126Af4sEQfIXCkrH4H8Fj+I9R++G3pdhNMC5h9Gp4gr
   wJqvDk+5PMM4xQPToTQmPXUFQZ31YcNbUap5XboINKP+3BUbvLRps0u7x
   C1LSFr34ecqHAdqHawRF2nOp1r5mYac7tDcACwHRTPX4ZBLX0lsRRa+/V
   wsbiTUTM63pT5cEESMlC8NiIhYYC8yLmB7v8zhKwXhOZT4cTIw8UIKdZb
   +pc9zciFwMX5ggoFtEogf1BaEL6c4ohdtH8Q5wtu3ihAicPhH/CMlLu1z
   A==;
IronPort-SDR: YBFGLWCn7zelsJjs+IGaQWVWySPCJczBPq8KdUDCtDjbXvUv4ltTTdmNFa9fPDWzB/ARz9x/xo
 vSprZ2vyaHBOsULn0/cC+ZGd+4lSdGTo74bXIq0x/YbGm1AWA02y3vA4GR2IjOdQVjPFasnne7
 Ci7Y555MxOk4Q/tzPwd9qLffrl3+WhRpWPequWAtC8s2YSbAdeMjL22FFfyC0czW/HSAaoWbiG
 LTGzsIO+CHlbJ1nDZIRBkonYA0W3kShVn6X2Vuaz49uw28Cihvf6Qiwn3DedIQ+HFrndYhyGiT
 1T4=
X-IronPort-AV: E=Sophos;i="5.58,497,1544482800"; 
   d="scan'208";a="2041749"
Subject: Re: [PATCH] usb: usb251xb: Remove unnecessary comparison of unsigned
 integer with >= 0
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190318145024.GA572@embeddedor>
 <20190318153425.rxx3fwq2hi6tfocr@pengutronix.de>
 <f8785dc1-fa14-4e01-b89a-088cffdc350f@skidata.com>
 <20190318164811.quofap3b5mjlj5tc@pengutronix.de>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <c0c4531b-0590-6587-0aa7-9ca05a1b5c7c@skidata.com>
Date:   Tue, 19 Mar 2019 10:33:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318164811.quofap3b5mjlj5tc@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.22]
X-ClientProxiedBy: sdex4srv.skidata.net (192.168.111.82) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/03/2019 17:48, Marco Felsch wrote:
> On 19-03-18 16:46, Richard Leitner wrote:
>> A small note on further improvement from my side:
>>
>> According the datasheet, when you set swap-dx-lanes to 0 (-> setting port to
>> 0 -> setting bit 0 of PRTSP) "   the upstream port DP/DM is swapped".
> 
> Yes I know that's not intuitve and may confuses the users.
> 
>> IMHO this is not straight-forward, so maybe we want to additionally
>>
>> 	a) mention it somewhere in the documentation
> 
> IMHO this is the correct place.
> 
>> 	b) check on port >= 1
> 
> I think this isn't doable since we shouldn't break the existing dt.

ACK.

@Marco/Gustavo: does one of you wants to provide a patch for this?

> 
> Regards,
> Marco
> 
>> 	c) something else?
>>
>> Any opinions on that from your side? ... I'd prefer "a"...

regards;Richard.L
