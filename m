Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB52C10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C90206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 01:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="e2EtH93a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfDOB55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 21:57:57 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:19772 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOB55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 21:57:57 -0400
X-IronPort-AV: E=Sophos;i="5.60,351,1549954800"; 
   d="scan'208";a="29910893"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Apr 2019 18:57:55 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sun, 14 Apr 2019 18:57:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U07ejqDZiCKTqP9ieSe72XCsEstQcTWZySqTKr1Exuk=;
 b=e2EtH93aE21PqfMHf2vQWlURqpmDvGZSvBAt1m+LuiU+FRJU0zbnTQAoRX5a2gnHoqlZJrcTR/BULEHiuMlLzK+kbqbvmcM9GVmGPAPIzvHBWTcaWEcwvDYoUucs60oonqAhIiTnQQQlcoZKQzPiy/kR5B2ejdjOvl1hfRuGKdo=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.239.148) by
 BN6PR1101MB2242.namprd11.prod.outlook.com (10.174.116.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Mon, 15 Apr 2019 01:57:50 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::4d14:ae52:3fbe:ecad]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::4d14:ae52:3fbe:ecad%3]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 01:57:50 +0000
From:   <Woojung.Huh@microchip.com>
To:     <lukas.bulwahn@gmail.com>
CC:     <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: normalize Woojung Huh's email address
Thread-Topic: [PATCH] MAINTAINERS: normalize Woojung Huh's email address
Thread-Index: AQHU8c3YTbAxIjIkPkKxJ+Nj35yJPqY8eVGg
Date:   Mon, 15 Apr 2019 01:57:50 +0000
Message-ID: <BN6PR1101MB213052D211A593D0B2EA8C8CE72B0@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <20190413075215.11889-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20190413075215.11889-1-lukas.bulwahn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [67.81.18.121]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 113d887a-af8a-4315-fe61-08d6c145c43e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR1101MB2242;
x-ms-traffictypediagnostic: BN6PR1101MB2242:
x-microsoft-antispam-prvs: <BN6PR1101MB2242D915C3A0121BEDBEF60FE72B0@BN6PR1101MB2242.namprd11.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(136003)(346002)(366004)(199004)(189003)(6506007)(72206003)(97736004)(54906003)(256004)(6916009)(102836004)(68736007)(229853002)(25786009)(558084003)(71200400001)(71190400001)(86362001)(52536014)(53936002)(105586002)(3846002)(478600001)(99286004)(6116002)(106356001)(7696005)(316002)(8936002)(8676002)(81156014)(486006)(66066001)(26005)(6436002)(5660300002)(2906002)(4326008)(14454004)(186003)(6246003)(446003)(33656002)(476003)(76176011)(7736002)(9686003)(74316002)(11346002)(81166006)(305945005)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2242;H:BN6PR1101MB2130.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GhVs9tmHVxx07Cwmmj4zQx56egM/4Dj+RQPjTp60H8zCSuRNISszTcJb/8G2vbbnSQcxnRqFa9q5iu0llEMFHjN9WsdAS4QQHQK4bNC7867dqk7AHZG8kGKWwiEGARYtAw6ndnRROosoaZXGrNAA4Lm3CG5K11bcNIinMVy3071N01QR4kJibqIEfX1Cw+x+6Zg/HFkgYjxZhkWIoG6HWg78d4qzC9df6ucb8/phdqvIiAuiD5CElyQcGjxCP/v/d6U14diyabr4plr0P5pHRoRRA7oL9oQv1IU6/ycDOa1cCoVxN6vX0++WuyqZGv4cfzmBZbFKktGEKbNuRbzijsDWaN6p1qng9zMMRnX4RCm1TBJc61sBLwBYEnU8jKmFjzTJeM9Dv8s7MCsa3zeczIg4evn2VnKWGinSbq+N2wo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 113d887a-af8a-4315-fe61-08d6c145c43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 01:57:50.6198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2242
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> MAINTAINERS contains a lower-case and upper-case variant of
> Woojung Huh' s email address.
>=20
> Only keep the lower-case variant in MAINTAINERS.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Woojung Huh <woojung.huh@microchip.com>
