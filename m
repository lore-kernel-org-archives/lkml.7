Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C44C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C8620833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfDBGpo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:45:44 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57509 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfDBGpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:45:44 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x326jX6L008682, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x326jX6L008682
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 2 Apr 2019 14:45:33 +0800
Received: from RTITEXH01.realtek.com.tw (172.21.6.62) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 2 Apr 2019 14:45:33 +0800
Received: from RTITMBSVM07.realtek.com.tw ([fe80::a512:a803:bf1e:b23]) by
 RTITEXH01.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Tue, 2 Apr 2019
 14:45:32 +0800
From:   Kailang <kailang@realtek.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Jian-Hong Pan <jian-hong@endlessm.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Daniel Drake <drake@endlessm.com>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21 with ALC233
Thread-Topic: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer
 TravelMate B114-21 with ALC233
Thread-Index: AQHU6Dqw5knd0/Ath0C1mp5SHHcFl6YnBJOAgAFn61D//3uTAIAAhmXA
Date:   Tue, 2 Apr 2019 06:45:32 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DBAFCA@RTITMBSVM07.realtek.com.tw>
References: <20190401032503.2821-1-jian-hong@endlessm.com>
        <s5hmul9lkke.wl-tiwai@suse.de>
        <6FAB7C47BCF00940BB0999A99BE3547A18DBAFAD@RTITMBSVM07.realtek.com.tw>
 <s5h7ecclxft.wl-tiwai@suse.de>
In-Reply-To: <s5h7ecclxft.wl-tiwai@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.105.152]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Kailang Yang <kailang@realtek.com>

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Tuesday, April 2, 2019 2:43 PM
To: Kailang <kailang@realtek.com>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>; alsa-devel@alsa-project.org; Daniel Drake <drake@endlessm.com>; linux@endlessm.com; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer TravelMate B114-21 with ALC233

On Tue, 02 Apr 2019 08:38:32 +0200,
Kailang wrote:
> 
> Hi Takashi,
> 
> This COEF value was modified by me.

OK, then could you give your Acked-by or Reviewed-by tag?


thanks,

Takashi

> 
> BR,
> Kailang
> 
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, April 2, 2019 1:09 AM
> To: Jian-Hong Pan <jian-hong@endlessm.com>
> Cc: alsa-devel@alsa-project.org; Daniel Drake <drake@endlessm.com>; 
> linux@endlessm.com; Kailang <kailang@realtek.com>; 
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ALSA: hda/realtek: Enable headset MIC of Acer 
> TravelMate B114-21 with ALC233
> 
> On Mon, 01 Apr 2019 05:25:05 +0200,
> Jian-Hong Pan wrote:
> > 
> > The Acer TravelMate B114-21 laptop cannot detect and record sound 
> > from headset MIC.  This patch adds the ALC233_FIXUP_ACER_HEADSET_MIC 
> > HDA verb quirk chained with ALC233_FIXUP_ASUS_MIC_NO_PRESENCE pin 
> > quirk to fix this issue.
> > 
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > Signed-off-by: Daniel Drake <drake@endlessm.com>
> > ---
> >  sound/pci/hda/patch_realtek.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/sound/pci/hda/patch_realtek.c 
> > b/sound/pci/hda/patch_realtek.c index a3fb3d4c5730..bdb2227be4eb
> > 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -5690,6 +5690,7 @@ enum {
> >  	ALC286_FIXUP_ACER_AIO_HEADSET_MIC,
> >  	ALC256_FIXUP_ASUS_MIC_NO_PRESENCE,
> >  	ALC299_FIXUP_PREDATOR_SPK,
> > +	ALC233_FIXUP_ACER_HEADSET_MIC,
> >  };
> >  
> >  static const struct hda_fixup alc269_fixups[] = { @@ -6713,6 
> > +6714,15 @@ static const struct hda_fixup alc269_fixups[] = {
> >  			{ 0x21, 0x90170150 }, /* use as headset mic, without its own jack detect */
> >  			{ }
> >  		}
> > +	[ALC233_FIXUP_ACER_HEADSET_MIC] = {
> > +		.type = HDA_FIXUP_VERBS,
> > +		.v.verbs = (const struct hda_verb[]) {
> > +			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x45 },
> > +			{ 0x20, AC_VERB_SET_PROC_COEF, 0x5089 },
> > +			{ }
> 
> For the additional COEF application, I'd like to hear ack from Kailang.  It's still a black magic from Realtek, so need some confirmation.
> 
> 
> thanks,
> 
> Takashi
> 
> > +		},
> > +		.chained = true,
> > +		.chain_id = ALC233_FIXUP_ASUS_MIC_NO_PRESENCE
> >  	},
> >  };
> >  
> > @@ -6737,6 +6747,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >  	SND_PCI_QUIRK(0x1025, 0x1290, "Acer Veriton Z4860G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >  	SND_PCI_QUIRK(0x1025, 0x1291, "Acer Veriton Z4660G", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> >  	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", 
> > ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
> > +	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", 
> > +ALC233_FIXUP_ACER_HEADSET_MIC),
> >  	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
> >  	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
> >  	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", 
> > ALC275_FIXUP_DELL_XPS),
> > --
> > 2.20.1
> > 
> > 
> 
> ------Please consider the environment before printing this e-mail.
> 
