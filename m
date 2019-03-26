Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4162C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50A720811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=itdevltd.onmicrosoft.com header.i=@itdevltd.onmicrosoft.com header.b="G3WyGf7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbfCZVj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:39:26 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:58018
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732052AbfCZVj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=itdevltd.onmicrosoft.com; s=selector1-itdev-co-uk;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybFiKXU9a0nXMp7X2fwn/4JxmQr/S5rUsP1hqU17Ldg=;
 b=G3WyGf7KsbKvrUuKEMHoEPP6b7oNnWS2H5QBsAjWVklCPLbRjr87Tup0x7qveLShjoXebYxGJhNXQDNwviPPieH9zxVshGnmvElXU7BqGAuv/oCe6B9caBstvtEShq9NWDVJ2ynXv/i5LVMDut1eQS9+4FBbk0jzTMLHLyXISjg=
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com (52.133.15.143) by
 VI1PR08MB4030.eurprd08.prod.outlook.com (20.178.126.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 26 Mar 2019 21:39:22 +0000
Received: from VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::c129:d694:632f:6574]) by VI1PR08MB3168.eurprd08.prod.outlook.com
 ([fe80::c129:d694:632f:6574%4]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 21:39:21 +0000
From:   Quentin Deslandes <quentin.deslandes@itdev.co.uk>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] e1000: remove extern declarations in .c file.
Thread-Topic: [PATCH v2] e1000: remove extern declarations in .c file.
Thread-Index: AQHU5Bxf+UI7qz3A8ECJ00KpEp9pLQ==
Date:   Tue, 26 Mar 2019 21:39:21 +0000
Message-ID: <20190326213917.GA24133@jiffies>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0337.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::13) To VI1PR08MB3168.eurprd08.prod.outlook.com
 (2603:10a6:803:47::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=quentin.deslandes@itdev.co.uk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.44.76.118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cee8adf-4a12-423a-e4bd-08d6b2338229
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB4030;
x-ms-traffictypediagnostic: VI1PR08MB4030:
x-microsoft-antispam-prvs: <VI1PR08MB4030C7675ACB85DFAC8F1632B35F0@VI1PR08MB4030.eurprd08.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(366004)(39830400003)(376002)(346002)(136003)(396003)(199004)(189003)(2906002)(2501003)(81166006)(68736007)(81156014)(6486002)(9686003)(508600001)(1076003)(8676002)(74482002)(6512007)(33716001)(105586002)(25786009)(8936002)(33656002)(106356001)(97736004)(66066001)(305945005)(7736002)(386003)(256004)(6436002)(6506007)(110136005)(99286004)(14444005)(316002)(6116002)(52116002)(44832011)(476003)(486006)(186003)(53936002)(26005)(3846002)(5660300002)(14454004)(2201001)(71200400001)(86362001)(102836004)(71190400001)(142923001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4030;H:VI1PR08MB3168.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: itdev.co.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +38UlUQswOLNrmwI+nVl84KKHoY+kGP4WCwUAzJ6BfQHiJJRkbQlYqBj7xKEzV3ZU7/Wq0N3KGapqjKbtvz2WKLXumHlcL1uF2lLtrbY/deqRN11aSOV7cSyvbyx08F3oKYetUmyUN8M9PRMvL2LdfzUEDQ7XHXFBlWQVRwFp/s08HEdK5xfFMyf52FLDkPE28ObvyhJL6QbEvb2YM1D/ig77j4goZMkVW6/WY5z9PN9a1gKITnTVN7zG6lcq9v5IkgUk0UMO+lDcyrHj0VOXYB2KbetSzRMw71fYd3SybR2Rq9xf90NvreT1TW/lVqafvUUbz2HVLyDHpWpGLaf4F6obAtmWMeQuRVLO0EifPBPBb9tbkeMOiB0bFSsjQEjk+UlkrD8ytTpySxKP39htGIAL1ZNzXo8M+wlyTwLs9c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46627C6A656D4446A676F17BA05E588E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: itdev.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cee8adf-4a12-423a-e4bd-08d6b2338229
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 21:39:21.7854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2d2930c4-2251-45b4-ad79-3582c5f41740
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:

WARNING: externs should be avoided in .c files

Some of the driver's function declared in e1000.h were declared a second
time in e1000_main.c, triggering checkpatch.pl warnings.

This patch is v2 as the first one had the wrong subject.

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

