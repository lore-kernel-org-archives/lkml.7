Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6780EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A437206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AJIbE8+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfGAKdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:33:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46424 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAKdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:33:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x61AXUmH010809;
        Mon, 1 Jul 2019 05:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561977210;
        bh=dSkYkRG1lighboAGBLcJ4wQ6KtvkselZluhkHuDj5wA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AJIbE8+lx7C6qnz3bPvqLTED/xyrv51G1neHLAKlTLABKIIBzEMTnhA/wZouAwtm2
         +3BHdYoZtDVsr6nf2Gdy2tupfb2PuiosGqKYs3h5hah540ddgTj+H0urdzcfQofF+R
         7sXIhcj25Z/JkgSgu3iSA1NQjw1OpCf/eATV3848=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x61AXUmY046275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jul 2019 05:33:30 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 1 Jul
 2019 05:33:30 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 1 Jul 2019 05:33:30 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x61AXSVU125362;
        Mon, 1 Jul 2019 05:33:29 -0500
Subject: Re: [GIT PULL v2] PHY: for 5.2-rc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20190612102803.25398-1-kishon@ti.com>
 <3c16d177-adb3-5c42-7e90-49ddae9723cb@ti.com>
 <20190621064019.GA12643@kroah.com>
 <105a126a-5897-5607-e371-1af958523631@ti.com>
 <194c1b99-aff4-6118-b853-6745b306567f@ti.com>
 <20190701101415.GC23548@kroah.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b32ec30d-d31a-e2d3-7817-ab7615aa8039@ti.com>
Date:   Mon, 1 Jul 2019 16:01:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701101415.GC23548@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 01/07/19 3:44 PM, Greg Kroah-Hartman wrote:
> On Thu, Jun 27, 2019 at 06:46:50PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Greg,
>>
>> On 21/06/19 12:50 PM, Kishon Vijay Abraham I wrote:
>>>
>>>
>>> On 21/06/19 12:10 PM, Greg Kroah-Hartman wrote:
>>>> On Fri, Jun 21, 2019 at 11:41:26AM +0530, Kishon Vijay Abraham I wrote:
>>>>> Hi Greg,
>>>>>
>>>>> On 12/06/19 3:57 PM, Kishon Vijay Abraham I wrote:
>>>>>> Hi Greg,
>>>>>>
>>>>>> Please find the updated pull request for 5.2 -rc cycle. Here I dropped
>>>>>> the patch that added "static" for a function to fix sparse warning.
>>>>>>
>>>>>> I'm also sending the patches along with this pull request in case you'd
>>>>>> like to look them.
>>>>>>
>>>>>> Consider merging it in this -rc cycle and let me know if you want me
>>>>>> to make any further changes.
>>>>>
>>>>> Are you planning to merge this?
>>>>
>>>> Ugh, fell through the cracks of my huge TODO mbox at the moment, sorry.
>>>> It's still there, should get to it next week...
>>>
>>> All right, thanks!
>>
>> I think it's not merged yet. If you think it's too late, I can send it along
>> with the merge window pull request.
> 
> Sorry for the delay, I've merged this into my branch for 5.3-rc1.  If
> anything needed to go into 5.2, can you send the git commit ids to
> stable@vger.kernel.org when they hit Linus's tree?

Sure, I'll do that. Meanwhile I've sent pull request for 5.3 merge window. It
would be great if you can pick that one too.

Thanks
Kishon
