Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2C3C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80182070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="L1lZhrZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfEMSs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:48:27 -0400
Received: from node.akkea.ca ([192.155.83.177]:44998 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbfEMSs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:48:27 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id E7EEC4E204B; Mon, 13 May 2019 18:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557773306; bh=hCoM+MZKQxVEbks3ixHBaQdKIT5dEO7R/ECZ/P/HzIg=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=L1lZhrZGW3NlDnLKOxQtBMkkoB5wtFI1G3A5ejzzKIYpo4O8+B6Ez6gzNQ31dYsl/
         3uTR/97QjiIYnMDdspJYpUbOlHujCTcXJEO944m7AU5X1RvvUBDLCy5v89zt6C9hbg
         3VAbg4vCtiaz8EyvQJ60dL0umk3fnaUbon18aiQw=
To:     Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v10 1/4] MAINTAINERS: add an entry for for arm64 imx  devicetrees
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 May 2019 11:48:26 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CAOMZO5BaQnrDOYogzgpmCExjB+uhYQ8SsxBiMWrSB-1KRtgeVQ@mail.gmail.com>
References: <20190513174057.4410-1-angus@akkea.ca>
 <20190513174057.4410-2-angus@akkea.ca>
 <CAOMZO5BaQnrDOYogzgpmCExjB+uhYQ8SsxBiMWrSB-1KRtgeVQ@mail.gmail.com>
Message-ID: <e61562bfc80e25bf233ae7fd7b032f83@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-13 11:01, Fabio Estevam wrote:
> On Mon, May 13, 2019 at 2:41 PM Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> 
>> Add an explicit reference to imx* devicetrees
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7707c28628b9..0871a21a5bbb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1648,6 +1648,7 @@ T:        git 
>> git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
>>  F:     arch/arm/boot/dts/ls1021a*
>>  F:     arch/arm64/boot/dts/freescale/fsl-*
>>  F:     arch/arm64/boot/dts/freescale/qoriq-*
>> +F:     arch/arm64/boot/dts/freescale/imx*
> 
> No, please put this entry under ARM/FREESCALE IMX / MXC ARM 
> ARCHITECTURE
> 

I believe order is important. Would you like it before or after the "N:" 
entries ? Or just as the last entry.

> Thanks

