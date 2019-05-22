Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D270DC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A425020863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="inhZwtg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfEVNqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:46:03 -0400
Received: from node.akkea.ca ([192.155.83.177]:49316 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfEVNqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:46:03 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id CACA44E204B; Wed, 22 May 2019 13:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1558532762; bh=7yenqbpr2XCwDV8Mlbh8CEblalOVAjTP8mc9IslVsTA=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=inhZwtg40oBX+LxLUEoqRhVavTXOdAGgGF5Ms3/JiFTkWA95fC7hziW90SWMK0bkS
         n4sW72/bPG1wUcDbgdfaGgraHdDR9dMOvh2AQaTdIKm7ML0ogPMdk9bybluoeNre76
         7dngbxxlTEPlegbTtEs/g4CsK4ysIKIS2DRB1MNY=
To:     Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v12 1/4] MAINTAINERS: add an entry for for arm64 imx  devicetrees
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 May 2019 06:46:02 -0700
From:   Angus Ainslie <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190522083051.GB9261@dragon>
References: <20190514132822.27023-1-angus@akkea.ca>
 <20190514132822.27023-2-angus@akkea.ca> <20190522083051.GB9261@dragon>
Message-ID: <cd02331f028e70c0ddacc6e6dcff502e@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn

On 2019-05-22 01:30, Shawn Guo wrote:
> On Tue, May 14, 2019 at 06:28:19AM -0700, Angus Ainslie (Purism) wrote:
>> Add an explicit reference to imx* devicetrees
>> 
>> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7707c28628b9..9fc30f82ab81 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1624,6 +1624,7 @@ R:	NXP Linux Team <linux-imx@nxp.com>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for 
>> non-subscribers)
>>  S:	Maintained
>>  T:	git 
>> git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
>> +F:	arch/arm64/boot/dts/freescale/imx*
> 
> This is partially reverting commit da8b7f0fb02b ("MAINTAINERS: add all
> files matching "imx" and "mxs" to the IMX entry").  I'm not sure that 
> we
> want it.
> 

Ok, I can drop it from my patchset and it will get sorted out somewhere 
else ?

Thanks
Angus

> Shawn
> 
>>  N:	imx
>>  N:	mxs
>>  X:	drivers/media/i2c/
>> --
>> 2.17.1
>> 

