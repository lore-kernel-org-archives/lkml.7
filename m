Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD11CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C52421916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="BLzh4rUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfCVKUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:20:47 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:51874 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727713AbfCVKUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:20:47 -0400
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 85AB9A25CA;
        Fri, 22 Mar 2019 11:20:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1553250044;
        bh=6wAZmjOo+MXt0apw1D1UgrwZT5rew30LturdOAwr4lM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BLzh4rUpV05N7jFKxt9FuklYL4qk4nlFGPKGx+CydklmoI509gixz3oXrM9u9AtcD
         FIK5pPQFqXte2hi83ZWKBBsuxGZ/xGza+AhAWE3CDxzGXX3Gmq/MCBTlMq6Hl3QyGT
         xUsW5dmte4Q88tVud2cpRnzCAybvTqhWaf1Z6Bqs=
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use
 rgmii-id
To:     Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
References: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
 <CAOMZO5AHzQJzz3vd5MzYgSSxzPjU9xan1dFh9473BXeiRCOzzg@mail.gmail.com>
 <VI1PR10MB2352C3A55BE8FABAF3B02681FE410@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAOMZO5By8=j7gZRAdf2-h-5ak-Qo34rqwDL4+HA_97cMXTAnEQ@mail.gmail.com>
 <20190321084240.fveqkhfrbtg7qr4q@fsr-ub1664-175>
 <CAOMZO5Cz0A19P9E61dy79BFF+V2WsAjobqQ1g9TeiJSCY2Nt4A@mail.gmail.com>
 <20190322011155.GO12513@dragon>
 <CAOMZO5CBjG_xZWjZof_VOKaLLOCxFz3g7Gz1uTVzD=D5GeQb4g@mail.gmail.com>
 <20190322021521.GY12513@dragon>
 <CAOMZO5CRRg9XD9VovcO5+fdM1DBp12P33T9xgW=cEvTES8yDPA@mail.gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <db0a3a96-d836-f7bd-4773-81fcb7984835@ysoft.com>
Date:   Fri, 22 Mar 2019 11:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAOMZO5CRRg9XD9VovcO5+fdM1DBp12P33T9xgW=cEvTES8yDPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 03. 19 3:24, Fabio Estevam wrote:
> On Thu, Mar 21, 2019 at 11:15 PM Shawn Guo <shawnguo@kernel.org> wrote:
> 
>>> Unfortunately, just by looking at the dts files we do not know if a
>>> board uses an AR803x PHY or not, so I am afraid we can not do an
>>> automatic conversion.
>>
>> At least for those we already know?
> 
> Yes, I can help preparing a patch that fixes the i.MX boards we know
> use AR8031 PHY.

AFACT this issue is not AR803x specific. I was hit by the same problem
with QCA833x switch on imx6dl-yapp4. Though, we are currently the only
platform in tree using this chip and Shawn already has the fix in his tree.

I am not aware of any other PHY drivers that my cause problems.

$ git log --oneline v5.0..v5.1-rc1 --grep=RGMII --author=Vinod -- drivers/net/
6d4cd041f0af net: phy: at803x: disable delay only for RGMII mode
a968b5e9d587 net: dsa: qca8k: Enable delay for RGMII_ID mode
5ecdd77c61c8 net: dsa: qca8k: disable delay for RGMII mode
cd28d1d6e52e net: phy: at803x: Disable phy delay for RGMII mode

Michal
