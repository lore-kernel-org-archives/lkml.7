Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4465DC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175C22084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 13:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="x2D9uYjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfF0NSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:18:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56802 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfF0NSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 09:18:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5RDIM8T095093;
        Thu, 27 Jun 2019 08:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561641502;
        bh=rHpj0mT9tggfORmwu7tiNcTVTbNMHVQathpDxVOS0yY=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=x2D9uYjDWhRkaRr/gD53SrHIwFEa/UXCDrsXqRF0bO1DhZ4lfCApJol6IrKvQYHRO
         bRavzSiw83mhnUC1AmdvajJe4AG3Tq5KX4w7uW77zdvCBj0mvS0vscki2j/LFp+CZF
         4D0LX+ioH/l5Nh6Ag3ujVdnr17oa3hkcKIR6c9/s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5RDIMOg091462
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jun 2019 08:18:22 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 27
 Jun 2019 08:18:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 27 Jun 2019 08:18:22 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5RDIKwb026763;
        Thu, 27 Jun 2019 08:18:21 -0500
Subject: Re: [GIT PULL v2] PHY: for 5.2-rc
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20190612102803.25398-1-kishon@ti.com>
 <3c16d177-adb3-5c42-7e90-49ddae9723cb@ti.com>
 <20190621064019.GA12643@kroah.com>
 <105a126a-5897-5607-e371-1af958523631@ti.com>
Message-ID: <194c1b99-aff4-6118-b853-6745b306567f@ti.com>
Date:   Thu, 27 Jun 2019 18:46:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <105a126a-5897-5607-e371-1af958523631@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 21/06/19 12:50 PM, Kishon Vijay Abraham I wrote:
> 
> 
> On 21/06/19 12:10 PM, Greg Kroah-Hartman wrote:
>> On Fri, Jun 21, 2019 at 11:41:26AM +0530, Kishon Vijay Abraham I wrote:
>>> Hi Greg,
>>>
>>> On 12/06/19 3:57 PM, Kishon Vijay Abraham I wrote:
>>>> Hi Greg,
>>>>
>>>> Please find the updated pull request for 5.2 -rc cycle. Here I dropped
>>>> the patch that added "static" for a function to fix sparse warning.
>>>>
>>>> I'm also sending the patches along with this pull request in case you'd
>>>> like to look them.
>>>>
>>>> Consider merging it in this -rc cycle and let me know if you want me
>>>> to make any further changes.
>>>
>>> Are you planning to merge this?
>>
>> Ugh, fell through the cracks of my huge TODO mbox at the moment, sorry.
>> It's still there, should get to it next week...
> 
> All right, thanks!

I think it's not merged yet. If you think it's too late, I can send it along
with the merge window pull request.

Thanks
Kishon
