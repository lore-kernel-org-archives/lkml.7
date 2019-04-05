Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E72C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094D421852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nbJyPnXb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S4TrKCN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfDENYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:24:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDENYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:24:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CF08C60746; Fri,  5 Apr 2019 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554470674;
        bh=l1rMlczADJF5ioAJjMYIOt5EEHLsyvkesND+4wZ/JmI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nbJyPnXb3lUsHdVSR1dt7+jmjuqoxAAibngdvSzngWoFN3Xv+ruO9bLchTAeMAWCn
         ZudvKrKQGD51cuI0Rg0YPVBCUic+uzGKqVpwtituwLQuLprFrPwt/Ylj79PdP71esP
         kxcG/3DXZD9xCM+m4bwrfzjP/kD35oeNv32XeIZo=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88F8260452;
        Fri,  5 Apr 2019 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554470673;
        bh=l1rMlczADJF5ioAJjMYIOt5EEHLsyvkesND+4wZ/JmI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S4TrKCN7qtz76RQOqbOMJuawlVLuy7YR0b/pIM9bzbXJBUO8SQvTGo5I9iIfJWbvL
         r+cPm+xgXZDkTi8eb/wrJmdYGN3UT1v01PM33lMgCpVkwb6xvimDr2VUeOSioUH3vl
         MPWMP+D0tXvcJmA+WfGNy1zXie0Zh5q+O7Nr2cgI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88F8260452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH 02/20] ASoC: efika-audio-fabric.c: Switch to SPDX
 identifier
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        Andra Danciu <andradanciu1997@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, timur@kernel.org,
        Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
 <20190405115010.28838-3-andradanciu1997@gmail.com>
 <8e16e9f5-2c0f-a1e6-df0d-67b982db294a@codeaurora.org>
 <CAOMZO5CZtJq65iUDN2Ao9zt=0_L0iXy-5eRCrHAzQb+3s5rxBA@mail.gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e3bc6c00-d88d-d30a-28a1-a8c4e520ec5a@codeaurora.org>
Date:   Fri, 5 Apr 2019 18:54:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5CZtJq65iUDN2Ao9zt=0_L0iXy-5eRCrHAzQb+3s5rxBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/5/2019 6:20 PM, Fabio Estevam wrote:
> On Fri, Apr 5, 2019 at 9:47 AM Mukesh Ojha <mojha@codeaurora.org> wrote:
>
>> Don't change entire thing with //. only above line with the license is
>> enough.
>>
>> Please apply this rule every patch of yours.
> Not really. This is the style preferred in this subsystem.


you mean all lines to start with //, does not it look to noisy to eyes ?

-Mukesh

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
