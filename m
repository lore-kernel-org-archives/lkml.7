Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BECFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F3A20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HPTMJU73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404491AbfJPKJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:09:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41198 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfJPKJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:09:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9GA90T6077650;
        Wed, 16 Oct 2019 05:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571220540;
        bh=KNxeu9yfZ4RGKar+cjwljVCo17/rn+guhBIxyB5Xi5Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HPTMJU739RMoB0ZNu8pPABGgIMHbJ4MMLVqxFPrm0LDF1NQbbshmld+lDmDazw4Ph
         NppIfYVJTQWyg8jCEfNgYHOAD/fgsOWYMy9SWi1Jg6coE1IHiU0yebMSR7gtvttsAB
         PFzUJjvfwyKnee3TpFiK1povC+/dsI5Mvy4W3ZCw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9GA90V3127814
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Oct 2019 05:09:00 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 16
 Oct 2019 05:08:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 16 Oct 2019 05:08:53 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9GA8vjP092532;
        Wed, 16 Oct 2019 05:08:58 -0500
Subject: Re: [PATCH v2 0/2] usb: cdns3: fixes for 5.4-rc
To:     <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <pawell@cadence.com>, <peter.chen@nxp.com>, <nsekhar@ti.com>,
        <kurahul@cadence.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191016100452.32613-1-rogerq@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <6435c2c9-c8fb-3ec8-5e5c-b1d3b72b0b2e@ti.com>
Date:   Wed, 16 Oct 2019 13:08:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016100452.32613-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg

I see that you've already picked up v1.
V2 is a very minor fix and this series can be ignored.

cheers,
-roger

On 16/10/2019 13:04, Roger Quadros wrote:
> Hi,
> 
> Here are 2 fixes we found while testing the cdns3 driver
> on our platform.
> 
> The first one fixes a corner case where super-speed in host mode
> doesn't work if device was plugged before the cdns3 driver probes.
> 
> The second one fixes the case when gadget driver is
> limited to full-speed.
> 
> cheers,
> -roger
> 
> Changelog:
> v2
> - treat USB_DR_MODE_UNKNOWN as error case
> 
> Roger Quadros (2):
>    usb: cdns3: fix cdns3_core_init_role()
>    usb: cdns3: gadget: Fix full-speed mode
> 
>   drivers/usb/cdns3/core.c   | 22 +++++++++++++++++++++-
>   drivers/usb/cdns3/gadget.c |  1 +
>   2 files changed, 22 insertions(+), 1 deletion(-)
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
