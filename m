Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9996C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7355720663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 02:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfCGCWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 21:22:38 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47599 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfCGCWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 21:22:37 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MZTyo-1hYIHt3cf8-00WZmN; Thu, 07 Mar 2019 03:22:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH v2] drivers: uio: Kconfig: pedantic formatting
Date:   Thu,  7 Mar 2019 03:22:34 +0100
Message-Id: <1551925354-21162-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551896023-14007-1-git-send-email-info@metux.net>
References: <1551896023-14007-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:obEEiQ0kF/O2iiHDuLuLVrvkBa9tn3FfjNPLMCa+308iBMLh0Ja
 HLMhzM+J2pxxio5kiJYeov/Jep35tliwKiLGmaw9m0wuZTIJCTIK2xPjGuD8lYS1Ej2LqR7
 JfIbvhxLqqmcps4fNkTMSmLw//qKvJqOk0OZRmLcRwDqkdXIO6a75RQa8kgd5YD6uQSgFUq
 xzT9lKmEn77iK0dn6aUgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:47K0Lxf1+G4=:DoHqQODNxiFvkXLpMOig58
 InvWLtuOgkAQHccmm/EtYPnSsrICVgOYnOrhXhd5uKhcf56ddC6CFeUEJfLccwfyjBsy7MrGx
 Sepbdkbgg1Ge7lTyuwh9icRZZvKLuAWjPVPukzszXxdnw39d9yT+0JZVKhWFe6VyPzAi9OSc1
 lp1Nf/T0ztluuZNZQAngyjxRwZIFMzMHXXZ9O6PDRpEQxCdP5T64Ch5eZqHokvsGgq7F+Evmj
 LO8Zt2ngNQ5cHStRIBYYq613J7h4F5jmc5ELRYEzJ9U2rOAS4coRszpILlQyMToiZ99PCvpkB
 AuXqw7kae4Vw+lYCngDWqISRWnkgIA8bWbV+n1ul5yq64cyhNVrHXqV2gFgw9GlORvxjIo0/l
 ODtOvW/tvJkeUE0VLoyzyO16NZ6F2dFvHOotWhmB2i0oQzTw2cqTQ1J5kHShpp7wXxD4WWsx7
 NAvn6nJRgXhE3jmQkd09HoYOuSOsqogt2VAxnsR315/A40k7UFIq2A72B+In8mLtWlCjN368V
 z/WhacA7Xujb+Vg/SiRfX1De1TcRWcsZo+Rja9POdyEMgCMP7TpP0ghp23AlC37DTKxj+PcRf
 BE+FRrQEga4qKzpNpWW8kL11sSiq4ievOTmg5Zn4GdwSQgiphj/sE2mg/Pa9huSOn3oKUIUol
 0hm29md60E7WqVrg+0ZMq20j9Cn+5lRqtMztU9nsGW6rZBw2gfLHFFmLeFGHN/qcIcSGGgt1l
 4XDmQtLRP3+68WQLn/2KAaMBY/508QT0Ylp3EA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig doesn't look so pretty, so just take
a damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/uio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 7e8dc78..4286b73 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -17,7 +17,7 @@ config UIO_CIF
 	depends on PCI
 	help
 	  Driver for Hilscher CIF DeviceNet and Profibus cards.  This
-  	  driver requires a userspace component called cif that handles
+	  driver requires a userspace component called cif that handles
 	  all of the heavy lifting and can be found at:
 	        <http://www.osadl.org/projects/downloads/UIO/user/>
 
-- 
1.9.1

