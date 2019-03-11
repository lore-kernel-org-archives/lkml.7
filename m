Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB7A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfCKNWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:07 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41671 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfCKNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:43 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MdeSt-1gUYFr0rRZ-00Zg0Q for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:42 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 110/114] drivers: hv: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:19:02 +0100
Message-Id: <1552310346-7629-111-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Bse1V3RlI0Az0y3tjqIHkoUgicO7Q4iPPnoyo1KY+nZjqsCdufj
 FWTMSIy4SI/LAufQ9A8jgxIklCjmL4K5Gb8hkaczc+vk5i3BpMTRB9qmPDvNbgockzyiEFu
 +LnUjmpCt16uHu3V+D1FSyLeRtExTT07Z98szpxqNz45pdFGpoQihsis2l5AzvT0Quofceb
 e+Yaj6yAPXo4pIqkZSxXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xD2m5GkfOuE=:NIaqmGrb7KtGD4YEVThVtP
 noG1Xf5CHgpqWaS3+OHML8XQDVK0CpcBj+Qo2JJ/WWNGuxa+dlCPZ7QeaF5cIZaYkyfRNF7xs
 NJaz388tkhlZ8D0RVoqK6GOfnA3j/5eegpHQbeUTTlpF6T6DpQJ2H46ZCGfc1f+cexHchr4gd
 tWbQNISblvj64qZZnFgYIV+S15AbZ6nbjmNRa6CRJAs/tauK2TSyr1cfV86ASLcK4sfjC7G6i
 8rz+IL+OuhKuLhPlZmphNy7TZLOgbdFebDjBRZz9LDHUIZx+exaoYQeLs14CbnJld+5YZPMP/
 /PrVAw1Pab6YKtQvrPPmdZkl5Tq3x2eZZtGe90Efa3w1g7U4EAKHD7FbYmq5DEzAGxm24M52n
 xMKokXB/x1131H114crZNY5qgwO1OVbERcKPoA3BiWGuW6ZdTGZ++9Vpee0SwpBucWGxr3hmg
 HgCaNje19l+jgjZ0bnCatWBK9i/YDfkYemS8NqOU3kSe/jdGGOe4P9VomaiSbNlxRFAthNiAO
 9sun8FTfCxmPIaynDcfdrt1ROf/Lk5Juxw4lDvCyZ/uuqlhh/9ILwrHK0uwqHobm7RM9zM73X
 ObIJyyWRea5bzU3EL5hZPaeQS3Mm5v1nKNeVnuTnAajsJ1HqydcgKuj306a5bRoHv0CLs1KmB
 I7PK2W8ZjL2MZo0uLEZe5f8+Wue/Rt19aYqBYkAOhplLt8jQ6yv8oI5VEsGn4T3P20L8hb9JS
 26jz3pawxk/WPAO6dd307Eq8ke9A+gw+QCQziQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/hv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 1c1a251..016c77e 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -11,7 +11,7 @@ config HYPERV
 	  system.
 
 config HYPERV_TSCPAGE
-       def_bool HYPERV && X86_64
+	def_bool HYPERV && X86_64
 
 config HYPERV_UTILS
 	tristate "Microsoft Hyper-V Utilities driver"
-- 
1.9.1

