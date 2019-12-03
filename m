Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C41EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED19E20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfLCPbq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:31:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:42173 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfLCPbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:31:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 07:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="213443780"
Received: from kmsmsx156.gar.corp.intel.com ([172.21.138.133])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2019 07:31:43 -0800
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.12]) by
 KMSMSX156.gar.corp.intel.com ([169.254.1.162]) with mapi id 14.03.0439.000;
 Tue, 3 Dec 2019 23:23:03 +0800
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da7219: remove SRM lock check retry
Thread-Topic: [PATCH] ASoC: da7219: remove SRM lock check retry
Thread-Index: AQHVqaw+ii/fH1J6I0CEgpyDBLMztaeno36AgACHg7D//4yFAIAAv3yg//+DfwCAAIgLEA==
Date:   Tue, 3 Dec 2019 15:23:03 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C7403CAFAE@PGSMSX108.gar.corp.intel.com>
References: <1575358265-17905-1-git-send-email-brent.lu@intel.com>
 <AM5PR1001MB0994EB497D3BC7D0F4C6FD9080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CF33C36214C39B4496568E5578BE70C7403CA7B2@PGSMSX108.gar.corp.intel.com>
 <AM5PR1001MB09946C295B8DAD5F9C8D191080420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <CF33C36214C39B4496568E5578BE70C7403CACC7@PGSMSX108.gar.corp.intel.com>
 <AM5PR1001MB0994921AE80726BAC59C552B80420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM5PR1001MB0994921AE80726BAC59C552B80420@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTQ4ZmU3YWEtZDJmZi00M2YyLTg3MGUtZDE4YWFkMWMxMjVhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaEh6N2FXOTE3R3JwNDVFWlFJdlFCNEs1WHZHZWpyb0U1d0JmT0JcL1dyaDNvQ3JFMEhRaFBxK0tMK2g4TFVWeTIifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Yes, that's right. I have put in a request with our HW team to again clarify
> timings, but still awaiting feedback.
> 
> The driver already warns via the kernel logs when SRM lock fails as follows:
> 
> 	dev_warn(component->dev, "SRM failed to lock\n");
> 
> What else do you think is needed?
> 

Hi Adam,

Let's say that the SRM locks in the second loop. The 50ms delay was applied
but there is no kernel log message about it because the value of srm_lock is
already true when exiting the loop. If we can print every SRM lock fail before
msleep() call, it would be a helpful for people resolving timing issues like Cold
latency.

do {
	pll_status = snd_soc_component_read32(component, DA7219_PLL_SRM_STS);
	if (pll_status & DA7219_PLL_SRM_STS_SRM_LOCK) {
		break;
	} else {
		++i;
		dev_warn(component->dev, "SRM failed to lock, retry in 50ms\n");
		msleep(50);
	}
} while (i < DA7219_SRM_CHECK_RETRIES);


Regards,
Brent
