Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C368EC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BB720692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgAGVoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:44:08 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:33119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgAGVoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:44:08 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MqJyX-1jTAsg2bXn-00nOpV; Tue, 07 Jan 2020 22:43:57 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: oxu210hp-hcd: fix gcc warning
Date:   Tue,  7 Jan 2020 22:43:46 +0100
Message-Id: <20200107214354.1008937-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u/ytrvgdvpHgxcX8GjwpWa6Af54BI3w1VDFyYZI9vnfeynUjOy3
 ofGBPPWyyjdYVlh872IwYSN7PvKXmMh0PRXqYLWKWO5881hshyH2kNXawfh/aSluCSu2J+Z
 XWYRqos4HKG1iWxAjXnJQm79u3Oms+nN5h8cCzFzvrY0Q14c4qYYxxBSWqQvVU7SgjuxzIc
 i7TGH5kInsgBc3rkL8bWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZMoTU0wa2ac=:lvE9Be0DhiEfjAyWJoDnPO
 qYN/G9FRzWWHg4OyIzjCfzC5K6R3ylqkk7fp531bS+lsK2HLb0zkXpnvdXn9tkHWCZjeC5uqx
 cPJkGyD3ZoXwi8hORzkLCMVmXV4GdzEDW+XoTXKvv4VQIv/BMyzTmgjAUZqXMCn5wKDLICIFI
 e0Kjof50BTUdEpLjGJwU8yzG+HGVCRrV056H734Nt3Jw4sWCrWdvf+amUbYIqObr85oNAGt49
 H3ca/1Op3PgiFiqwMFb/yTVSv2VN5FXSGw3Ab2A44RXB9YzYXXhNFH5i6kuPOdPqEFT01QFkc
 YEdugzRemJxdJeBjZLyJ0NPJ8CgfTkoFI9FJp7NTNqm1qvDyjM/jdtKhuJQAuJrs6V0wobWk1
 VebsZQm15DVkfb6UxSxr8JlVcPsTiIlkpgXyIlVnvsYCTsGPtFT8EZm4V7Gsu+wl9MRfqI/0q
 6/cV3rYlg0XJbxMh2UGX9/DTPO9Xk++rKtthJ8v0JtUkm33t/0MTMjsdgxR5z8y5/aWpbcESU
 MN3jQVWkHh2aC59Pl3kCE0u5f/mCrAs+/1C4DT5Mr94XsNSb1eE09NnoTE2ovEJMUQ3RM+PhC
 Zm04nmceuVCGZlTLHBc2Y5KwmwOWNip4H9t5ks9ugG3vb8OsqgZY2IPfy+uChMZukkW+CcPfz
 qDzJouVKzJxBUwtPu/1EI5DuMiiAEPyqBSoWeucfSR9iDCmDq/O9jVr2fP6JyWfsoFWRGTS0+
 b/+22nr9dEZYovv/+YBBousiscNu/O3DzhFsSSrK9OIAHxK3b/QOTBdNAAYVeL1Yb3XRg7Zbv
 7ON7v17xYK/ol8gwun7NuiRjsPoCtKvfDhnwS/h+qe44oXtwK597sxmjE6wedArQAz/Bbb022
 QzMNkx7ahA9JoNmzsLNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -O3 warns about correct code:

    inlined from 'oxu_hub_control.constprop' at drivers/usb/host/oxu210hp-hcd.c:3652:3:
include/linux/string.h:411:9: error: argument 1 null where non-null expected [-Werror=nonnull]
  return __builtin_memset(p, c, size);
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/usb/host/oxu210hp-hcd.c: In function 'oxu_hub_control.constprop':
include/linux/string.h:411:9: note: in a call to built-in function '__builtin_memset'

Expand the code slightly to let gcc better understand it and
not warn any more.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/host/oxu210hp-hcd.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/oxu210hp-hcd.c b/drivers/usb/host/oxu210hp-hcd.c
index fe09b8626329..120666a0d590 100644
--- a/drivers/usb/host/oxu210hp-hcd.c
+++ b/drivers/usb/host/oxu210hp-hcd.c
@@ -2783,11 +2783,15 @@ static void ehci_port_power(struct oxu_hcd *oxu, int is_on)
 		return;
 
 	oxu_dbg(oxu, "...power%s ports...\n", is_on ? "up" : "down");
-	for (port = HCS_N_PORTS(oxu->hcs_params); port > 0; )
-		(void) oxu_hub_control(oxu_to_hcd(oxu),
-				is_on ? SetPortFeature : ClearPortFeature,
-				USB_PORT_FEAT_POWER,
-				port--, NULL, 0);
+	for (port = HCS_N_PORTS(oxu->hcs_params); port > 0; ) {
+		if (is_on)
+			oxu_hub_control(oxu_to_hcd(oxu), SetPortFeature,
+				USB_PORT_FEAT_POWER, port--, NULL, 0);
+		else
+			oxu_hub_control(oxu_to_hcd(oxu), ClearPortFeature,
+				USB_PORT_FEAT_POWER, port--, NULL, 0);
+	}
+
 	msleep(20);
 }
 
-- 
2.20.0

