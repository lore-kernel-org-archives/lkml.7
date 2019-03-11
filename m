Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98AEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FA9206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfCKNZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:24 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52995 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfCKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:39 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvbO4-1gkA632VQE-00siKL for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:37 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 076/114] drivers: virt: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:28 +0100
Message-Id: <1552310346-7629-77-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:jFjYX0frhQ0wIS3LWB8N/kYhTd2681jx+LFrU43KpSosMGny9iv
 Eey8eyQq/cbX5ciPF5zzrg7jSTlrxQZV0zF+ujq2bWcI22oGSNh6ZTyH+sKATsTc5Z/1W8i
 BUUrrXnRFhWYiB0qMFbwGgPq4fAH0XSgDhzn6NsNm/uP5118vfL5KndfpqDh/S9k5z7TDF/
 78JohIFBwInopw9iP3obA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SJsF8Teh/+A=:crvwkNase1dLyZgJPFOYJZ
 xpCu6mwD4X6VpoDcnRKGADlnBv4Qh9VzqyPStfPttgheuD5wXY6lhFO3sGBygj3MXSIvTK6Lq
 a1rg0AIMJmF2ccJFxENTca3kAWG+NmNChez7notiDsWmeLvVwMttIhvUmYkc9k4MNeY6nsmVA
 M6TZ4quu6Tpktdqps8lu6ylnQFa/Tpfybk3HrMwAD9aJIKdSlNr+hw8emqvwwjy7eJn/1eiA+
 OZV3nqogca7XuQhR/DTn2NTiHyi94yniD+iK8cQgrRMZt6ra9lv2rQ9+DDzAzlA1FtsOCb6lM
 WCeearx/J9/bjmz623U5KXftcdgBB8AxvP6uWBWtnrimCuAVp5SLYnaz4qKqN1aMPvgyK41JD
 4HMiGjvQKay4xvewo11Ug9wQUlBE/QDHqnCmaltqFIWMM8tuXrsc0lIzlbyR9wEWfjmTn7tad
 ob4p1sRjxYxmyPXbjqO1JvH3HsMuHGg1Ms7OByrv+RzGSWPdALt1hGwtVIfH1NyTZF/J1G0BU
 9ZdMJEeiapnek1PtYpMjUH1+OfnS0jmlqBvSterjog3hcSvfQiiEYt/9VsUWVzByPC0WFQeLk
 k+pXoRYHqGAq4ZgDcls+eaadAkbRRCp2Ht2wdWgfZZ6HslzpN/3DVckf9DxLUuGBEpackF6y4
 wCTWCNyukrj02CtYrApnS/R1mgmFUZreJKJvrk2J+vIZeuzQSClx0/BC2qHNoJdKZ83km8eBB
 +3MqpxD5r0gUyhRMZqTU5Tb98CQGph4Sgo7Q8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/virt/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 8d9cdfb..17a8685 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -17,17 +17,17 @@ config FSL_HV_MANAGER
 	depends on FSL_SOC
 	select EPAPR_PARAVIRT
 	help
-          The Freescale hypervisor management driver provides several services
+	  The Freescale hypervisor management driver provides several services
 	  to drivers and applications related to the Freescale hypervisor:
 
-          1) An ioctl interface for querying and managing partitions.
+	  1) An ioctl interface for querying and managing partitions.
 
-          2) A file interface to reading incoming doorbells.
+	  2) A file interface to reading incoming doorbells.
 
-          3) An interrupt handler for shutting down the partition upon
+	  3) An interrupt handler for shutting down the partition upon
 	     receiving the shutdown doorbell from a manager partition.
 
-          4) A kernel interface for receiving callbacks when a managed
+	  4) A kernel interface for receiving callbacks when a managed
 	     partition shuts down.
 
 source "drivers/virt/vboxguest/Kconfig"
-- 
1.9.1

