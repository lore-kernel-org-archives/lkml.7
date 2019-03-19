Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D6EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839A220863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfCSRtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:49:40 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.1]:10991 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727248AbfCSRth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:49:37 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-west-1.aws.symcld.net id 2F/96-19701-DAB219C5; Tue, 19 Mar 2019 17:49:33 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRWlGSWpSXmKPExsVy8IPnUd212hN
  jDHbOVrE41bKH3eLKxUNMFlMfPmGzmH/kHKvFtysdTBaXd81hs1h6/SKTReeuflaL1r1H2C02
  fF/L6MDlseFzE5tH66W/bB5r5q1h9Ng56y67x6ZVnWwe+94uY/NYv+Uqi8fnTXIBHFGsmXlJ+
  RUJrBlr/39mLehjr1j46SprA+NUti5GLg4hgfWMEp/mLmfpYuQEciok3j+6ywhi8wpkSuyd1s
  cKYnMKuEtsv9sHVeMm8ePGESYQm03AQmLyiQdsIDaLgKrE3U1fweqFBSIlNkw/yw6yQETgEqP
  E3FdvwYYyC+xllFj5SgpigaDEyZlPWCDiEhIHX7xghlhgIHF6QSNYXELAXmL6+6tAcQ4gW1+i
  8VgsRNhQ4vusb1Al5hKbj21nmcAoOAvJ1FlIpi5gZFrFaJFUlJmeUZKbmJmja2hgoGtoaKRra
  Gmia2RkqpdYpZuol1qqW55aXKJrqJdYXqxXXJmbnJOil5dasokRGF0pBYce7mA8tzz9EKMkB5
  OSKK+T1sQYIb6k/JTKjMTijPii0pzU4kOMMhwcShK8siA5waLU9NSKtMwcYJzDpCU4eJREeB9
  oAqV5iwsSc4sz0yFSpxh1OQ5+fziXWYglLz8vVUqc9xlIkQBIUUZpHtwIWMq5xCgrJczLyMDA
  IMRTkFqUm1mCKv+KUZyDUUmYVxrkEp7MvBK4Ta+AjmACOmLdvH6QI0oSEVJSDYy6U7LZWb7uD
  fsYVHHk1+VMAeXy+ZtDVDs6tVrKVoXXWi5sWmbQeWJp4+JtN/fmcy56srk5Nlc15g93U+m5w4
  x7NmzR+XZwY/W1cglWL9YqwaazC/fJb9h592Lw5PmPNdacWnIqmO/ExtvLprna/Hkhuao04Yp
  Ei//bSU+/HqyI+qvt9fbv6U2rlFiKMxINtZiLihMBHEYGvjQDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-13.tower-268.messagelabs.com!1553017773!3368615!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11949 invoked from network); 19 Mar 2019 17:49:33 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-13.tower-268.messagelabs.com with AES128-SHA256 encrypted SMTP; 19 Mar 2019 17:49:33 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Mar 2019 17:49:32 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 BBBCA3FC03; Tue, 19 Mar 2019 17:49:32 +0000 (GMT)
Message-ID: <3159a9ec4f79fe25219e04bafc29a842b650521c.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 19 Mar 2019 17:49:32 +0000
Subject: [PATCH 3/3] ASoC: AMD: Update DA7219 DAI clock name to align with
 codec updates
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 19/03/2019 15:22:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the DAI clocks for DA7219 have now been split into BCLK and WCLK,
the clock lookup name needs to be udpated here to select BCLK to
achieve the same functionality as before with regards to DAI clock
gating.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index a5daad9..f37a588 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -72,7 +72,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
+	da7219_dai_clk = clk_get(component->dev, "da7219-dai-bclk");
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET | SND_JACK_LINEOUT |
-- 
1.9.1

