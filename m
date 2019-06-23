Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50800C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1658720673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="kHUEMOx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFWRiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:38:00 -0400
Received: from mail-eopbgr800071.outbound.protection.outlook.com ([40.107.80.71]:39424
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726466AbfFWRh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sU//ICQyKsXNwhNLqzUnO1yFVB4bPMOQrqsE5/jFOJk=;
 b=kHUEMOx6wTAjZeG4gbW7IJfcXopCMtFbLzHMnvVENHgx7syyARpJIr+JYrRgQMG6yHAdN3lye9OHks9y6edZRHklaMdY4xA9uN+p3rJxuhOH/G9nPJz2tpcRJWeOGykKpWffrYYo2bKs++jiIyX3FlZbmVXZpzyKoBcv2dloVr0=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.31.141) by
 BN7PR08MB4241.namprd08.prod.outlook.com (52.133.222.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Sun, 23 Jun 2019 17:37:56 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0%3]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 17:37:56 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Evan Green <evgreen@chromium.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: [PATCH v2 0/3] scsi: ufs: typo fixes and improvement
Thread-Topic: [PATCH v2 0/3] scsi: ufs: typo fixes and improvement
Thread-Index: AdUp6BAI7ZILf7ZTT5ms/BIKCU7S/A==
Date:   Sun, 23 Jun 2019 17:37:56 +0000
Message-ID: <BN7PR08MB5684A44F56972BCE0972B28EDBE10@BN7PR08MB5684.namprd08.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70cd04bc-5ab1-433e-759b-08d6f801870e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR08MB4241;
x-ms-traffictypediagnostic: BN7PR08MB4241:|BN7PR08MB4241:
x-microsoft-antispam-prvs: <BN7PR08MB4241AFC333E62658383985FADBE10@BN7PR08MB4241.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(2906002)(52536014)(110136005)(71190400001)(26005)(102836004)(6506007)(74316002)(55236004)(14444005)(186003)(256004)(476003)(4326008)(4744005)(73956011)(316002)(71200400001)(486006)(81156014)(14454004)(66066001)(66946007)(81166006)(305945005)(7736002)(66476007)(5660300002)(8676002)(66446008)(66556008)(64756008)(54906003)(9686003)(478600001)(76116006)(86362001)(6436002)(68736007)(7696005)(53936002)(55016002)(33656002)(25786009)(8936002)(3846002)(6116002)(107886003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4241;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eoMLmnHGPnqwly1Ish1OP0Oj77JwuIKLQGn66g8Ryg04toDY1b8qppdZrZXN9TDNOxiuUT6xZ4cILh8Dim6ijofXK9wHYziF6bEQUn7VFdoSy9v9ifva8GpqytJaN3P3gbF0mMEyw2qDlnREAT70LEUKipoDQ4TjjFeLckZnmxRDsh7tJKhZ8Q/P+KRefdz4ZI/istZuZ3jlrIhpIGjcmto/FKxuBTstjL5hqytLoNF5OIWKExTT2Ef086dOcHG3y+yJM6S/NUPh1P+fYfsxeSXPSn0T6h0vWOPtizmeZwvWvQJP74knYTsEXd/gksE/9a+bZfini6nZx3jtfuNt9hnQOs6SovN+Id8AxpUEmRFTu415DCGCZQ6/+/UnJOIqFCO32JchbhP1Je0niEA3v2BGnnQImMkaH4jY5cdddAI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cd04bc-5ab1-433e-759b-08d6f801870e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 17:37:56.1692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: beanhuo@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR08MB4241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Bean Huo <beanhuo@micron.com>

This series patch is to fix several typos and fix one issue of twice
completing ufs-bsg job in case of UPIU/DME command failed.

Changed since v1:
    - split v1 patch
    - add fixes tag
    - delete needless blank line

Bean Huo (3):
  scsi: ufs: fix typos in comment of ufshcd_uic_change_pwr_mode
  scsi: ufs-bsg: fix typo in ufs_bsg_request
  scsi: ufs-bsg: complete ufs-bsg job only if no error

 drivers/scsi/ufs/ufs_bsg.c | 6 ++++--
 drivers/scsi/ufs/ufshcd.c  | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--=20
2.7.4
