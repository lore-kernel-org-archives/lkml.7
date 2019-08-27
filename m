Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1892DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08FA21872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892782;
	bh=2xan3JA0XbcDCezCqeZgTCnuBblZFltP+c7E3i0dKho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dL+ePz10xJDpxag7hembcIKRZ95RJQNmy97q35Bm1Hy2oNyGjTCbD5073VAdJmhD/
	 b+2XHl73j5xoi7SjaFlO+8dgaqVuczc0QzBHGhu2hm2x/yVXZxwkhYSnSugMVZZ4ID
	 uffjk/WcfazBKQZ5qqoGJAmXaeY3DyZa4C6fONbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbfH0H7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730667AbfH0H7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:59:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA77206BF;
        Tue, 27 Aug 2019 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892777;
        bh=2xan3JA0XbcDCezCqeZgTCnuBblZFltP+c7E3i0dKho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EXkdywU6NO1B1u2a8Itv+xrwNpOL6pSMWq5KUIebl+guGAqw1x5ET/3vAJWvIYlUg
         jYJK+DnOpvr52304uO0lJKP8BKe6rKBjMFA6fcL8AMfaUekZeIoFze1kFSv3mxoJvk
         ICSd20DKNzqglVa6SG2JE0z5p1Hyj1qIBZkTHwIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, russianneuromancer@ya.ru,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 011/162] ASoC: Intel: bytcht_es8316: Add quirk for Irbis NB41 netbook
Date:   Tue, 27 Aug 2019 09:48:59 +0200
Message-Id: <20190827072738.743903640@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



