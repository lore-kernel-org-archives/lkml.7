Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A07C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BCF214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="e39EJlez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388015AbfDRGSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:18:09 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:26078
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfDRGSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKJwnSSmPM5ZNOauzJz4ooOJ4n+BrzF+A2+gjGdPio0=;
 b=e39EJleztukGll2Xt9PUYciSAhHjvv5NL2nXTknora9AQb6f6Wk+KOhRxZv+mlWZ3WSdbtRALLHitxz1yUJq1BmPK4yDdN9YR6Aplpc7lcLkadSoVJV63UYS8YcbDv398Il2ufkTXcSyHuqJYLoQXhc3pj2hCgVG+cMBrMjAcSE=
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com (52.135.162.148) by
 AM6PR05MB5505.eurprd05.prod.outlook.com (20.177.188.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 06:18:05 +0000
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com
 ([fe80::24cd:a3f1:870b:bd92]) by AM6PR05MB4439.eurprd05.prod.outlook.com
 ([fe80::24cd:a3f1:870b:bd92%6]) with mapi id 15.20.1813.013; Thu, 18 Apr 2019
 06:18:05 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Colin King <colin.king@canonical.com>
CC:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cxgb4: fix spelling mistake "immedate" ->
 "immediate"
Thread-Topic: [PATCH] RDMA/cxgb4: fix spelling mistake "immedate" ->
 "immediate"
Thread-Index: AQHU9a57o/R4KL1TkEqUIJMa8cT+hw==
Date:   Thu, 18 Apr 2019 06:18:05 +0000
Message-ID: <20190418061801.GA5646@mellanox.com>
References: <20190416143804.1518-1-colin.king@canonical.com>
In-Reply-To: <20190416143804.1518-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR07CA0106.eurprd07.prod.outlook.com
 (2603:10a6:6:2c::20) To AM6PR05MB4439.eurprd05.prod.outlook.com
 (2603:10a6:209:43::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2bc826e-3912-41e3-300f-08d6c3c59df0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB5505;
x-ms-traffictypediagnostic: AM6PR05MB5505:
x-microsoft-antispam-prvs: <AM6PR05MB5505EE85514D8206D7A01762CF260@AM6PR05MB5505.eurprd05.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(346002)(376002)(199004)(189003)(14444005)(256004)(6916009)(2906002)(68736007)(52116002)(66066001)(6246003)(6486002)(446003)(5660300002)(11346002)(476003)(186003)(486006)(386003)(6506007)(102836004)(86362001)(99286004)(53936002)(6436002)(26005)(76176011)(81166006)(478600001)(25786009)(4744005)(81156014)(97736004)(229853002)(316002)(2616005)(54906003)(6512007)(8676002)(33656002)(1076003)(305945005)(4326008)(7736002)(71190400001)(71200400001)(6116002)(3846002)(14454004)(36756003)(8936002)(14773001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5505;H:AM6PR05MB4439.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lger1bmRlFRqucVDmg7ahCK/F5vy8TjPX8F8B7QE0NsQtichfiWFZw0Z7hfrKieLPb8gNhmGbmLxMt/0oTwHKjVxLkSzLmdIG0OLjMCTiUN/eYh/aYcxYeZjkZiaCSaJ3DMUQN15wCmF3NVT6CXe5cK6g7+xfc6Aha4xCTHVZXuIsHAIIGtGq7w6Z2qnCxVOp3vRJ32DrpR+vCvZgTVjkWem4f2rCjDM0w34amlQadbJXXpv+7hVqvzdWcTc2St/kEizEnhMwOiDV2Rq59dB4+wSm1ENFIWSNqsrP7uqVLU3FY4gkYuS/WUjfCBcopGVK4koV+pLVzAVfkeabEnJs5QN0QSVSIj2Oyz5oIlC94hf80de2VACc7AueD3BtCl4EAGJVBIb7x+ji9RrLg2uFzny2f1mF1D9X6Czv6bdD/U=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F4EB7F3405470448004DFEE7BBFEF22@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2bc826e-3912-41e3-300f-08d6c3c59df0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 06:18:05.2016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5505
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:38:04PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> There is a spelling mistake in a module parameter description. Fix it.
>=20
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
