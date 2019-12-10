Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB671C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E2D214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012393;
	bh=xzaz9CcmR2A0BgOWJp3yodJRbsKeIwbAeeptlfyvMfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e1sF7W7dxZm0wW8CdNgZh5tmwerJgrV1vt2lh3fLDWOnFDwicfXjAeuA+UgHmOITr
	 9va0Tfjdom6SJnSvzrwjQJgp+iD8ny9Ic0RG0CWe55DvNqnj2mcno1M9ZIw8CnfwuS
	 45hU+tMElVnSwH1QAUQWWZHMrgoM5IUEsXPEyz2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfLJVNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbfLJVNJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:13:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72B6320838;
        Tue, 10 Dec 2019 21:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012389;
        bh=xzaz9CcmR2A0BgOWJp3yodJRbsKeIwbAeeptlfyvMfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jsiWtDExKgeYWW90VIpUfiwU7upiBHQStrCTVOIZ1AeIHhWtuy7TlzYeZFpdwoZJg
         wlO6wwyMSw3Rvo4THJ+1MTT3UNwPlA9TPW3DwYl1NopSKyXa0V5xiYdCclo7kIdaab
         7Xhq7bFHup1mKTthzGvI3epSqcd4FJn9PQm6N9Qs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 311/350] ASoC: Intel: bytcr_rt5640: Update quirk for Acer Switch 10 SW5-012 2-in-1
Date:   Tue, 10 Dec 2019 16:06:56 -0500
Message-Id: <20191210210735.9077-272-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 0bb887709eb16bdc4b5baddd8337abf3de72917f ]

When the Acer Switch 10 SW5-012 quirk was added we did not have
jack-detection support yet; and the builtin microphone selection of
the original quirk is wrong too.

Fix the microphone-input quirk and add jack-detection info so that the
internal-microphone and headphone/set jack on the Switch 10 work properly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20191119145138.59162-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 9c1aa4ec9cba4..dd2b5ad086591 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -405,10 +405,12 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
 		},
-		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
-						 BYT_RT5640_MCLK_EN |
-						 BYT_RT5640_SSP0_AIF1),
-
+		.driver_data = (void *)(BYT_RT5640_DMIC1_MAP |
+					BYT_RT5640_JD_SRC_JD2_IN4N |
+					BYT_RT5640_OVCD_TH_2000UA |
+					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
 	},
 	{
 		.matches = {
-- 
2.20.1

