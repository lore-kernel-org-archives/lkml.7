Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23681C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA90720857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfCKNWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:34 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfCKNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:43 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MgNlB-1gZX8M42Zz-00htTg for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:42 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 108/114] drivers: firmware_loader: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:19:00 +0100
Message-Id: <1552310346-7629-109-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:D6sEAb0RLA+lKPAuMTvGJ/1Ps0VrwPyHPge8f30i3xKAr3QXI2x
 FEau6v/Qi9sJklSm9HpLcpMBofbnYpkusaMqDFpUmaY5oJIMMCm/ujJhlkBT5R1QBqx313a
 bGOuAwDX8ztufYK85536q/xlE3JyhE0foNvakKLuG/QYggv3fjJmnHY2BZlnAIuusE2BS2l
 jZNmRemhd9xtbmJqyzJHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rCQALFmSM7E=:hp+o0QQ1Cwg6ilUfyFxKFT
 QJ9x49c1IC/S1gyAQt7DeN7JNLltKjNpzAu3rOg4rz6SX4IwJniZ10/Ble6Ax4URWoGFop53V
 h6zMtcjdTEZrshKZ64EjsNkSiadD/MWgVpe14Tfpq4KDBweO8mYvYLf4nlmYAbLje6ZFZrua2
 kkVxMhykmmNrYYvUoJHJPhK5QaZ83FXzbtgBdyca1FtL7TWTOi0Fl6Jtq+U6xIFgfK5io51rK
 aobwWWo37pvRTjbhc+6AECjZcScdDA5chM3h7DaxA7lQd0NcuynGWMpsKItTHW7PSYXu1VQaO
 RfgBBxRrH/x/VTdACpkSk7w1/ADuCTeDsjpKzKX+Ye9Zk0Ic2hIIIbelNkn8gB37ntjxcFrId
 uqKmdzJyDNSXDPAEmlh7rqlqFZZtC/c0T8p0sAgYmeZt/vR350ExRG3VAbVmnkjUFhgmepfO/
 yDMPcLqnsVIPc0kzoaZn9LY3M5ZptlViyRf9GhPNXZ0nfz0uchGbduy/oPTmiZYh11tGayCPX
 qmxrSjQZh4rhlq42zYnRkfMiFHcosSV4qEZ3hP61ZAq32EGNm/rbwP4W6EuMeoNy4ciw4qGGq
 WHXzxNnONnkst34lCO4KjbZX7ZDDOz7k5bJhpsUyUaG3GTmVVxvqN9YG8Tf2QMF/TxKdbYfxC
 xO93pfDvKdHKduqHwbK9VyxgWz45vs86Cl2aZZgaqzRoh+CPvIZywmXmVa025l50VcC54QG/9
 rdRADoidVImsB/9oVtoIr8rLczOCPzOqg2v2PQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/base/firmware_loader/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index eb15d97..592e689 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -143,7 +143,7 @@ config FW_LOADER_USER_HELPER_FALLBACK
 	  to be used for all firmware requests which explicitly do not disable a
 	  a fallback mechanism. Firmware calls which do prohibit a fallback
 	  mechanism is request_firmware_direct(). This option is kept for
-          backward compatibility purposes given this precise mechanism can also
+	  backward compatibility purposes given this precise mechanism can also
 	  be enabled by setting the proc sysctl value to true:
 
 	       /proc/sys/kernel/firmware_config/force_sysfs_fallback
-- 
1.9.1

