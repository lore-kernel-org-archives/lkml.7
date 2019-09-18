Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E48DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF90222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbfIRT7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:59:43 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:34911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389179AbfIRT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:59:42 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mn2eH-1hl04i4Alz-00k3oy; Wed, 18 Sep 2019 21:59:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alex Lu <alex_lu@realsil.com.cn>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: avoid unused function warning
Date:   Wed, 18 Sep 2019 21:59:02 +0200
Message-Id: <20190918195918.2190556-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:V9UkgJWPr+oQDUKlZDpC/V5IuPfRkDiGAUbYndfxVz2FSuR/60M
 AOmNix9PbnZdckGDpVOk+MA6SjDiLwv8rFSfPx/KjN2lgpK+fVbCTi1l/5C1PtSPO/rj15F
 YrEtNgJxsOgW6GHrcId568mc2JglzR/EhDgBEha1+uYg95WjEDJ4r0N6JeU6tODxJg6Ay/m
 16LCKM+tJjGlw6ux1TO5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XGM5hiqQ4oQ=:McT85o77EouwbgvZ4DbKlb
 BArsKptu4Hav7SUMtrGjZpi/3qIAze3LYNXi+sT/JDUdnlZ86uqRt+XtGjRbFFMfpdS2VLOUa
 ofqiQIQJvjvxnO+dF5gLNLpYxq8/A2u+nKltCRfIhloFoOjcp62jxE5bVGNXrKlLvMi/74jti
 mhFqr7wIpsGyQwatY73Igd3XbmmwdeKJq8gNItFJ50Kdi6UgBrcb5hrHVbTp5IdEy85qgrBLO
 bxjNqWAIzAK1OUX00GKRuOoR4oioe/49y13aR6d6Wq3ueJ0ANAMUE4IvQnTwo+kNDc9FTkWoc
 i8T4xze7NeWt2ASNHBshd8I6q2JhJrmCYcscBpinjm8L772MhDSLtZt4J4beOFTEpqo2NO3I4
 FffGroBAmN89M+d8a3jJB6DF6vHvtdcabs2Khl3am8l55WW28UX5R8vFhSzeZ//SLW/hhI9Rp
 3Su+1IVK2dMVoAv8Q19S/djclNQwUaeZpZmNx29oSYXzvhwVsMzyY9EEHk7dDQG1dzPiEqBzZ
 TqGDjP3CNocq1SLwukaaiBP/Ks2kWKWQ5Z6tvcnRJ5a2uqw86ilCXzOL/4qktXoUeTany053S
 eSqFD44NCGz1rcyXprL+87qTGUSx60raizAX8F5AUeDMtTK0GOeFVnaepL7YZr57yAhQzoUh3
 fZMObq1ZtF3HiV9wJHCFXjjXf7xyUjQM0McnH0dn9w0yP274ayn1cwv6DBBtJ4/yCZ3TdX6Fn
 Af+g/0fAlLqtBUKMVTmzWTNr05dGNXc6nNkGJCq5VZS+H386kdS+/Sax1IOfl6DRltDBUjUk4
 ilULa3rqOfk4iwkzhiAsxolZBubiDnghG9nHvfbtJrOZFOwAFtogIo6oWa3+wAxJ0vnGTYNCx
 oFRE/tYwe7nEYMegqNhg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The btusb_rtl_cmd_timeout() function is used inside of an
ifdef, leading to a warning when this part is hidden
from the compiler:

drivers/bluetooth/btusb.c:530:13: error: unused function 'btusb_rtl_cmd_timeout' [-Werror,-Wunused-function]

Use an IS_ENABLED() check instead so the compiler can see
the code and then discard it silently.

Fixes: d7ef0d1e3968 ("Bluetooth: btusb: Use cmd_timeout to reset Realtek device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/bluetooth/btusb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a9c35ebb30f8..23e606aaaea4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3807,8 +3807,8 @@ static int btusb_probe(struct usb_interface *intf,
 		btusb_check_needs_reset_resume(intf);
 	}
 
-#ifdef CONFIG_BT_HCIBTUSB_RTL
-	if (id->driver_info & BTUSB_REALTEK) {
+	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
+	    (id->driver_info & BTUSB_REALTEK)) {
 		hdev->setup = btrtl_setup_realtek;
 		hdev->shutdown = btrtl_shutdown_realtek;
 		hdev->cmd_timeout = btusb_rtl_cmd_timeout;
@@ -3819,7 +3819,6 @@ static int btusb_probe(struct usb_interface *intf,
 		 */
 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
 	}
-#endif
 
 	if (id->driver_info & BTUSB_AMP) {
 		/* AMP controllers do not support SCO packets */
-- 
2.20.0

