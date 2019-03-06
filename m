Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B794C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6A220663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="vvCUg/Ck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCFXQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:16:16 -0500
Received: from mail-eopbgr80112.outbound.protection.outlook.com ([40.107.8.112]:32096
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726094AbfCFXQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mx/ZUJJcV5bKpqYM0JorZEm8e/d3rIsWW11+6NuiM/8=;
 b=vvCUg/CkI/i9ur8NNftnr5E3mW3u3B/tpNsxMMD7KCeiJ3DvPyje7NXGqE8OhHtt7NASvPcQSO5Wp2In9dwqknH2/vFnQetzbHC+LJGFjkp0gCD5SwEsoXp2JIgP8zKRn2fGfgsrQGtKq3uaAMkRBF6quqBVXC1bBCl0l5o6N+w=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4592.eurprd02.prod.outlook.com (20.178.12.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 23:15:40 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 23:15:40 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ken Chen <chen.kenyy@inventec.com>,
        Pradeep Srinivasan <pradeeps@cumulusnetworks.com>
Subject: [PATCH v2 2/5] i2c: mux: pca9541: namespace cleanup
Thread-Topic: [PATCH v2 2/5] i2c: mux: pca9541: namespace cleanup
Thread-Index: AQHU1HKDiruWDOCBzkKteDPj/UtePQ==
Date:   Wed, 6 Mar 2019 23:15:40 +0000
Message-ID: <20190306231521.29367-3-peda@axentia.se>
References: <20190306231521.29367-1-peda@axentia.se>
In-Reply-To: <20190306231521.29367-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR1001CA0016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::26) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39f46349-1ec2-451d-8bde-08d6a289a64e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB4592;
x-ms-traffictypediagnostic: VI1PR02MB4592:
x-microsoft-antispam-prvs: <VI1PR02MB4592E3446F1165543E3883BBBC730@VI1PR02MB4592.eurprd02.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39830400003)(396003)(366004)(346002)(136003)(189003)(199004)(5640700003)(53936002)(6486002)(71200400001)(6436002)(2501003)(71190400001)(99286004)(4326008)(6916009)(476003)(102836004)(76176011)(256004)(446003)(486006)(52116002)(3846002)(86362001)(386003)(74482002)(6506007)(6512007)(26005)(6116002)(97736004)(66066001)(305945005)(7736002)(2351001)(186003)(2616005)(14444005)(11346002)(25786009)(106356001)(36756003)(8936002)(8676002)(68736007)(81156014)(81166006)(5660300002)(508600001)(2906002)(54906003)(1076003)(50226002)(316002)(14454004)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4592;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR02MB4592;23:BEt8TLa4cKrfuvPp+aUxLsPci9fc5nBH7I+doM/?=
 =?iso-8859-1?Q?O4Bw7+RAg49873Z/5ujmaqMMgWT2rGwr352EWz3jI30Ix9GeEHEWuzXM/i?=
 =?iso-8859-1?Q?5qNTG8EElUJXpvGq+IWVfGpZ/Z4GLjkidbiOmpf3jgSo/mmDsKa1nAX5gV?=
 =?iso-8859-1?Q?W9/Hh8PKb0+cQ74werlbctKuXalmDwz+O5OTnWI5UFEgn/eE8Pqwad8L0H?=
 =?iso-8859-1?Q?+/8Fe5SS9tQ07brVfLeaPXso+aSA8HRdmKdm5wol03CHR4YQa8ZApQu3PG?=
 =?iso-8859-1?Q?6PdUWgTNyOSvFQYXbX3OTPYBA+lyTimy++QPi/i7Y5nyRulUFpxG/Dk1bG?=
 =?iso-8859-1?Q?p4AJUrw/okuRw9sOMdJbLnx2SeumkW6k8LRdPO72fcQrt+R3lL6ZXpv5d6?=
 =?iso-8859-1?Q?9I7Y5UuNtm954nxAbIOYp397BRJT159znZ75LX93u89iC5wXjtbUlCqFiy?=
 =?iso-8859-1?Q?Iwk+TivblYQtS7tFnijMxU5pTdfwN80q9YJfD8KghBk5bORC+gLK+K1x8k?=
 =?iso-8859-1?Q?vxPajSQNgUfs4Roorpeiq6F+kx/1kRSQtHSdf5BaVylhC0nzUOHYz+5sGh?=
 =?iso-8859-1?Q?8MMcUxIaC4wKH60VrR8T/cn8erDB8yu2FAx1dZ0sPQntgvezB+7hF3hi7f?=
 =?iso-8859-1?Q?wznR0hzB/RvHAB9WaUxQbNPChQe7Udtv2I8ZIFDbwxoLKfX5M3NVwCqanp?=
 =?iso-8859-1?Q?crvj8Q8QktgmlB0BxFeNNemJGBwJ/W77YvZa8i9FXKloI7IkPJLMW5eKso?=
 =?iso-8859-1?Q?NJPi1hD4yeFGrsrCal3aW4z9oLnlD9gYNUJ40gfFlh6lNfTEq9VE2lF3Ol?=
 =?iso-8859-1?Q?mGvpZJNcLQtHjkGwIMB15ULahfolejDmmSmS2UJ6IDIGHszsiQblamaWsL?=
 =?iso-8859-1?Q?DFIq0UovVLyE2skYwlkWb7mjylqjlfcXTrPxnfz4NN7qiZcCFUcNQRjHZ8?=
 =?iso-8859-1?Q?HrrgDDci7r7PJ8eugFJdI/po6v78I4PPnL1LfTLoWyZN4LyyyFJrJfslt8?=
 =?iso-8859-1?Q?5qAMESmwqkZHfh9xBX2qnBGaIUM6pkChInUJKgmBZ9GKRVRZxc9gjlqdcc?=
 =?iso-8859-1?Q?mFMPDFZU9lgDFMLK48vhjvBbfuy9qZb3XBYRmf20cTaQvgihNk4Ti4lET0?=
 =?iso-8859-1?Q?lc7AP5eoliHrezRvV8JlJ+n1bylHp7+HR3qFweuXlORlp7Hf3ewc/DJvOV?=
 =?iso-8859-1?Q?o5H0YVAAaCd84dmnzlp3su95N5ihYBFr9Blrn7PrW66MS1ZbdDDcspHuGB?=
 =?iso-8859-1?Q?FhBKptBcQ5kEmudS3QI1z1/Dkhy/NvHD3cZSIcULhCkttuTq7jeePxSAb4?=
 =?iso-8859-1?Q?n0VaBgCAJ4BJ0JyeBsNfUx7lc5qv9MTaLRhPfK3qmjIcmN6s7F1Ccy6+pu?=
 =?iso-8859-1?Q?fCgExx6I=3D?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7ZE/AuvOggjpSME/jfWd1szh4aeKqYHv+cpL1Peg/Tuc6UuwJQM88KiZn0c6kYYPJrhJxslalw5k87Yw01NUS9OcYcxW3y1hWfU0kIqEdx+fvXAeDn+som5AyyWLB4Sb2E7Bv7z+ZrJPzUNi8cAiP0cvAeWzVo78FJagW73UetlHNlHcp2DFvcigpmKcrOUCQnldWCGOnAsNuoB8syIPxXFb3rV+ruPcdnIxldtrUrMIHRk8vSiRXdTJWSk7VBQfrZEiegdaP3Be8BU085tSVIJ5RX2PTIDw3UerGrMMSAAIozU12NGZhF4jAEOujUmm455RQaj1gWZ0Xa2N6qaFSpVm7JxTW6PeyPiUJbd85Dth1eH5R1Kku3Hi/ZBkUVJipWW+pvU4K0C14o75QBQNKowiWqeNrObwyalKY2OvTr0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f46349-1ec2-451d-8bde-08d6a289a64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 23:15:40.5379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4592
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for PCA9641 support, convert the mybus and busoff macros
to functions, and in the process prefix them with pca9541_. Also prefix
remaining chip specific macros with PCA9541_.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mu=
x-pca9541.c
index 30cabf482985..28f46450f4b4 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -59,10 +59,8 @@
 #define PCA9541_ISTAT_MYTEST	BIT(6)
 #define PCA9541_ISTAT_NMYTEST	BIT(7)
