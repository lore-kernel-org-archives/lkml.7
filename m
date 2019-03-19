Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C4DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07D92133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfCSRth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:49:37 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:14435 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727017AbfCSRtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:49:36 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id F5/90-14990-CAB219C5; Tue, 19 Mar 2019 17:49:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRWlGSWpSXmKPExsVy8IPnUd012hN
  jDN5947U41bKH3eLKxUNMFlMfPmGzmH/kHKvFtysdTBaXd81hs1h6/SKTReeuflaL1r1H2C02
  fF/L6MDlseFzE5tH66W/bB5r5q1h9Ng56y67x6ZVnWwe+94uY/NYv+Uqi8fnTXIBHFGsmXlJ+
  RUJrBnLJ/sWTOWpePSplaWBcTVXFyMXh5DAekaJN3O7WbsYOYCcCoktzZpdjJwcvAKZEr3njr
  KC2JwC7hLb7/axgNhCAm4SP24cYQKx2QQsJCafeMAGYrMIqEqcWHKUHWSMsECIxLy/ASDjRQQ
  uMUrMffWWEaSGWWAvo8TKV1IQ8wUlTs58wgIRl5A4+OIFM8R8A4nTCxrB4hIC9hLT319lBpkp
  IaAv0XgsFiJsKPF91jeoEnOJzce2s0xgFJyFZOosJFMXMDKtYrRIKspMzyjJTczM0TU0MNA1N
  DTSNbQ00zU0M9ZLrNJN0kst1S1PLS7RNdRLLC/WK67MTc5J0ctLLdnECIyrlIIji3cwvlqefo
  hRkoNJSZTXSWtijBBfUn5KZUZicUZ8UWlOavEhRhkODiUJXlmQnGBRanpqRVpmDjDCYdISHDx
  KIrwPNIHSvMUFibnFmekQqVOMilLivM9AEgIgiYzSPLg2WFK5xCgrJczLyMDAIMRTkFqUm1mC
  Kv+KUZyDUUmYVxpkO09mXgnc9FdAi5mAFq+b1w+yuCQRISXVwJjnueq5+/O8xNXib75lHY948
  HpnYLHCm2yVI9kzHm07+knsqNSfU9L97wSEX8SzHtU/VPBvg/HShu/fi7sX3wk8cmXBx8wSqz
  DVPdcjq2xWvm4Xlds+f2WinFXedOWPlr+Wn69h4ZNIeSYz9Qb35z6BfOOdc2ZsfnK8/1izwaM
  lMkXfZkn/eh6kxFKckWioxVxUnAgAYKZfSSUDAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-15.tower-288.messagelabs.com!1553017771!4862358!2
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14907 invoked from network); 19 Mar 2019 17:49:32 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-15.tower-288.messagelabs.com with AES128-SHA256 encrypted SMTP; 19 Mar 2019 17:49:32 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Mar 2019 17:49:30 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 B64E43FBE9; Tue, 19 Mar 2019 17:49:30 +0000 (GMT)
Message-ID: <a2e2ae888b3c2fbcaab3e4791ce98f877e3d38ff.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 19 Mar 2019 17:49:30 +0000
Subject: [PATCH 1/3] ASoC: da7219: Update DAI clock binding info to cover
 WCLK/BCLK
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

With the need to expose WCLK and BCLK as separate clocks, the
'clock-cells' and 'clock-output-names' descriptions need to be
updated as now the codec is providing 2 clocks. The example is
also updated accordingly.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 Documentation/devicetree/bindings/sound/da7219.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/da7219.txt b/Documentation/devicetree/bindings/sound/da7219.txt
index e9d0bae..add1caf 100644
--- a/Documentation/devicetree/bindings/sound/da7219.txt
+++ b/Documentation/devicetree/bindings/sound/da7219.txt
@@ -23,8 +23,8 @@ Optional properties:
   interrupt is to be used to wake system, otherwise "irq" should be used.
 - wakeup-source: Flag to indicate this device can wake system (suspend/resume).
 
-- #clock-cells :  Should be set to '<0>', only one clock source provided;
-- clock-output-names : Name given for DAI clocks output;
+- #clock-cells :  Should be set to '<1>', two clock sources provided;
+- clock-output-names : Names given for DAI clock outputs (WCLK & BCLK);
 
 - clocks : phandle and clock specifier for codec MCLK.
 - clock-names : Clock name string for 'clocks' attribute, should be "mclk".
@@ -84,8 +84,8 @@ Example:
 		VDDMIC-supply = <&reg_audio>;
 		VDDIO-supply = <&reg_audio>;
 
-		#clock-cells = <0>;
-		clock-output-names = "dai-clks";
+		#clock-cells = <1>;
+		clock-output-names = "dai-wclk", "dai-bclk";
 
 		clocks = <&clks 201>;
 		clock-names = "mclk";
-- 
1.9.1

