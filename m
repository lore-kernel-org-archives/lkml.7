Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC8D2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FswVYlHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfDLLuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:50:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55578 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLLus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:50:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3CBoXaf091617;
        Fri, 12 Apr 2019 06:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555069833;
        bh=p6C5WWiBHiLgmXU7FgNwfJQwA24NMkCtkMhUUjuOpyg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FswVYlHUSOJ2wCNwOo8Tv7G2zpPm4sVtFfa9hb0aL2M5h4d3MI7qL/oiuOvYW+ZZ6
         RqN6Dmg6a/rNRvomTcZPnUrIpskcwKa9KP6FBXl41AHeNvpd02IRMpfNm40SxXGqms
         v17alaVEoFFOEUb/GN1lbWniwYt+l69WFap3VHas=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3CBoXOu003962
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Apr 2019 06:50:33 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 06:50:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 12 Apr 2019 06:50:32 -0500
Received: from [10.250.81.84] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3CBoW54012042;
        Fri, 12 Apr 2019 06:50:32 -0500
Subject: Re: [PATCH v2 2/7] dt: bindings: Add multicolor class dt bindings
 documention
To:     Marek Behun <marek.behun@nic.cz>
CC:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <rdunlap@infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
References: <20190411193848.23140-1-dmurphy@ti.com>
 <20190411193848.23140-3-dmurphy@ti.com> <20190412000707.70f8319f@nic.cz>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <5675ac20-6db2-34ea-938a-01f0076b87e7@ti.com>
Date:   Fri, 12 Apr 2019 06:50:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412000707.70f8319f@nic.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek

On 4/11/19 5:07 PM, Marek Behun wrote:
> Hi Dan,
> this probaly was discussed, but I did not follow brightness model
> discussions:
> what will happen if I set yellow by writing into yellow mode
> brightness, and then orange by writing orange model brightness?
> Will the resulting color be a mix of yellow and orange, or will the
> orange overwrite the yellow setting?
> 

This was not discussed and is a good question.  If you write the yellow mode for a group of
LEDs then yellow would be produced for the brightness requested.

If orange is then requested then orange should be displayed at the brightness level requested.
So yes the orange will over write the yellow.

The next question is if the absolute colors are written does it produce the same behavior?

So if you have yellow and write to the red should the red LED brightness be modified or should the
color switch to red?
And if the red LED is on and the blue LED is written should the color switch to blue or should the blue and red LEDs be mixed together?

This is tricky as the user space can write the individual absolute colors and mix the LEDs to produce varying
colors.  But the behavior writing the brightness models are different.

I would almost prefer that the user space reads the available absolute LED colors and creates the devices supported color palette and write the absolute LED colors only.  But this violates the requirements asked for.

Dan

> Marek
> 
