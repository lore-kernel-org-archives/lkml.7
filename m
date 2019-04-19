Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF395C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13C6217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfDST5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:57:46 -0400
Received: from mleia.com ([178.79.152.223]:48710 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfDST5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:57:45 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 568D94634D8;
        Fri, 19 Apr 2019 20:57:44 +0100 (BST)
Subject: Re: [PATCH] ARM: lpc32xx: stop overwriting TEST_CLK_SEL
To:     gregory.clement@bootlin.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190411141209.3106-1-alexandre.belloni@bootlin.com>
 <b5b97198d85ead33afa2fcf619a50944@bootlin.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <c298fc6a-b47b-fd3c-f9be-f45fe2ba3e01@mleia.com>
Date:   Fri, 19 Apr 2019 22:57:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b5b97198d85ead33afa2fcf619a50944@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190419_205744_373136_1BA18AFD 
X-CRM114-Status: UNSURE (   8.54  )
X-CRM114-Notice: Please train this message. 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre, Gregory,

On 04/15/2019 10:59 AM, gregory.clement@bootlin.com wrote:
> On 2019-04-11 16:12, Alexandre Belloni wrote:
>> While the UDA1380 is described in some lpc3250 device trees, there is
>> currently no real user of that codec. Anyway, if the codec needs a 
>> clock,
>> it should take it explicitly.
>>
>> lpc3250_machine_init is called for all the lpc32xx machines and some 
>> are
>> using test1_clk (for example to strobe an HW watchdog). Overwriting
>> TEST_CLK_SEL prevents booting those platforms.
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

I've applied the change to my tree, hopefully it will be included into v5.2.

Thank you!

--
Best wishes,
Vladimir
