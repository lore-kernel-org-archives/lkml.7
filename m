Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2114C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979AE20673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="uWwzJJC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFWRim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:38:42 -0400
Received: from mail-eopbgr820058.outbound.protection.outlook.com ([40.107.82.58]:46146
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfFWRim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKNdVwuWPQ6+Ma7r9s1BrMJRxa5BXYVhunKUxWS4WEs=;
 b=uWwzJJC5PHpWskVe/rw98MF4uilVciSHy/tpleLJARBnKpdi2dZpkqZkwTWdpH4IkRqmSOk0BTnM+FVY30wUrQoVg13w3Mg/5LL5xGghFEVdIBReHEXQjxvqlRtQrskS+v2h5UwZlHyh116MIB6EeTspnWrFD1Iyvm5EwuqGUtM=
Received: from BN7PR08MB5684.namprd08.prod.outlook.com (20.176.31.141) by
 BN7PR08MB4241.namprd08.prod.outlook.com (52.133.222.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Sun, 23 Jun 2019 17:38:39 +0000
Received: from BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0]) by BN7PR08MB5684.namprd08.prod.outlook.com
 ([fe80::4dd2:da15:6626:c3b0%3]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 17:38:39 +0000
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
Subject: [PATCH v2 2/3] scsi: ufs-bsg: fix typo in ufs_bsg_request
Thread-Topic: [PATCH v2 2/3] scsi: ufs-bsg: fix typo in ufs_bsg_request
Thread-Index: AdUp6T3Xt41XLu9MQdqAaZ+DpHy+6Q==
Date:   Sun, 23 Jun 2019 17:38:39 +0000
Message-ID: <BN7PR08MB56845341A1F184196F0D5C4FDBE10@BN7PR08MB5684.namprd08.prod.outlook.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac89d705-d23d-4912-982a-08d6f801a083
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN7PR08MB4241;
x-ms-traffictypediagnostic: BN7PR08MB4241:|BN7PR08MB4241:
x-microsoft-antispam-prvs: <BN7PR08MB42414946CEB3BFBEB134AC0CDBE10@BN7PR08MB4241.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(136003)(396003)(366004)(189003)(199004)(2906002)(52536014)(110136005)(71190400001)(26005)(102836004)(6506007)(74316002)(55236004)(14444005)(186003)(256004)(476003)(4326008)(4744005)(73956011)(316002)(71200400001)(486006)(81156014)(14454004)(66066001)(66946007)(81166006)(305945005)(7736002)(66476007)(5660300002)(8676002)(66446008)(66556008)(64756008)(54906003)(9686003)(478600001)(76116006)(86362001)(6436002)(68736007)(7696005)(53936002)(55016002)(33656002)(25786009)(8936002)(3846002)(6116002)(107886003)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR08MB4241;H:BN7PR08MB5684.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yq/vxWlHQv0Yu4q99EhvczRmkm3rWqoMTU6+uAXexUCK+zkGehHaeWttc2Y1gKzrH4nHSmH2rk3r99E2Sl6GfH/8sb8lYHANqWxKTg8wPJW2XQYi8UH3gsDVTLbYKz6A8vRDixtLyQA6maOAi6KdG2wNEtSj/x6yBg+g1qCcrLt8YpIAtBHi6q+g3bfzQxl2VAqpBbvSryqczEKalckJH4x+FqphLKKsolIOYa35UYBwdsOXagZhCrNS2pd9GKxydKh0Jy0jJLElkLI34Duqb5uFlkfog8RKEtwoBugCKG/a3Qmp9e0DAHgrVQTZfSH0UTR7nsygZGpKTTW9BvhKoYkbrYVzkCc1dNeKSYMuIP7bbEKq1QNyQKCUYyOBnk7hsTv8Ph87/9moUG8RBaw+yYgxppbm9sIQMhJotaIIzos=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac89d705-d23d-4912-982a-08d6f801a083
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 17:38:39.0168
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

Correct dev_dbg to dev_err, so as to print out the error
information in case of DME command failed.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufs_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs_bsg.c b/drivers/scsi/ufs/ufs_bsg.c
index 869e71f861d6..f420d6f8d84c 100644
--- a/drivers/scsi/ufs/ufs_bsg.c
+++ b/drivers/scsi/ufs/ufs_bsg.c
@@ -122,7 +122,7 @@ static int ufs_bsg_request(struct bsg_job *job)
 		memcpy(&uc, &bsg_request->upiu_req.uc, UIC_CMD_SIZE);
 		ret =3D ufshcd_send_uic_cmd(hba, &uc);
 		if (ret)
-			dev_dbg(hba->dev,
+			dev_err(hba->dev,
 				"send uic cmd: error code %d\n", ret);
=20
 		memcpy(&bsg_reply->upiu_rsp.uc, &uc, UIC_CMD_SIZE);
--=20
2.7.4
