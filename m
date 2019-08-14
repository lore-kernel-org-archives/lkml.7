Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F63C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFAD2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750389;
	bh=hTsSvV4d5LbSjyK/Y6RguugAz95F6OasRmMZczi0FoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lGC3AmAcfPqoIZ7MjK8mWtgC06e6hAg9rO/n7G6rD2LwLe6AjVrJ774/s0ZVIA3aU
	 hfsbL1ad5I6OgExb7xg3dUU+Zyv5sIBjCoDsGg7t0edbFzk56PN2vlbm9m4KJ3fWR5
	 ZP0eSnlg9D3aY10DvdSHfQAQB821y8OKlVdyAehw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfHNCjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbfHNCLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:11:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA93520844;
        Wed, 14 Aug 2019 02:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748676;
        bh=hTsSvV4d5LbSjyK/Y6RguugAz95F6OasRmMZczi0FoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H65YzqBs5wHs3r3J1pjCA5XmBWjCZQRwVLD4bbUg4xAu9oWjWjrdliBQwSmAnGXhg
         Rwsf3fE1OjbwFO8+58U7RSwFcpPYzCtrrTn6DJv6EdVacBLh6piBpEXd9ynQLF6xpt
         FSir5xAjF5UwKR0os5o9nMJXSYajiau4QXlW1qUM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, russianneuromancer@ya.ru,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 015/123] ASoC: Intel: bytcht_es8316: Add quirk for Irbis NB41 netbook
Date:   Tue, 13 Aug 2019 22:08:59 -0400
Message-Id: <20190814021047.14828-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit aa2ba991c4206d5b778dcaa7b4997396e79f8e90 ]

The Irbis NB41 netbook has its internal mic on IN2, inverted jack-detect
and stereo speakers, add a quirk for this.

Cc: russianneuromancer@ya.ru
Reported-and-tested-by: russianneuromancer@ya.ru
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20190712112708.25327-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 2fe1ce8791235..c360ebc3ccc7f 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -436,6 +436,14 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
 
 /* Please keep this list alphabetically sorted */
 static const struct dmi_system_id byt_cht_es8316_quirk_table[] = {
+	{	/* Irbis NB41 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IRBIS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "NB41"),
+		},
+		.driver_data = (void *)(BYT_CHT_ES8316_INTMIC_IN2_MAP
+					| BYT_CHT_ES8316_JD_INVERTED),
+	},
 	{	/* Teclast X98 Plus II */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "TECLAST"),
-- 
2.20.1

