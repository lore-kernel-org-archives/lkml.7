Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4277C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3F0206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 07:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XMhGMr3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfFUHVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 03:21:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52846 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfFUHVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 03:21:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5L7LTVl070831;
        Fri, 21 Jun 2019 02:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561101689;
        bh=BwS7Wv9pUKAyjpW6XFRZm7DUw0EuM7u/gRcfp5alsmU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XMhGMr3BLtVuVmi0eY0fczAjCV3BuflKfqf/UPn35eBetFILruwqrR9mnKAjJrBle
         OCv8dLZMX5AKQzEqmipWlIyi69ndUZCCPAXEMaxCZm7isi3Dtg7UEcIPtnotrjh7bd
         aMM8X6yDFGOL6k2fAbA+3BPkzH4Np4NWEGpNl7CI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5L7LTWm018851
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jun 2019 02:21:29 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 21
 Jun 2019 02:21:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 21 Jun 2019 02:21:29 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5L7LROd095477;
        Fri, 21 Jun 2019 02:21:28 -0500
Subject: Re: [GIT PULL v2] PHY: for 5.2-rc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20190612102803.25398-1-kishon@ti.com>
 <3c16d177-adb3-5c42-7e90-49ddae9723cb@ti.com>
 <20190621064019.GA12643@kroah.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <105a126a-5897-5607-e371-1af958523631@ti.com>
Date:   Fri, 21 Jun 2019 12:50:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190621064019.GA12643@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/06/19 12:10 PM, Greg Kroah-Hartman wrote:
> On Fri, Jun 21, 2019 at 11:41:26AM +0530, Kishon Vijay Abraham I wrote:
>> Hi Greg,
>>
>> On 12/06/19 3:57 PM, Kishon Vijay Abraham I wrote:
>>> Hi Greg,
>>>
>>> Please find the updated pull request for 5.2 -rc cycle. Here I dropped
>>> the patch that added "static" for a function to fix sparse warning.
>>>
>>> I'm also sending the patches along with this pull request in case you'd
>>> like to look them.
>>>
>>> Consider merging it in this -rc cycle and let me know if you want me
>>> to make any further changes.
>>
>> Are you planning to merge this?
> 
> Ugh, fell through the cracks of my huge TODO mbox at the moment, sorry.
> It's still there, should get to it next week...

All right, thanks!

-Kishon
