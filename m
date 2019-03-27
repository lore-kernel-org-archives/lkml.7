Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C482BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962A22075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="nT56dxYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbfC0KFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:05:37 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:62848
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731664AbfC0KFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdev-co-uk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jRRI6wC9SiqhP5zS9zFObVPiKDeZKIE9aqGAA+i3dE=;
 b=nT56dxYrGQ1dfjG8sSZQapIOY+g4Go/8QhZcpAYTNpqf591XgRCJwNWQOttLAw/Cr3Wc/oBFbrGH2iTKi4DtslSEffk4ZTa4wCMZUFyd3DkZbo+tb9T5zmP/LbdjBcK2rgeex1Dv45ieUP5EO55Nx4q15mRYa05RU/Lr3aZ39wE=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB4126.eurprd08.prod.outlook.com (20.178.204.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 10:05:30 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::c129:d694:632f:6574]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::c129:d694:632f:6574%4]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 10:05:30 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: [PATCH v3] e1000: remove extern declarations in .c file.
Thread-Topic: [PATCH v3] e1000: remove extern declarations in .c file.
Thread-Index: AQHU5IScXmpFVNQCBkqFzMSYAMfGpA==
Date:   Wed, 27 Mar 2019 10:05:30 +0000
Message-ID: <20190327100526.GA954@qd-ubuntu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P194CA0029.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:90::42) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.21.227.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 285b2c9a-b32e-449f-ff72-08d6b29bbe63
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600127)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB4126;
x-ms-traffictypediagnostic: VI1PR08MB4126:
x-microsoft-antispam-prvs: <VI1PR08MB41269E6160D7AE8A5123482DB3580@VI1PR08MB4126.eurprd08.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(376002)(346002)(366004)(39830400003)(136003)(189003)(199004)(2906002)(25786009)(33716001)(6506007)(14454004)(386003)(102836004)(26005)(508600001)(110136005)(52116002)(99286004)(316002)(33656002)(486006)(44832011)(476003)(2501003)(14444005)(106356001)(1076003)(86362001)(105586002)(5660300002)(186003)(66066001)(6436002)(256004)(7736002)(6486002)(305945005)(81156014)(8676002)(74482002)(2201001)(9686003)(71190400001)(6512007)(53936002)(8936002)(3846002)(71200400001)(81166006)(97736004)(6116002)(68736007)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4126;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Cvm6YclhAPQuKsog0LsFyKsRh9lJq+64wArg3ccue5fdoVddsTvSQ+OSwF19OzY8FMQhzdYE2Qg8/4pTJoIVcUvJKaFGE7ko3qFiDf5t6Al8ftUBQ0KCY9tsRScjhxhWAd1FmeUTsWPDnZIX8OCVXFnExV27e3D6Gk4kXyM2tmiQzRY/Iu2qxKhkcxGxNhl8p9Q+L/wQBZCD8G4oT4lePsx6Tbm87JlOMPYoXexzY37yMJho1zPQhfAcQEWI71yOd5r9YuJVhEMiQGcZLiuJG4ieeShGEk/oaP7UIi14YH+992rwpT8gIxIijoIFJk1RjvYORIXEFfMuYNBVDAlxxW98Wz5cQd8OJ0jzg5nlfzJhiS0tQXiQ/i0Pdx8NtWqEHBN7xGUadQ4csvMYrPuXuVAAo2PiZ7UVJxF+C7EYv6A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <450E91ECDF26C344BC5318305E418E3C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 285b2c9a-b32e-449f-ff72-08d6b29bbe63
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 10:05:30.5684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch.pl warning:

WARNING: externs should be avoided in .c files

Some of the driver's function declared in e1000.h were declared a second
time in e1000_main.c, triggering checkpatch.pl warnings.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Quentin Deslandes <quentin.deslandes@itdev.co.uk>
---
 v2: Fix mail subject.
 v3: Remove patch version details from patch.
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
2.17.1

