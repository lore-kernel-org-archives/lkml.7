Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F64DC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2817E20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LDwrWxTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDIEny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 00:43:54 -0400
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:18759
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfDIEnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 00:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRQEE8MRtQ0Odno9G1xiejd4M6PKIAsuDZQUsrD+kjo=;
 b=LDwrWxTyUnUg/u7H6wU2BxzJKrOnhAy1HjJYgFd1xS035iaCt5fbKvDXgVnYon+JcvC4BGkmt68Ph/PNcE8D2ChfvKGuhxONg8qGsXL2T+0ZWeQCxc67jeIpWbb0MG+lPJrwzrJ1dhcuZuDFwKWDoG1M4CuGcHpIcY+nbhh9pkk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6465.eurprd04.prod.outlook.com (20.179.253.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Tue, 9 Apr 2019 04:43:50 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::8cda:4e52:8e87:8f0e%2]) with mapi id 15.20.1771.016; Tue, 9 Apr 2019
 04:43:50 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Olof Johansson <olof@lixom.net>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND] arm64: defconfig: Enable RTC_DRV_SNVS
Thread-Topic: [RESEND] arm64: defconfig: Enable RTC_DRV_SNVS
Thread-Index: AQHU7jxLq+OSUQszvUq2rZ157qMiNqYzQQoQ
Date:   Tue, 9 Apr 2019 04:43:49 +0000
Message-ID: <AM0PR04MB42117A999FBB3F9A981DD2F7802D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1554749572-5090-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1554749572-5090-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d34ec58e-56d7-4db9-34d8-08d6bca5f5ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6465;
x-ms-traffictypediagnostic: AM0PR04MB6465:
x-microsoft-antispam-prvs: <AM0PR04MB646550982B71AC85F58E7C5B802D0@AM0PR04MB6465.eurprd04.prod.outlook.com>
x-forefront-prvs: 000227DA0C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(33656002)(26005)(66066001)(6246003)(6116002)(9686003)(186003)(53936002)(102836004)(14454004)(55016002)(3846002)(478600001)(81156014)(81166006)(105586002)(71200400001)(25786009)(8936002)(256004)(71190400001)(106356001)(229853002)(74316002)(86362001)(5660300002)(558084003)(110136005)(11346002)(44832011)(99286004)(8676002)(446003)(97736004)(2906002)(4326008)(476003)(6506007)(305945005)(2501003)(7696005)(54906003)(6436002)(68736007)(76176011)(316002)(486006)(52536014)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6465;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: asG7uy1ncZvc5389UqBmwcfO1pAeNViLzrE8h1NF2wBGPz3UApV+V+ofDejn/QcdGZCMe27JE5YHuPy0dsKVxZiR5+o5dt6TDLLuKqLNe6z5kvwI/LVQ5NSwiq7xVO6vcLjo0Up/BLiUj2yXjToIGEGfabKtOUW3cl63MkrKpCZlKeZ/1QGl/kY8sDZoyrVG8tLCZ7Py+x+wpACPbcMeL7rKIxLk/5nhSyxy5GjzsgngdvLc6JmOPlqN2lPsuyX0qMDtxOtqOcC8ZbcP5OmfKzBQdIK7HGrHMW6EeQA+YjwX7quFByH92y1dj/2nyt+u4oOIxi0n9q6fkbyVC0f+MLAYJpmnVeHMykuh1JT7u1f/mYwOdCXe+VpSJ3R8pnMYYHMBSJru2aw27T6ZpFvTzb9m5KgfRcoPWLSonxDVgSo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34ec58e-56d7-4db9-34d8-08d6bca5f5ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2019 04:43:49.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6465
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Abel Vesa
> Sent: Tuesday, April 9, 2019 2:53 AM
>=20
> i.MX8MQ needs it for RTC support.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
