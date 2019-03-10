Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ECFC10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53AC52084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 11:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="v8AplEld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfCJLqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 07:46:21 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:18656
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfCJLqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 07:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdev-co-uk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLcly8aeiEBfz3eXDSWmXvR+u4pOZZhfaxBNUdi0Nkw=;
 b=v8AplEldfvKEl6nzeHCvS1vQ0Al5Axj0DUvkuHIwbTdzUtoEbDiSaA4hyupluq7JhBPnwW416SNY8TejL0sLYgO85mjKOW0Q2t3QKWgpQaBptratVJnAwGWSDRbu2dFeabTztR7i2wcL2r0gjFiN+V2fiA+Ch4IAClsRAR8J+Cs=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB4607.eurprd08.prod.outlook.com (20.178.15.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Sun, 10 Mar 2019 11:46:03 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::c129:d694:632f:6574]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::c129:d694:632f:6574%4]) with mapi id 15.20.1686.021; Sun, 10 Mar 2019
 11:46:03 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     "jeffrey.t.kirsher@intel.com" <jeffrey.t.kirsher@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: [PATCH] staging: e1000: e1000_main.c: remove extern declarations in
 .c file.
Thread-Topic: [PATCH] staging: e1000: e1000_main.c: remove extern declarations
 in .c file.
Thread-Index: AQHU1zbWjgls3DuaRUCztx20BEF6Yw==
Date:   Sun, 10 Mar 2019 11:46:03 +0000
Message-ID: <20190310114558.GA23133@jiffies>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB3PR0202CA0027.eurprd02.prod.outlook.com
 (2603:10a6:8:1::40) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.44.76.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af3f2050-4f90-4990-bf55-08d6a54df917
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB4607;
x-ms-traffictypediagnostic: VI1PR08MB4607:
x-microsoft-antispam-prvs: <VI1PR08MB4607C41616346E035331AE19B34F0@VI1PR08MB4607.eurprd08.prod.outlook.com>
x-forefront-prvs: 0972DEC1D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(366004)(39830400003)(396003)(136003)(346002)(189003)(199004)(68736007)(2501003)(2906002)(105586002)(8676002)(106356001)(81156014)(81166006)(110136005)(305945005)(7736002)(26005)(74482002)(316002)(33656002)(3846002)(14454004)(6506007)(386003)(102836004)(14444005)(256004)(52116002)(6116002)(66066001)(25786009)(5660300002)(71190400001)(71200400001)(508600001)(6436002)(6486002)(99286004)(2201001)(186003)(53936002)(44832011)(1076003)(9686003)(6512007)(486006)(476003)(86362001)(33716001)(97736004)(8936002)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4607;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR08MB4607;23:0IIXl2qJJa2O2IY4ZvJY8HnBzfXpXm1a22BI/VeLY?=
 =?us-ascii?Q?bGmzYfK/LxiZZll9sfARwOC5a3hZMaAr5eh6IQaGgS5g82MhasktswztsUx7?=
 =?us-ascii?Q?pdH7liHMHVfQMAqEO2b3xwIfcf5T/kLHPwV/keJYTDwE63Oa6KZ7n/58UwVP?=
 =?us-ascii?Q?vEwH9d9DdfMtTmzjxjFm+5yMt/6vg8FLZNpHqUqTLfxlas4kQ2yfvNVXqy3s?=
 =?us-ascii?Q?z3qfrbamt0yfdfqJm4kIxBfBrEJlYGNicl9IwmPt5cbb0MN3+dbIOGbr40kY?=
 =?us-ascii?Q?jVYPIgwPDo2ui9iR14RyPjHM3pkZ2gg+OkYwQmOqhcYLz6YTrNh0uXtVKN1U?=
 =?us-ascii?Q?tffoGG21M1Rh10kMU2Fnsc84dv+bQDuZcUsAX0XVnxHOyvqO0jtLlfKaFh+k?=
 =?us-ascii?Q?lK0Cg/0yMmVNBkhBMK6z7wwRZjo23Vd3xeITRIQWHBidaKnSoWXBDPEPi9qz?=
 =?us-ascii?Q?eigk2LqdgaXGmIKmbMs3LKKobhjYGl6t5cnQiWlkomMyryrGY6oLVu/NPcgL?=
 =?us-ascii?Q?xpa8sX6kPBWTL+DVmmTq4K6zIVhiY9gokn0BksKCrUA23dUbSDUvfj3twwdk?=
 =?us-ascii?Q?gGFNBEz2x1XhxXDuyQwh+ugRBLo5NNJ/c8vLT4/i8/iRLeefyaYYO9ROUspI?=
 =?us-ascii?Q?a/OVQFFT8OC/fKqmuYpjhJ3J1NWcCCt4JvYoQgnx/67CWJsCYO3Ezwj+WBjA?=
 =?us-ascii?Q?rdPxf3OqQrfXbC4av2Xo0HN3/f7SJEG0/Z7nfmcodshMIGYQlYUBE0+pX2YO?=
 =?us-ascii?Q?gFoHUGpVrFjhvSTG91o0ADo+AFqPyjScqsQD5i8pZo3fYw+udyaYCoodBur+?=
 =?us-ascii?Q?mLmTZJHz/c+n6J44w/IaYq1+RuojyFvT1yk37J8R7OdfZpcjbEMe5axUcuSm?=
 =?us-ascii?Q?0HXNyhTTdwKu7ix/RWvrWavOfeUKYq+3yja2jTpN2mbR6mv6xKk8+w33esiu?=
 =?us-ascii?Q?T4yTwzn4X6GY8BbGTKMjW1Lcxyd9OMCS5zTvWU3aZ/q5q9Ezzj3Aq3rj37eN?=
 =?us-ascii?Q?opVxgYN+xl7Z7dDNwCg9zZoUcpY4U1vQVjr7EfD9a2+jUY/VXgg40tcAy76f?=
 =?us-ascii?Q?nY2XOJrfmNd44XH/q5q2k1Fv4J+yemRGq9vgkk10kKIKLcDRL0oYat5AfQlb?=
 =?us-ascii?Q?60HDhH/LaCghV+D1B3Qsho3Iaq5SuJhYWogUsYkWKyj7wDdyymTEIrUIYhzV?=
 =?us-ascii?Q?xu7f+P7RpT0bxZOx6xfXaI7WMAaZN/yGGrm00m9i/Wlr4wNou3Ib+t2QF+oR?=
 =?us-ascii?Q?5gbPTzd5CMByXQPyZI=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hg6gNLrxlL3ryCccN42clxFafHzsTD6LPnBpKNhCIETPMno829SFL1PbhKxf6P49V+f2ZHGWw772SQ+uPg8fht+WQ78uUYPktnxmpaHBaxJdmhh+1Wu3YaDaGmSuu2uyPIA/e8IXc0GCJFCme5HTNAeqZQ3jVMQD8dypjfeQHUy/uQUSLXuMbGKH8IVGpKAACd05CZr5iroTsgJnHJWgFVe3jl+LJmwHeuLqXl4biBchbbQTOO4fCh8Ze33HJPA7NHFrnsP9++ywmLzX1VRMw3bMQWbngOHn3v3F7Cqxo2GtZ6yBqgs+sSTw3S8WNgpL1RJzDzkeqkHbZjgXzUDBu5vtet81liKf3v9udvbfKnJmW3OYvrC4nFJlcKjUqqRbHnBw+PaFOqUUmGyKd+vb2Pvo7tdwvZavfPWfI8O4O3Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50CD179E2F671344BF1E21C6E0D97DD3@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: af3f2050-4f90-4990-bf55-08d6a54df917
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2019 11:46:03.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: externs should be avoided in .c files

