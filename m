Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1265C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1CA20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfDDNiN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:38:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49250 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbfDDNiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:38:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34DL8cO017948;
        Thu, 4 Apr 2019 15:35:16 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgmxasdr-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 04 Apr 2019 15:35:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 75F3134;
        Thu,  4 Apr 2019 13:35:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 27B0428B2;
        Thu,  4 Apr 2019 13:35:15 +0000 (GMT)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 4 Apr
 2019 15:35:14 +0200
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Thu, 4 Apr 2019 15:35:14 +0200
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "apatard@mandriva.com" <apatard@mandriva.com>
Subject: Re: [PATCH 5/7] ASoC: cs42l51: change mic bias DAPM
Thread-Topic: [PATCH 5/7] ASoC: cs42l51: change mic bias DAPM
Thread-Index: AQHU6qnUrgYV19AhCkWzjVPP9cQSZaYr35wA
Date:   Thu, 4 Apr 2019 13:35:14 +0000
Message-ID: <88cdfc1b-f6b0-9965-fba4-add436109ca1@st.com>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
 <1554297817-14154-6-git-send-email-olivier.moysan@st.com>
 <20190404054704.GN5748@sirena.org.uk>
In-Reply-To: <20190404054704.GN5748@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FBD788ABDA9F454B8AA9ECEC08B7DA17@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

There are no routes in cs42l51_routes table using "Mic Bias" widget.

I use this widget in a route defined in audio graph card DT node.
I checked other DTs which are using CS42L51 codec (armada-370-db.dts
kirkwood-openrd-client.dts, kirkwood-openrd-ultimate.dts),but I did not 
find reference to "Mic Bias" widget.
So, my understanding is that the patch should not break the legacy.
If you think this assumption is not correct please let me know.

Regards
Olivier


On 4/4/19 7:47 AM, Mark Brown wrote:
> On Wed, Apr 03, 2019 at 03:23:35PM +0200, Olivier Moysan wrote:
>> Use SND_SOC_DAPM_SUPPLY for mic bias DAPM
>> instead of deprecated SND_SOC_DAPM_MICBIAS.
> 
> There are existing users in mainline, have they all been updated to be
> compatible with this, or verified that they don't need updates?
> 
