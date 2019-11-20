Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EE8C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4699822529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257312;
	bh=Ji/d8zDpNXz2ULxuAqJq6wiOMM2wmyReCHpUzZYzkwE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Myu801463G7TmZevFRVbpdFEwGAnrptzI97qb1ITZ0RoiMSPIQvyqkJqb/GpP8KEY
	 +09+MMf1qoy9ROU4pZRILIKq1/v+9cVTWr0z4H1//JTQnFj2oQ2GQx25Oy64hl2jHz
	 1oZdd8/VpzMQ6w/QwpeZPrpTRQUJNDXVSueLeSMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbfKTNlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:41:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:49564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730431AbfKTNls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:48 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83DBD224D0;
        Wed, 20 Nov 2019 13:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257308;
        bh=Ji/d8zDpNXz2ULxuAqJq6wiOMM2wmyReCHpUzZYzkwE=;
        h=From:To:Cc:Subject:Date:From;
        b=jXmBgxsGumokE0ef/plIwRMyCW3R5sn20F46tnew2Lgywni198kqmqX0o/68RImGE
         cmuPSMNhEHRvbLowInK2gtMG0oI96ehyGTBipluDD2Vu9ilj1VFfDOPYnqvsUdPHjM
         CUOZIF+pPru9ibdBHv8uVrk+RVWzpKwCApXEajYQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH] iio: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:44 +0800
Message-Id: <20191120134144.15302-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/gyro/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 95e6f96d4529..f91af3b8e4da 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -82,11 +82,11 @@ config FXAS21002C
        select FXAS21002C_SPI if (SPI)
        depends on (I2C || SPI_MASTER)
        help
-         Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
-         Sensor driver connected via I2C or SPI.
+	 Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
+	 Sensor driver connected via I2C or SPI.
 
-         This driver can also be built as a module.  If so, the module
-         will be called fxas21002c_i2c or fxas21002c_spi.
+	 This driver can also be built as a module.  If so, the module
+	 will be called fxas21002c_i2c or fxas21002c_spi.
 
 config FXAS21002C_I2C
        tristate
-- 
2.17.1

