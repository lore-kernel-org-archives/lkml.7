Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00164C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1CBC2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="E50hhW0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbfB1KbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:31:02 -0500
Received: from mail-eopbgr80119.outbound.protection.outlook.com ([40.107.8.119]:56544
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727666AbfB1KbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O26vb5004hodE99XrNgnzOTz1Zi0p1QM1cOLNqsUT9k=;
 b=E50hhW0HMDGcRr+J9PEmKtUexKZtsiZjeb+O/sqk/YGTpwk1oKd0ULsQfRja3SZW+2K4pNG1qk31uVmyeoevxsmGKR/F5YrG0il0F4S6QOrc+wfrI+sHGJrpyw7je4LM1KUbUBsut4OYlzU3bREtH2Yx1NHlkmIiei8hL12DwuM=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM (10.167.201.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Thu, 28 Feb 2019 10:30:40 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d49:d85b:58bf:cd5b%6]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 10:30:40 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     Scott Wood <oss@buserror.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@freescale.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
Subject: [PATCH 1/4] soc/fsl/qe: qe.c: drop useless static qualifier
Thread-Topic: [PATCH 1/4] soc/fsl/qe: qe.c: drop useless static qualifier
Thread-Index: AQHUz1CmMqAdaREcZEKCvGiAOZA3Tw==
Date:   Thu, 28 Feb 2019 10:30:40 +0000
Message-ID: <20190228103026.9566-2-rasmus.villemoes@prevas.dk>
References: <338677b2-ef74-2afc-4542-c66f1acdb7e5@prevas.dk>
 <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20190228103026.9566-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:7:28::14) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.20.1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff822ff6-108a-4fa5-bdb8-08d69d67c92f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0509;
