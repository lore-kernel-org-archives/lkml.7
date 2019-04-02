Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54808C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2166B207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GACUknFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfDBJnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:43:39 -0400
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:5347
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbfDBJng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSRc8Pz01JTPpJmtk7tlkeDqW/6QOxKjXGKZ74ohUJA=;
 b=GACUknFWcUCH1jn2Mi+yqltqXA2Hp5PrwNZLsXqAXrPEq4aZW93FePvLz3mx81anIHojJVeE401a+3YEMjTfATmxlvtuVmJXBJq2FGRD2NdiRgrk2jpmIgvXvmP0SveeE4tZwbGe2fF8yjW8oa8TanWQQWgRnJyObH9eXZCbUq8=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5025.eurprd04.prod.outlook.com (20.177.40.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Tue, 2 Apr 2019 09:43:32 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::dc63:432c:eb4b:8d1b]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::dc63:432c:eb4b:8d1b%3]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 09:43:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "ldr709@gmail.com" <ldr709@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] mm: __pagevec_lru_add_fn: typo fix
Thread-Topic: [PATCH] mm: __pagevec_lru_add_fn: typo fix
Thread-Index: AQHU6TiIf+7xhVfRzkCOK8uLgCZGpg==
Date:   Tue, 2 Apr 2019 09:43:31 +0000
Message-ID: <20190402095609.27181-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62143116-25cf-4378-034a-08d6b74faab5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5025;
x-ms-traffictypediagnostic: AM0PR04MB5025:
x-microsoft-antispam-prvs: <AM0PR04MB5025483FBC0703739628644D88560@AM0PR04MB5025.eurprd04.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(6506007)(4326008)(5660300002)(386003)(68736007)(97736004)(305945005)(476003)(2616005)(2906002)(6486002)(6436002)(66066001)(36756003)(52116002)(486006)(186003)(1076003)(50226002)(54906003)(4744005)(81166006)(81156014)(102836004)(2201001)(25786009)(26005)(8936002)(53936002)(8676002)(6512007)(7416002)(86362001)(316002)(7736002)(99286004)(110136005)(478600001)(44832011)(3846002)(71200400001)(6116002)(71190400001)(14444005)(256004)(2501003)(14454004)(106356001)(105586002)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5025;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ju8rl2HiFR/HiZ9ZKQ66ceMXBrUhEoeaffPLFOw9eXxGEyDzleHCSY0w83zUeUZoEaJ1BrsKdioeU8QkOJd++uKY/XmhnxGvN1uUKBaffdRnN14LwW7cd1WwkIzKFQZ7HROAmQcVMSpPaEdYZQGHOYqu56Q4/mrsiwHI88c/68/vy8Fz6O7hueCJaLj8PMdfTdpdl9Rn6+P/mXQjTyRswFB8wmbXBd0QB59oUW5/JUkjUtnfes4fW6CyH+CeytgZ1A6LHdFfST/Js7Jj6cDs09TGYPLx/eYO5qJJ4HL3aKLM6+T3Vl+/f6I7PtsSpOH0HYboRNjoyYLwgrCgF7uY5KW9Ydv2afTR5HSjtC5pl7pZfq+LXwLIBsdIUdkHi1PEjZ7AzKsTNlQrznB7Egx9jqXegIF5XwHTGTdktl+oHBk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62143116-25cf-4378-034a-08d6b74faab5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 09:43:32.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no function named munlock_vma_pages, correct it to
munlock_vma_page.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 301ed4e04320..3a75722e68a9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -867,7 +867,7 @@ static void __pagevec_lru_add_fn(struct page *page, str=
uct lruvec *lruvec,
 	SetPageLRU(page);
 	/*
 	 * Page becomes evictable in two ways:
-	 * 1) Within LRU lock [munlock_vma_pages() and __munlock_pagevec()].
+	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
 	 * 2) Before acquiring LRU lock to put the page to correct LRU and then
 	 *   a) do PageLRU check with lock [check_move_unevictable_pages]
 	 *   b) do PageLRU check before lock [clear_page_mlock]
--=20
2.16.4