Some of the driver's function declared in e1000.h were declared a second
time in e1000_main.c, triggering checkpatch.pl warnings.

Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/et=
hernet/intel/e1000/e1000_main.c
index 8fe9af0e2ab7..b3d5cd750dca 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -65,14 +65,6 @@ static const struct pci_device_id e1000_pci_tbl[] =3D {
=20
 MODULE_DEVICE_TABLE(pci, e1000_pci_tbl);
=20
-int e1000_up(struct e1000_adapter *adapter);
-void e1000_down(struct e1000_adapter *adapter);
-void e1000_reinit_locked(struct e1000_adapter *adapter);
-void e1000_reset(struct e1000_adapter *adapter);
-int e1000_setup_all_tx_resources(struct e1000_adapter *adapter);
-int e1000_setup_all_rx_resources(struct e1000_adapter *adapter);
-void e1000_free_all_tx_resources(struct e1000_adapter *adapter);
-void e1000_free_all_rx_resources(struct e1000_adapter *adapter);
 static int e1000_setup_tx_resources(struct e1000_adapter *adapter,
 				    struct e1000_tx_ring *txdr);
 static int e1000_setup_rx_resources(struct e1000_adapter *adapter,
@@ -81,7 +73,6 @@ static void e1000_free_tx_resources(struct e1000_adapter =
*adapter,
 				    struct e1000_tx_ring *tx_ring);
 static void e1000_free_rx_resources(struct e1000_adapter *adapter,
 				    struct e1000_rx_ring *rx_ring);
-void e1000_update_stats(struct e1000_adapter *adapter);
=20
 static int e1000_init_module(void);
 static void e1000_exit_module(void);
@@ -89,8 +80,6 @@ static int e1000_probe(struct pci_dev *pdev, const struct=
 pci_device_id *ent);
 static void e1000_remove(struct pci_dev *pdev);
 static int e1000_alloc_queues(struct e1000_adapter *adapter);
 static int e1000_sw_init(struct e1000_adapter *adapter);
-int e1000_open(struct net_device *netdev);
-int e1000_close(struct net_device *netdev);
 static void e1000_configure_tx(struct e1000_adapter *adapter);
 static void e1000_configure_rx(struct e1000_adapter *adapter);
 static void e1000_setup_rctl(struct e1000_adapter *adapter);
--=20
2.20.1

