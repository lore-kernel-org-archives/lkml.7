Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B24C2D0C8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 02:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2901205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 02:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLWCUz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 21:20:55 -0500
Received: from mg.richtek.com ([220.130.44.152]:35942 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfLWCUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 21:20:55 -0500
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Dec 2019 21:20:54 EST
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(24505:0:AUTH_RELAY)
        (envelope-from <prvs=1259CAF996=jeff_chang@richtek.com>); Mon, 23 Dec 2019 10:13:51 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.44
        by mg.richtek.com with MailGates ESMTP Server V5.0(11235:0:AUTH_RELAY)
        (envelope-from <jeff_chang@richtek.com>); Mon, 23 Dec 2019 10:10:13 +0800 (CST)
Received: from ex1.rt.l (192.168.8.44) by ex1.rt.l (192.168.8.44) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Dec 2019 10:10:12 +0800
Received: from ex1.rt.l ([fe80::557d:30f0:a3f8:3efc]) by ex1.rt.l
 ([fe80::557d:30f0:a3f8:3efc%15]) with mapi id 15.00.1497.000; Mon, 23 Dec
 2019 10:10:12 +0800
From:   =?iso-2022-jp?B?amVmZl9jaGFuZygbJEJEJUAkMkIbKEIp?= 
        <jeff_chang@richtek.com>
To:     Mark Brown <broonie@kernel.org>,
        Jeff Chang <richtek.jeff.chang@gmail.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Thread-Topic: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Thread-Index: AQHVtx5xY4OlmY1OS02nOllbj/O4KqfCaPoAgAST0kA=
Date:   Mon, 23 Dec 2019 02:10:12 +0000
Message-ID: <7a9bcf5d414c4a74ae8e101c54c9e46f@ex1.rt.l>
References: <1576836934-5370-1-git-send-email-richtek.jeff.chang@gmail.com>
 <20191220121152.GC4790@sirena.org.uk>
In-Reply-To: <20191220121152.GC4790@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.95.168]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mark:

Thanks for your replying.

I have a question about this

> +++ b/sound/soc/codecs/mt6660.c
> @@ -0,0 +1,653 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */

Please make the entire comment a C++ one so things look more intentional.

--> When I check other driver at sound/soc/codecs/ folder, I just follow what others do.
It seems in .h --> /* SPDX-Liencese-Identifier: GPL-2.0 */
   In .c --> // SPDK-Liencese-Identifier: GPL-2.0

Is it correct?


Thanks & BRs
Jeff Chang
Tel 886-3-5526789 Ext 2357
14F, No. 8, Taiyuen 1st st., Zhubei City,
Hsinchu County, Taiwan 30288



-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org]
Sent: Friday, December 20, 2019 8:12 PM
To: Jeff Chang <richtek.jeff.chang@gmail.com>
Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com; matthias.bgg@gmail.com; alsa-devel@alsa-project.org; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; jeff_chang(張世佳) <jeff_chang@richtek.com>
Subject: Re: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver

On Fri, Dec 20, 2019 at 06:15:34PM +0800, Jeff Chang wrote:

> +++ b/sound/soc/codecs/mt6660.c
> @@ -0,0 +1,653 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */

Please make the entire comment a C++ one so things look more intentional.

> +{ MT6660_REG_DEVID, 2},
> +{ MT6660_REG_TDM_CFG3, 2},
> +{ MT6660_REG_HCLIP_CTRL, 2},
> +{ MT6660_REG_DA_GAIN, 2},

Missing space before the } (the same thing happens in some of the other tables).

> +static int mt6660_component_get_volsw(struct snd_kcontrol *kcontrol,
> +  struct snd_ctl_elem_value *ucontrol) {
> +struct snd_soc_component *component =
> +snd_soc_kcontrol_component(kcontrol);
> +struct mt6660_chip *chip = (struct mt6660_chip *)
> +snd_soc_component_get_drvdata(component);
> +int ret = -EINVAL;
> +
> +if (!strcmp(kcontrol->id.name, "Chip_Rev")) {

Why would this be used on a different control?

> +SOC_SINGLE_EXT("BoostMode", MT6660_REG_BST_CTRL, 0, 3, 0,
> +       snd_soc_get_volsw, snd_soc_put_volsw),

Boost Mode.  You've also got a lot of these controls that are _EXT but you then just use standard operations so it's not clear why you're using _EXT.

> +SOC_SINGLE_EXT("audio input selection", MT6660_REG_DATAO_SEL, 6, 3, 0,
> +       snd_soc_get_volsw, snd_soc_put_volsw),

Audio Input Selection, but this looks like it should be a DAPM control if it's controlling audio routing.  A simple numerical setting definitely doesn't seem like the right thing.

> +SOC_SINGLE_EXT("AUD LOOP BACK Switch", MT6660_REG_PATH_BYPASS, 4, 1, 0,
> +       snd_soc_get_volsw, snd_soc_put_volsw),

This sounds like it should be a DAPM thing too.

> +static int mt6660_component_probe(struct snd_soc_component
> +*component) {
> +struct mt6660_chip *chip = snd_soc_component_get_drvdata(component);
> +int ret = 0;
> +
> +dev_info(component->dev, "%s\n", __func__);

dev_dbg() at most but probably better to remove this and the other similar dev_info()s.

> +static inline int _mt6660_chip_id_check(struct mt6660_chip *chip) {
> +u8 id[2] = {0};
> +int ret = 0;
> +
> +ret = i2c_smbus_read_i2c_block_data(chip->i2c, MT6660_REG_DEVID, 2, id);
> +if (ret < 0)
> +return ret;
> +ret = (id[0] << 8) + id[1];
> +ret &= 0x0ff0;
> +if (ret != 0x00e0 && ret != 0x01e0)
> +return -ENODEV;

It'd be better to print an error message saying we don't recognize the device to help people doing debugging.

> +if (of_property_read_u32(np, "rt,init_setting_num", &val)) {
> +dev_info(dev, "no init setting\n");
> +chip->plat_data.init_setting_num = 0;

You should be adding a DT binding document for any new DT bindings.
************* Email Confidentiality Notice ********************

The information contained in this e-mail message (including any attachments) may be confidential, proprietary, privileged, or otherwise exempt from disclosure under applicable laws. It is intended to be conveyed only to the designated recipient(s). Any use, dissemination, distribution, printing, retaining or copying of this e-mail (including its attachments) by unintended recipient(s) is strictly prohibited and may be unlawful. If you are not an intended recipient of this e-mail, or believe that you have received this e-mail in error, please notify the sender immediately (by replying to this e-mail), delete any and all copies of this e-mail (including any attachments) from your system, and do not disclose the content of this e-mail to any other person. Thank you!
