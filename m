Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90099C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69BA52253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfLMJsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:48:50 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:48106 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfLMJsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:48:50 -0500
Received: from localhost.localdomain (unknown [159.226.5.100])
        by APP-01 (Coremail) with SMTP id qwCowADXx5RzXvNdeQexAw--.57S3;
        Fri, 13 Dec 2019 17:48:35 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: sm5502: remove unneeded semicolon
Date:   Fri, 13 Dec 2019 09:48:34 +0000
Message-Id: <1576230514-5049-1-git-send-email-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: qwCowADXx5RzXvNdeQexAw--.57S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1xuF4rKFWfWFW5KFyrtFb_yoW8XF4xpF
        Z8Xrnavr1rXw4S9rnYywsrAFyrArWft34UGrZFqa4fua15tF4kua1akFW0vFyrAFy0g3y7
        Ar4jqFyqya40yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4fMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8LjjDUUUUU==
X-Originating-IP: [159.226.5.100]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMDA10TedGtvgAAsw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unneeded semicolon
This is detected by coccinelle.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/extcon/extcon-sm5502.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index bcf65aa..106d4da 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -249,7 +249,7 @@ static int sm5502_muic_set_path(struct sm5502_muic_info *info,
 		dev_err(info->dev, "Unknown DM_CON/DP_CON switch type (%d)\n",
 				con_sw);
 		return -EINVAL;
-	};
+	}
 
 	switch (vbus_sw) {
 	case VBUSIN_SWITCH_OPEN:
@@ -268,7 +268,7 @@ static int sm5502_muic_set_path(struct sm5502_muic_info *info,
 	default:
 		dev_err(info->dev, "Unknown VBUS switch type (%d)\n", vbus_sw);
 		return -EINVAL;
-	};
+	}
 
 	return 0;
 }
@@ -357,13 +357,13 @@ static unsigned int sm5502_muic_get_cable_type(struct sm5502_muic_info *info)
 				"cannot identify the cable type: adc(0x%x)\n",
 				adc);
 			return -EINVAL;
-		};
+		}
 		break;
 	default:
 		dev_err(info->dev,
 			"failed to identify the cable type: adc(0x%x)\n", adc);
 		return -EINVAL;
-	};
+	}
 
 	return cable_type;
 }
@@ -405,7 +405,7 @@ static int sm5502_muic_cable_handler(struct sm5502_muic_info *info,
 		dev_dbg(info->dev,
 			"cannot handle this cable_type (0x%x)\n", cable_type);
 		return 0;
-	};
+	}
 
 	/* Change internal hardware path(DM_CON/DP_CON, VBUSIN) */
 	ret = sm5502_muic_set_path(info, con_sw, vbus_sw, attached);
-- 
2.7.4