=20
-#define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
-#define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
-#define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) =3D=3D MYBUS)
-#define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) =3D=3D BUSON)
+#define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
+#define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
=20
 /* arbitration timeouts, in jiffies */
 #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
@@ -93,6 +91,20 @@ static const struct of_device_id pca9541_of_match[] =3D =
{
 MODULE_DEVICE_TABLE(of, pca9541_of_match);
 #endif
=20
+static bool pca9541_mybus(int ctl)
+{
+	if (!(ctl & PCA9541_MYBUS))
+		return true;
+	return (ctl & PCA9541_MYBUS) =3D=3D PCA9541_MYBUS;
+}
+
+static bool pca9541_busoff(int ctl)
+{
+	if (!(ctl & PCA9541_BUSON))
+		return true;
+	return (ctl & PCA9541_BUSON) =3D=3D PCA9541_BUSON;
+}
+
 /*
  * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
  * as they will try to lock the adapter a second time.
@@ -134,7 +146,7 @@ static void pca9541_release_bus(struct i2c_client *clie=
nt)
 	int reg;
=20
 	reg =3D pca9541_reg_read(client, PCA9541_CONTROL);
-	if (reg >=3D 0 && !busoff(reg) && mybus(reg))
+	if (reg >=3D 0 && !pca9541_busoff(reg) && pca9541_mybus(reg))
 		pca9541_reg_write(client, PCA9541_CONTROL,
 				  (reg & PCA9541_CTL_NBUSON) >> 1);
 }
@@ -186,7 +198,7 @@ static int pca9541_arbitrate(struct i2c_client *client)
 	if (reg < 0)
 		return reg;
=20
-	if (busoff(reg)) {
+	if (pca9541_busoff(reg)) {
 		int istat;
 		/*
 		 * Bus is off. Request ownership or turn it on unless
@@ -211,7 +223,7 @@ static int pca9541_arbitrate(struct i2c_client *client)
 			 */
 			data->select_timeout =3D SELECT_DELAY_LONG * 2;
 		}
-	} else if (mybus(reg)) {
+	} else if (pca9541_mybus(reg)) {
 		/*
 		 * Bus is on, and we own it. We are done with acquisition.
 		 * Reset NTESTON and BUSINIT, then return success.
--=20
2.11.0

