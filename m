Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BC8C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D95218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbfCVOJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:09:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:55729 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfCVOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:09:45 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MGzDv-1hCXvq27sJ-00E25M; Fri, 22 Mar 2019 15:09:09 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Lee Jones <lee.jones@linaro.org>,
        Stefan Agner <stefan@agner.ch>, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: stmpe-adc: avoid harmless clang warning
Date:   Fri, 22 Mar 2019 15:08:39 +0100
Message-Id: <20190322140906.319267-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LsArqJRnc8Nh4Hs3awc98LbB0oEkPJppi5wt30jJ9pQ28ugEIk/
 Jm4cAL9MCDBiFJr7VLu+YWUmfnMBojlNyJEKZ3rSOByCQiTjc+Y42edEmBTwRKjEnXgRkta
 fuquITpE1ZPhoI4El/oshu1jTZQwKwfpBDjxGWK3A2Ons3shPsBySLhLInMy2Zfk52S769Y
 48xqpH5mDaOFBAbSo+d6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bg8IhLpgIxU=:+PtXwVmnCw+djAtLG9I0nn
 ejsH32So6S37sGTZioLsBgCRZZDqzoPaDMd+nCqUoNhn4tnl6fWFjqf5d+i+S0P+zYjtIhOmD
 WsP4IhOzrIKLbTMFBOm1Zw/MWVVWT+0JUy+tlHCnIIlrjUTm5qBMNCoL98MqM+xgAtrlZn6Kn
 kOfiEDuuhW0CVLlLNZCQfe/Df5vZrHLvvkYBNKUzGqy8IifrIM+Ue7vhDT91E8xQa4dr3Fr3j
 R9yWRlX+5ZF+8MPCHHoicc3kYoslm6x71NUgu8aBlp/Fo9FLIuQdI38J0lu1CH7lvC7piLYho
 vy4mR7UvlxpeDoc4in2Oar3NbPqQiRiZJZ5vdLOHWpK0mw/sGqvQt0kJ4TLYnKkIaqXiyg1HE
 jC6kEicb2Ztl0tEDHlqxJxjzu7FhuGM4kOpkZ9AMCnmFS3klD4Mk0wHUA/tliK1kGoP82Z4ox
 8voguriLbfR5UyN6ujS09uz70iQM0/aMH8DEdhtr72Wf/R1/LjkeUJc0gxKSikn3tkaICpccf
 JcTCMBM5K0HeiS/K2QYw0ENxdkqNzFcDAiXBdoDBNXEBc4sMPtDQreJWeWJdb5RaQelJec5v1
 bRuhvWKst+/JlwMk6rAs76BqZlvJA2mBHA1vOkUxMMM8VNlJRzs8C/CVCcqzIB6E1XThW1/gq
 rhcgf/j9O7gdvaeSFgU55zFbQHz4ZIdcmt8OF4Bq/wEauPbNCRXQVqAfAHptULP3shbKycILj
 an/9swV2ILGCXbdz+hDUfzbDbHLo6vlPQXKQkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang points out a control flow bug, which happens to be harmless:

drivers/iio/adc/stmpe-adc.c:204:13: error: variable 'data' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]

The warning is sensible here, so let's just avoid the case by
adding appropriate error handling.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/iio/adc/stmpe-adc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
index 37f4b74a5d32..ed3817c5c896 100644
--- a/drivers/iio/adc/stmpe-adc.c
+++ b/drivers/iio/adc/stmpe-adc.c
@@ -205,6 +205,8 @@ static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
 		/* Read value */
 		stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2,
 				(u8 *) &data);
+	} else {
+		return IRQ_NONE;
 	}
 
 	info->value = (u32) be16_to_cpu(data);
-- 
2.20.0

