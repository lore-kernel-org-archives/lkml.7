Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B6FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A1E20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfCDUd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:33:29 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53895 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCDUd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:33:29 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mn2Fb-1hQNWG3esB-00k5WM; Mon, 04 Mar 2019 21:32:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: qcom: add i2c dependency for SND_SOC_SDM845
Date:   Mon,  4 Mar 2019 21:30:52 +0100
Message-Id: <20190304203114.1894822-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190304203114.1894822-1-arnd@arndb.de>
References: <20190304203114.1894822-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tBuF72psa/NjOA4ImcigyUb6Ot+NZsUOvCekfqjHPkTj2QruFEM
 g/imKAiIKcYkVAahnvGt6pbZpZbJG0VnC4WOtUOT5tPrvAeWR2HB6qCAPC1XhgHW986zcOe
 XwhB2AmmvnP9csyaXe6WlJ1p9jDAmA9CVoxtw2mjavjqr9GgbHF74DyuoT+JPQNIMogazoY
 EfjWPpdQqTotPRs5AFIBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rUNdEgz872I=:T7XPFCgLsuDdO/UaHLH/Vo
 f42hTtUS/FohIPuSkpLsN0UZpSPij2uQYGeWfieb+C1+miFQnb8cczTR+tCBjHzyTmrdTPeBP
 8A5DJmzbC+WRM/5HAyrREb8dJVXIVIQu9cgGazJnY7z3bX9n7MkLHgFeD50mrOeNJS6jTR622
 /ZMnXm2aHsRKN7n0r/xgWNm+28looj7uJzMSzQAr5N8mMiPp0die56NVFtJF/sqKiiAR/byN5
 MAAy9KefBgCGPfRv552uTQtw28wzNOfkMYYD17PGrMK+AUCE3vhbjbKc4PMMGJ38OoPFtP7Cs
 TmMknHSVcB/oqDGKJcOi8WiVQpx6sXe7yr6CpFp2jNHm6Rx4GD4z++p7+itdoqF2XQmgYVC88
 qhMlSA3bWoAQHXqA0Zfv63xGunLYDB+AO2MaMpboEmeAouMiaxYxtbxjs+YCgaWTLUXNKHm7y
 ROkfxhF7ZaI3nsVDer5FDjLQFLsTjad7loFQt/J3e3/CP4Nz+lRtErBqQ++OuAsIhAmphDso8
 8ZpGSAkbXO9WxOk36VTU291vnuM9RviRJESG3s9O3Awe7B4M2R7PVlWiZqg+0KhBxRt2KA+ud
 TMh8Qw6IYOm5CuVKPnSy1zKe0KP9Th8twtEBi5MayUXXi4b86NrKqe+uaokjyPawfNCed182B
 Rc4dsxBWvQuu2hSIK/A6+vjMNlYFuhA1kZdQ0zbxp265Jk+Qh19AZ95bnXwUQTJI15DTKKKho
 sAckxZQNXonIX3yiHEmdIVQ6gkdgWiE/eaaDnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We must not select SND_SOC_MAX98927 unless CONFIG_I2C
is also enabled:

WARNING: unmet direct dependencies detected for SND_SOC_MAX98927
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=n]
  Selected by [y]:
  - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && QCOM_APR [=y] && MFD_CROS_EC [=y]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/qcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 75ceb04d8bf0..b1764af858ba 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -98,7 +98,7 @@ config SND_SOC_MSM8996
 
 config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
-	depends on QCOM_APR && MFD_CROS_EC
+	depends on QCOM_APR && MFD_CROS_EC && I2C
 	select SND_SOC_QDSP6
 	select SND_SOC_QCOM_COMMON
 	select SND_SOC_RT5663
-- 
2.20.0

