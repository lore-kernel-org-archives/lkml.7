Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F729C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D51321902
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 20:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SZ4V3wNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbfHGUHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 16:07:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45554 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388210AbfHGUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 16:07:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x77K7BuX031211;
        Wed, 7 Aug 2019 15:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1565208431;
        bh=v1xJ4QW2CbPvsjZynDNpO5ZE1SyBCjZArxFkQkhNH5A=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SZ4V3wNSGHM5Ndp0peDd5pSEHfUpepv/G1zVezW4p5fyJR/1tYdrDGRy3HmgpHYNm
         tpcK6FRDi7Wks1/ikO6ozijRfxE48Set2+2N2zDgWdl2FtFPhWFyhIvezaC2ieRiAh
         Hi3NXyQnt0v63AyhOCGfdNW9I51csIwRIe70VWaY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x77K7BSW035753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Aug 2019 15:07:11 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 7 Aug
 2019 15:07:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 7 Aug 2019 15:07:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x77K7ADP024682;
        Wed, 7 Aug 2019 15:07:10 -0500
Date:   Wed, 7 Aug 2019 15:07:10 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <saurav.girepunje@hotmail.com>
Subject: Re: [PATCH] usb: musb: musb_core.c: Update the function description
Message-ID: <20190807200710.GC14027@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>;,
        gregkh@linuxfoundation.org;, linux-usb@vger.kernel.org;,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <20190805181318.GA8930@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190805181318.GA8930@saurav>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 11:43:21PM +0530, Saurav Girepunje wrote:
> Update the function description of musb_stage0_irq in musb_core.c

I modified this to:

usb: musb: core: Update the function description

Update the function description of musb_stage0_irq() to remove unused
parameter.

and applied to my tree. Thanks.

> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

-Bin.
