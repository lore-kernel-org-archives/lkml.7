Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B698DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE8220835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfCDTmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:42:50 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:59785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfCDTmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:42:49 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MNssA-1gcbKn06Po-00OJ3Q; Mon, 04 Mar 2019 20:42:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: olpc_dcon_xo_1: add missing 'const' qualifier
Date:   Mon,  4 Mar 2019 20:42:33 +0100
Message-Id: <20190304194242.765398-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hljR4sdyJUx4vNa+ntMtgyJdjAcguRe4HCStNxo1+nOJWUUVvWa
 Yg9OaVWzFBdVurt9NwSQKojq4T3JHxKIrJo3+YQB74RXNs+kVtHdshn+SqgugraDNK7tjTe
 eCk1MuzL7GtA2ufU56sT7dhzkKgSJvlg0EqQlCtuu0tkRtUPC52jaC2DHyd5lBFmWMmVnV4
 oDAig/pIKuu7jh9DBdosg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UxsNdDdXSms=:0PGjOnMUXOw5K3gSbrlWm/
 Pc59LlZsAkIlfD+tCJ3GAZz5soNCKy2p84AkC7jGMYw6F/O8C8vr7NxEVQJ7E+ZewszfaZgQs
 ks/s+WNus9TL8N6Sbtm4WB+dnjHC106RYj6v53ST9Bg3CUTmJ6hmx1y9J5Un6W3JHIxIiUzcR
 kfuOSaUH89PbVqH2zoRKGxMUeNIuygGfP7JRt4c/G1Yk1F4/R+0kcnVNKJ9m4+sphv7BinDsV
 gFM+b4ob0T9bx3JoEab3clb9dEzcvwOxPNP0AppH98CMpnvkdaP/Pj7WH3g6jLPCm7fR8R6cV
 NXVhmv4ExC5qqaAAMvxPDPKUNQUXWVNuZVLbAgqwSu/MRHiBx/Du3+XYdt1fnh+ayCzZDtcaF
 B99bV0hLlVCBH5D0PSjWbmMDetvMgue3/Fdf5LPYrfZG0+Za34jvk76y8No+V5/VseSgI04sJ
 rIH+AnAsmknwTjYqDJILwMq/7PzxDgxIZLUFMlsI9pyAlKwn1x8cB1qwkLnE3qwKjCRgcgLH9
 V5Ihn8b3WIKkdF4YOl9m5Tojb3XNIz4VtRU07TPJQid0xPzEmIXTSiGIGpUgVeEBU+Xdb85BU
 uOWsSHhuz0ezABDInQ+CJWqrB7GLSBlPGj2xPTI9ZvH9SP/DOA+NSjqywcsfIeqet2EijHfz1
 2lqR310zr7vsvw1N+OgdXtPNV0m7lOuk3v6y49WPVP78q1NeIKTdKt9aXiQa2VkqMxZQcg7uE
 Mh+cRzo8FaPPbNP8Q2xPVf8mvWkEWbksvIz65Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc noticed a mismatch between the type qualifiers after a recent
cleanup:

drivers/staging/olpc_dcon/olpc_dcon_xo_1.c: In function 'dcon_init_xo_1':
drivers/staging/olpc_dcon/olpc_dcon_xo_1.c:48:26: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

Add the 'const' keyword that should have been there all along.

Fixes: 2159fb372929 ("staging: olpc_dcon: olpc_dcon_xo_1.c: Switch to the gpio descriptor interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/olpc_dcon/olpc_dcon_xo_1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
index 80b8d4153414..a54286498a47 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1.c
@@ -45,7 +45,7 @@ static int dcon_init_xo_1(struct dcon_priv *dcon)
 {
 	unsigned char lob;
 	int ret, i;
-	struct dcon_gpio *pin = &gpios_asis[0];
+	const struct dcon_gpio *pin = &gpios_asis[0];
 
 	for (i = 0; i < ARRAY_SIZE(gpios_asis); i++) {
 		gpios[i] = devm_gpiod_get(&dcon->client->dev, pin[i].name,
-- 
2.20.0

