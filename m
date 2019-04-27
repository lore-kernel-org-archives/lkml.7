Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4131BC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D57E205ED
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfD0MxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:06 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0MxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:05 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M26iv-1hMqrC03Wz-002bb0; Sat, 27 Apr 2019 14:52:43 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 11/41] drivers: tty: serial: sb1250-duart: fix formatting error
Date:   Sat, 27 Apr 2019 14:51:52 +0200
Message-Id: <1556369542-13247-12-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:+TzVLpdAa88s4dLeOAxWyCsRhuc7KaUZKNLF0uRArPgYGfXSgiH
 Cc2vSSp3JHtH5Dh6TLARezDiIKDVv/NGSmiD/ku3dsWnfWOrtj1Cfj89ntRTXnSvx6PBKgU
 dt1TF7JLIo4mMJjyQ165GdSVmp05k1wOQx9x8rk+vVa9HNdzhgzqFQ2ZALqM5/sIDIRqkKv
 zpE63Uj8QixDSf+H4FfiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7g9mhemK6rI=:1LPea258+vT4cAu97il+UN
 TYKyF9QgPM9xIe6eeQ+jqNe+ggTMLP2Rvkb4j9U9H13Sg9CbVn9iCrF0YTfPvJy7st+0uGM2f
 /PnRFLO51z8114t2VgJaesPsgRavI/NG+JNJ7cfluxQbMaKGaxT6e/dwtJS7cjr1YYOomqA9G
 muP/UMza5Daoz+E60ichje3jvTqidA4lMSrQ9I6Hysh36D1wrMiCAB8NPPvc4nrvaddLXw6wB
 HgP1Z28SnAs7F4M7EpvU2+lQ0OTn37drJgeY/1adD+7p8We3CNEdSVlX/aiCHuYBdhtA0tQwk
 twP7c4eBkXAVXYagsNKW0MBlXlR0YW7fkDWkpusCcqgmZEquGN++8kKA5YtYIXEcg1RQIv5ze
 3sYNpA8wkk3GGqvshvtdRF4i/V07DDAKHjaZS4rViY5umoot7vu2gWZ7lETfiboO5z0AnKiNW
 ArDLwY9233EwB1kTHm54Jg7uCj6lRpmvrGsTo5d38MvHFBdNvTBRnyt2zIMulQmJtFb8kkKio
 L5hyUjTr2yPVMh8mBfg+gFuzlyXZDST0R3Rsxc16FX1n2PRzy15BgDF5VnY6vbekE+syIAUnQ
 CpezAGe8b0r4rC4XtzPF0T9lR/Pa1UWdKJH90iIIxuaLrBDvbaT57qKKbgRo+xkQtguPp6B41
 KnkPQ1UxL/FbNXzdFiuI/RSGrM7xIsl18lv3lduPbUzSCDcj7qPBT1cj99Wx+ndaKrPl0OaXi
 dDx2xwj2GagsyKcjT96JpuA4aPHWH0zLebvvLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch complains:

    ERROR: space required before the open parenthesis '('
    #659: FILE: drivers/tty/serial/sb1250-duart.c:659:
    +	if(refcount_dec_and_test(&duart->map_guard))

Just add this missing space to make checkpatch happy.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index ec74f09..0023ed0 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -656,7 +656,7 @@ static void sbd_release_port(struct uart_port *uport)
 	iounmap(uport->membase);
 	uport->membase = NULL;
 
-	if(refcount_dec_and_test(&duart->map_guard))
+	if (refcount_dec_and_test(&duart->map_guard))
 		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
 	release_mem_region(uport->mapbase, uport->mapsize);
 }
-- 
1.9.1

