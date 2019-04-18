Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56838C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D6E2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="duPZCr+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388964AbfDRM2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:28:54 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35046 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRM2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:28:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3ICSTCU105492;
        Thu, 18 Apr 2019 07:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555590509;
        bh=XvOi3ZrRKi6DP505yiRxA602NOGElhXojGq7No8b5j0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=duPZCr+84YXfRCbLrB27yZl23PDdDIX4Ej58Bz3t2Yof8xRP8TaUHczOBHGe7zja/
         ArsqWRZeaUtCyCOhXr0BuXczfOYugCACM4NenzKLsxN+aSAda68JxBivCVwJp6edua
         w+DNjZHa+StUWz+0RZ81rOxCLJsjegBsfpk+tl5Q=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3ICSTdk113726
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 18 Apr 2019 07:28:29 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 18
 Apr 2019 07:28:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 18 Apr 2019 07:28:29 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3ICSSiS116063;
        Thu, 18 Apr 2019 07:28:28 -0500
Subject: Re: [PATCH v4 11/26] dt-bindings: lp8860: Add function and color
 properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, <robh@kernel.org>, <dtor@google.com>,
        <linux@roeck-us.net>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-12-jacek.anaszewski@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <f942fe13-c38e-0cde-2991-ed67f2249e9f@ti.com>
Date:   Thu, 18 Apr 2019 07:28:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417205439.17685-12-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek

On 4/17/19 3:54 PM, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Dan Murphy <dmurphy@ti.com>

I gave reviewed-by for DT docs and tested-by for code for the TI parts affected.

Dan

<snip>
