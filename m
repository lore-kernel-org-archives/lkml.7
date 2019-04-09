Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B69CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40A521473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chelsious.onmicrosoft.com header.i=@chelsious.onmicrosoft.com header.b="Ym8dS9X8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDIJ76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:59:58 -0400
Received: from mail-eopbgr820108.outbound.protection.outlook.com ([40.107.82.108]:8736
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbfDIJ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chelsious.onmicrosoft.com; s=selector1-chelsio-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezcQsBYt32r+sAF2OchTDXzsJBWcxgaHUd5QgP3MzhI=;
 b=Ym8dS9X8+bH8BYIuD9jWG9wFqlr6Ew3cexpOkjwV6WWU1sizDmOpz58ZuEtLw1jqJksGbRmN7Z38TZqdM055tJfbSGRa2zAN185mFaPMNy2U8N1MH1huohV+FV3rz5AWua/X8Z1UdGonYnV+iZLZFY/sVLUilWEEzvCbHayNgbs=
Received: from MWHPR12MB1343.namprd12.prod.outlook.com (10.169.205.144) by
 MWHPR12MB1184.namprd12.prod.outlook.com (10.169.204.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.13; Tue, 9 Apr 2019 09:59:54 +0000
Received: from MWHPR12MB1343.namprd12.prod.outlook.com
 ([fe80::10bf:850:c820:1454]) by MWHPR12MB1343.namprd12.prod.outlook.com
 ([fe80::10bf:850:c820:1454%7]) with mapi id 15.20.1771.021; Tue, 9 Apr 2019
 09:59:54 +0000
From:   Vishal Kulkarni <vishal@chelsio.com>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
CC:     Nirranjan Kirubaharan <nirranjan@chelsio.com>, dt <dt@chelsio.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: pull request: Linux-firmware: Update cxgb4 firmware
Thread-Topic: pull request: Linux-firmware: Update cxgb4 firmware
Thread-Index: AdTuuZJFn+H2sVBgSk6ALUsClzB6DQ==
Date:   Tue, 9 Apr 2019 09:59:54 +0000
Message-ID: <MWHPR12MB1343B0921E0D4DD39A1C9F38CB2D0@MWHPR12MB1343.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vishal@chelsio.com; 
x-originating-ip: [111.93.130.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 75cb54db-ba3e-4247-337d-08d6bcd21d6b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR12MB1184;
x-ms-traffictypediagnostic: MWHPR12MB1184:
x-microsoft-antispam-prvs: <MWHPR12MB11847B0B9A82165DF1B1DB58CB2D0@MWHPR12MB1184.namprd12.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(136003)(39850400004)(396003)(199004)(189003)(55016002)(71190400001)(9686003)(476003)(106356001)(5640700003)(86362001)(68736007)(305945005)(2351001)(8936002)(7696005)(6436002)(7736002)(74316002)(3846002)(6116002)(71200400001)(5660300002)(486006)(316002)(4326008)(54906003)(81166006)(99286004)(53936002)(81156014)(8676002)(15650500001)(508600001)(33656002)(52536014)(26005)(14454004)(2501003)(6916009)(78486014)(66066001)(14444005)(6506007)(256004)(97736004)(2906002)(102836004)(105586002)(186003)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR12MB1184;H:MWHPR12MB1343.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: chelsio.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MAFjBsjtmo1XzVI3OEDSQlMBnNoCig4Me9QMDAv2blucAQzrSSmoi1/nXfdrdqOsVdoz4g9d3JsLs2cSY6o2kcnrbctDx/wSzu1UShYnYn0OVJE5fdHLOGlQpDGPO4uOyg7DjHRAHjQTg1uDi+fdjeTqqhg86XjUEC1hgDbfTNH9HEB+a8ai6O9PxY92nsfUNYy0PzTtRJfbeRSb/DN1EUfiATQe3uTfQitSM8kunLaAsDOhkHrJcaGSsxweEP0xOl1Hr3FkKNYZvz+BjOHU4EhEQIJZVliue96n0qVBsbC34VarDSOsrgDavc3oI2B+z8pK6S7GDRa+zVsZZAgKiiYmxrIA8E6KuXC+AvB7+BjzShKlYHWJ9XkbPPZVlaPuADhkjY6K3YtVBP+MnKPPBe8bk/5nEe5Hmsngoc03OuI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: chelsio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cb54db-ba3e-4247-337d-08d6bcd21d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 09:59:54.1141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 065db76d-a7ae-4c60-b78a-501e8fc17095
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kindly pull the new firmware from the following URL:
git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

Thanks,
Vishal

The following changes since commit 67b75798ea88f4b1d6ee6a3b5a0634d29620c094=
:

  linux-firmware: add firmware for MT7615E (2019-04-02 08:00:12 -0400)

are available in the git repository at:

  git://git.chelsio.net/pub/git/linux-firmware.git for-upstream

for you to fetch changes up to ddde59823ae0452582c49774894173435e885549:

  cxgb4: update firmware to revision 1.23.4.0 (2019-04-09 02:43:33 -0700)

----------------------------------------------------------------
Vishal Kulkarni (1):
      cxgb4: update firmware to revision 1.23.4.0

 WHENCE                                         |  12 ++++++------
 cxgb4/{t4fw-1.23.3.0.bin =3D> t4fw-1.23.4.0.bin} | Bin 570880 -> 570880 by=
tes
 cxgb4/t4fw.bin                                 |   2 +-
 cxgb4/{t5fw-1.23.3.0.bin =3D> t5fw-1.23.4.0.bin} | Bin 659456 -> 659456 by=
tes
 cxgb4/t5fw.bin                                 |   2 +-
 cxgb4/{t6fw-1.23.3.0.bin =3D> t6fw-1.23.4.0.bin} | Bin 708608 -> 708608 by=
tes
 cxgb4/t6fw.bin                                 |   2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)
 rename cxgb4/{t4fw-1.23.3.0.bin =3D> t4fw-1.23.4.0.bin} (99%)
 rename cxgb4/{t5fw-1.23.3.0.bin =3D> t5fw-1.23.4.0.bin} (99%)
 rename cxgb4/{t6fw-1.23.3.0.bin =3D> t6fw-1.23.4.0.bin} (99%)=