x-ms-traffictypediagnostic: VI1PR10MB0509:
x-microsoft-antispam-prvs: <VI1PR10MB0509230F2B852A0B58F3B2228A750@VI1PR10MB0509.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39850400004)(376002)(366004)(346002)(396003)(189003)(199004)(476003)(446003)(11346002)(2616005)(8936002)(44832011)(8976002)(106356001)(42882007)(486006)(68736007)(186003)(50226002)(107886003)(105586002)(54906003)(74482002)(4744005)(110136005)(316002)(5660300002)(97736004)(1076003)(72206003)(2906002)(52116002)(71190400001)(6486002)(305945005)(478600001)(256004)(71200400001)(53936002)(14444005)(99286004)(6436002)(66066001)(6512007)(6116002)(81156014)(81166006)(102836004)(4326008)(25786009)(6506007)(386003)(26005)(76176011)(7736002)(36756003)(8676002)(14454004)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB0509;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR10MB0509;23:3lHSN37oJdr+IYGJNsxRDHi7EHj3qMTAkkhJ5RK?=
 =?iso-8859-1?Q?MUW6Sb2A2BK6Df69IDhcQtqxgFDJKpf1fwXdZewY5nIcWCTwA6IsM0AjUt?=
 =?iso-8859-1?Q?4iU3XclvT9IkN20lAmABJGWxdErcJUoZi70TeSLq0L3AQTv2lVCg8H4eNz?=
 =?iso-8859-1?Q?ZMu3oDJTn5YHmWpXRA1tgKy3Ve2EpUBqVAuAk1yOn78yZPJBsTzQ0jE4W0?=
 =?iso-8859-1?Q?E4qndhN6nauTvQy09aFywKTbQWb6F/qqo7Qz+TWZkbs71xOWrrg7pPEBep?=
 =?iso-8859-1?Q?UffEhdKtJeoAT9bewhAFSfQy0OnOFo30Rh0qQRt52mxn+X7cxjfR4Oet/g?=
 =?iso-8859-1?Q?fzJfEo28hmfcseeU930V+qTG3L1d4JJY1Yhmmi9w2AIFe0MFgBq/tL2mGd?=
 =?iso-8859-1?Q?zTgavudthjPk+CaHwNPbH9btgawzcMGAnRlgHVLVKCWzBMrMDVXzsxOF0p?=
 =?iso-8859-1?Q?vYV0OP69JmTbwP5AGFbExBcq2SzhqxXDuOO+hY5nZhuzaVEwh7qydjbvrv?=
 =?iso-8859-1?Q?651NCqhIzFCeASZvXqfu66j2eUybhkwOHHr7DIUz7o+miYjFYw5Hc0kTvd?=
 =?iso-8859-1?Q?9mHVq6Ypuo25H5nozAcurTIAFXU5V3FFDAcWUhYpn3rUC5I4Jj7bVXQhUX?=
 =?iso-8859-1?Q?+jK7lsmaJHuUAIPoXKLV3yZvBIYZIJKtWoSNgUkUOsRGP+gZ3pj0Bsfthl?=
 =?iso-8859-1?Q?0p3DaKh1xD3nuZ87XznTBsiiqLJ099V+xIzohPBuW3x0j5t0Zin3PNUYzp?=
 =?iso-8859-1?Q?2/sPrcx9vw49xB9aWAXU7gUDye6snX84UDM+QzvwhKiPg3t1OG8Cy+/wqe?=
 =?iso-8859-1?Q?MhtYkLD35hQu29UpxOgJ03DkthT6N8a3sZ0/Z81qGdptNfVSE7UMqmFhFA?=
 =?iso-8859-1?Q?gbG9DskKMAwUqNgAcWI1bvXZ3wmS3hi+4kdtBcorlfVF5gTDxPaSXFz5ns?=
 =?iso-8859-1?Q?SwIxf7IIcbZc6ZliKhwJHEO4rmjajHCDZtZQbEn73SBfZGpfMpFScQAiQs?=
 =?iso-8859-1?Q?sM0AdCVRj/EiONU1Oh95/xVpMdYRdsv+YrVstClXCHi1dqIJeR8Ky7tXYa?=
 =?iso-8859-1?Q?/Y1aKfbDDBE3k68vO8VCkaEnYGj/E3FoSxOo3mFcFKgiKC4fUMKLyPaIt0?=
 =?iso-8859-1?Q?ntTX0o8vnpPWn6U90h8pTCHjzp1s1tLwbpOst+TIbjXDakmdS5xt4ebV4r?=
 =?iso-8859-1?Q?wpSI2yMmYUH1C4MGQDiYa7lrig1psrLuQj0vuu7E7LZgqrFL8t78rvoSZW?=
 =?iso-8859-1?Q?MhSLrOXKFSP/t40BcGDJpiUMlF+7AEnshtZCr4H74FEa6MqZrYrJp+foFg?=
 =?iso-8859-1?Q?xyoIxBh4MiI2rRhxVvKXPQp52/lMTHmBTD5/5vJM6aDGZrx8NtLm70B+Qe?=
 =?iso-8859-1?Q?EaSC5Y4OmCuIMy5UOF9aSlWufZfwfBYkw24xxI86pSLrpluGvjA=3D=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +ZsYl1LlwS1i75aVNqq69EOzdYX5fijwKwMp+MJe4nneDDCj1kCc/uLxvzxtXwoJjxcynb27zg1XVWuSKDiW5ZFmOFYPeoxprHUZEIcQID0CAPnHetglJeDRrf6oaqpt2clpyD0lySQPkq8n3HMEIKMvP/vrUp3SzZXdLsrfc4EokqSVnYOI6UsZXgt4EsapAZQ9psOmA7Ok6LBzPR0+jQc+0G+YvEwVAS6IK46ib8O07XSeRKHZceDD/P9JYqJsDzCkY9tKVBgLSzfJM9CoBMWltnLDAATgeOB8S5HHOX3cz6HtXrVsNRQKlZ7pD5vb6aMjeWMxV/PE4W+nslyWAtIqOh6MilLtBeJMorH/biBoVzd+A+843PzRCL2+6h1gT+o0jAT342NHVeuGKOMehdfJ+6bTF+dXSq5W3wKR9ho=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ff822ff6-108a-4fa5-bdb8-08d69d67c92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 10:30:39.6611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0509
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable snum_init has no reason to have static storage duration.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/soc/fsl/qe/qe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 2ef6fc6487c1..4b6aa6b3b685 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -306,7 +306,7 @@ static void qe_snums_init(void)
 		0x28, 0x29, 0x38, 0x39, 0x48, 0x49, 0x58, 0x59,
 		0x68, 0x69, 0x78, 0x79, 0x80, 0x81,
 	};
-	static const u8 *snum_init;
+	const u8 *snum_init;
=20
 	qe_num_of_snum =3D qe_get_num_of_snums();
=20
--=20
2.20.1

