Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A851EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67DED206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurorafoss.org header.i=@aurorafoss.org header.b="gWskNoPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfDBQMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:12:25 -0400
Received: from out.migadu.com ([91.121.223.63]:51282 "EHLO out.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbfDBQMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:12:23 -0400
X-Greylist: delayed 453 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Apr 2019 12:12:22 EDT
Received: (Migadu outbound); Tue, 02 Apr 2019 16:04:47 +0000
Authentication-Results: out.migadu.com; auth=pass (plain)
Received: from deimos.IPLeiria.pt (1.140.37.188.rev.vodafone.pt [188.37.140.1])
        by out.migadu.com (Haraka/2.8.16) with ESMTPSA id B2C61337-E774-4E5F-8305-8F8B1EDA6118.1
        envelope-from <luis@aurorafoss.org> (authenticated bits=0)
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 verify=FAIL);
        Tue, 02 Apr 2019 16:04:46 +0000
From:   =?UTF-8?q?Lu=C3=ADs=20Ferreira?= <luis@aurorafoss.org>
To:     jic23@kernel.org
Cc:     =?UTF-8?q?Lu=C3=ADs=20Ferreira?= <luis@aurorafoss.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: accel: add missing sensor for some 2-in-1 based ultrabooks
Date:   Tue,  2 Apr 2019 17:04:30 +0100
Message-Id: <20190402160433.15810-1-luis@aurorafoss.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1;a=rsa-sha256;bh=Nv/VG3gO2AdX93vek5Wd4ezccTwYPqvLhASFrj7Lb4Y=;c=relaxed/simple;d=aurorafoss.org;h=from:subject:date:to;s=default;b=gWskNoPAdKoPdD5B0r1PzkMvzlAOqGwfVqXrbZbO8pz4g3BHrO2KrgvKy1eMhgZ/d9P6k9rCYgRSHQf/MzRcdrsdREMXOf0fjeiT/EIxzIV1gLK/EnIWlEFYfReYP4npQgTFMjVAn8msC+TlN2m1lROsPTtljuV1nedQRxahB08=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ultrabooks, like Teclast F6 Pro, use KIOX010A sensor on display
and KIOX020A sensor on keyboard base, to detect tablet mode or screen
orientation.

Signed-off-by: Luís Ferreira <luis@aurorafoss.org>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 7096e577b23f..9a5e445facc1 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1492,6 +1492,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
 	{"KIOX0009", KXTJ21009},
 	{"KIOX000A", KXCJ91008},
 	{"KIOX010A", KXCJ91008}, /* KXCJ91008 inside the display of a 2-in-1 */
+	{"KIOX020A", KXCJ91008},
 	{"KXTJ1009", KXTJ21009},
 	{"KXJ2109",  KXTJ21009},
 	{"SMO8500",  KXCJ91008},
-- 
2.21.0

