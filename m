Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29B0FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED0E21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 15:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404801AbfJPPIL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 11:08:11 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:34040 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbfJPPIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 11:08:11 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 8E62867A910;
        Wed, 16 Oct 2019 17:08:07 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 16 Oct
 2019 17:08:07 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Wed, 16 Oct 2019 17:08:07 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "krzk@kernel.org" <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
CC:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/10] MAINTAINERS: Add an entry for Kontron Electronics ARM
 board support
Thread-Topic: [PATCH 10/10] MAINTAINERS: Add an entry for Kontron Electronics
 ARM board support
Thread-Index: AQHVhDOEhsJ15O7bEUOF2rAmDLstWQ==
Date:   Wed, 16 Oct 2019 15:08:07 +0000
Message-ID: <20191016150622.21753-11-frieder.schrempf@kontron.de>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
In-Reply-To: <20191016150622.21753-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 8E62867A910.AE729
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: davem@davemloft.net, gregkh@linuxfoundation.org,
        jonathan.cameron@huawei.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org,
        paulmck@linux.ibm.com, robh+dt@kernel.org, robh@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Kontron Electronics GmbH produces several ARM boards, that are
planned to be upstreamed eventually. For now we have some
i.MX6UL/ULL based SoMs and boards, that are already available
in the kernel.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..a461d31ee98d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9103,6 +9103,12 @@ F:	include/linux/kmod.h
 F:	lib/test_kmod.c
 F:	tools/testing/selftests/kmod/
 
+KONTRON ELECTRONICS ARM BOARDS SUPPORT
+M:	Frieder Schrempf <frieder.schrempf@kontron.de>
+S:	Maintained
+F:	arch/arm/boot/dts/imx6ul-kontron-*
+F:	arch/arm/boot/dts/imx6ull-kontron-*
+
 KPROBES
 M:	Naveen N. Rao <naveen.n.rao@linux.ibm.com>
 M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
-- 
2.17.1
