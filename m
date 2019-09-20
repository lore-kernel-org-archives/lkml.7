Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59FAC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E4F207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 10:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438080AbfITKzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 06:55:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408762AbfITKzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 06:55:20 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C58A4FE6724F5DA473F8;
        Fri, 20 Sep 2019 18:55:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Sep 2019 18:55:10 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/3] platform/x86: eeepc-laptop: Use pr_warn instead of pr_warning
Date:   Fri, 20 Sep 2019 19:12:05 +0800
Message-ID: <20190920111207.129106-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAHp75VdQES5oasGzi0JdnZAEL2AfCozHJaHBa9dpg1Ya_N17-A@mail.gmail.com>
References: <CAHp75VdQES5oasGzi0JdnZAEL2AfCozHJaHBa9dpg1Ya_N17-A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
pr_warning"), removing pr_warning so all logging messages use a
consistent <prefix>_warn style. Let's do it.

Cc: Corentin Chary <corentin.chary@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/platform/x86/eeepc-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index f3f74a9c109e..776868d5e458 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -578,7 +578,7 @@ static void eeepc_rfkill_hotplug(struct eeepc_laptop *eeepc, acpi_handle handle)
 
 	port = acpi_get_pci_dev(handle);
 	if (!port) {
-		pr_warning("Unable to find port\n");
+		pr_warn("Unable to find port\n");
 		goto out_unlock;
 	}
 
-- 
2.20.1

