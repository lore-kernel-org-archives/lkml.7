Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BABAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077922184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oQf/mB+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbfB1Qod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:44:33 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60446 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfB1Qod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:44:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1SGiQkq068982;
        Thu, 28 Feb 2019 10:44:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551372266;
        bh=4zhXpTaxlHiHoLJZidlBnnWaEP6qeTXT0E6QVUewX5Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oQf/mB+Yj+RNyBEiM+xipgUBvnWaDzFBt8FjmaeSn7ytPkBI+QRY3DmLf3W6PVEY0
         7FdRE8ChMoGaG1B7iD2Nyu+BgrMaCqKHL+SgzJ6oqtxVeNek2nM1cFM77vMI09dMKI
         rL5oWo2/Ls/lQPlJq/po6NWBR9wfwziG4gxXFnvE=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1SGiQLx078467
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Feb 2019 10:44:26 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 28
 Feb 2019 10:44:26 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 28 Feb 2019 10:44:25 -0600
Received: from [172.22.127.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1SGiPkr032522;
        Thu, 28 Feb 2019 10:44:25 -0600
Subject: Re: [PATCH v5 0/5] M_CAN Framework re-write
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190214182754.30721-1-dmurphy@ti.com>
 <10baf726-7783-1783-caaa-d7b78be2d9a0@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <caf997cb-25b9-e3b0-3767-173d7c9a4d22@ti.com>
Date:   Thu, 28 Feb 2019 10:44:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <10baf726-7783-1783-caaa-d7b78be2d9a0@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 2/28/19 10:40 AM, Wolfgang Grandegger wrote:
> Hello,
> 
> Am 14.02.19 um 19:27 schrieb Dan Murphy:
>> Hello
>>
>> OK I did not give up on this patch series just got a little preoccupied with
>> some other kernel work.  But here is the update per the comments.
>>
>> It should be understood I broke these out for reviewability.
>> For instance the first patch does not compile on its own as including this
>> patch should not change the current functionality and it pulls all the io-mapped
>> code from the m_can base file to a platfrom file.
> 
> For git bisection, the code must compile!
> 

So I can squash patch 1 and 2 then.

>> The next patch "Migrate the m_can code to use the framework"
>> is the change to the kernel for the io-mapped conversion from a flat file to use
>> the framework.  Finally the rename patch just renames the m_can_priv to 
>> m_can_classdev.  I broke this change out specifically for readability of the
>> migration patch per comments on the code.
>>
>> AFAIC the first 3 patches can all be squashed into a single patch.  Or the
>> first 2 patches in the series can be re-arranged but then m_can functionality is
>> affected in the migration patch.
> 
> For the reason above, I would squash patch 1 and 2.
> 
>>
>> Again the first 3 patches here are all just for readability and review purposes.>
>> Dan
>>
>> Dan Murphy (5):
>>   can: m_can: Create a m_can platform framework
>>   can: m_can: Migrate the m_can code to use the framework
>>   can: m_can: Rename m_can_priv to m_can_classdev
>>   dt-bindings: can: tcan4x5x: Add DT bindings for TCAN4x5X driver
>>   can: tcan4x5x: Add tcan4x5x driver to the kernel
>>
>>  .../devicetree/bindings/net/can/tcan4x5x.txt  |  37 +
>>  drivers/net/can/m_can/Kconfig                 |  14 +-
>>  drivers/net/can/m_can/Makefile                |   2 +
>>  drivers/net/can/m_can/m_can.c                 | 788 +++++++++---------
>>  drivers/net/can/m_can/m_can.h                 | 159 ++++
>>  drivers/net/can/m_can/m_can_platform.c        | 198 +++++
>>  drivers/net/can/m_can/tcan4x5x.c              | 531 ++++++++++++
>>  7 files changed, 1320 insertions(+), 409 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
> 
> There are plenty of coding-style errors, e.g. white-space, indention,
> line too long, etc. Please use "checkpatch" to find and fix.
> 

Ack.  I missed running it on v5.  I will update in v6.

> Wolfgang.
> 
> 
> 


-- 
------------------
Dan Murphy
