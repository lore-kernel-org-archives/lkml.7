Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A2CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C82217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="uxcJKavz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbfC2LB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:01:26 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:56094 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727675AbfC2LBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:01:25 -0400
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id AB/4F-13147-20BFD9C5; Fri, 29 Mar 2019 11:01:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRWlGSWpSXmKPExsWSoc9npcv0e26
  Mwf+zXBZTHz5hs7j/9SijxeVdc9gstr58x2TRd87dgdVj06pONo871/aweTxbuJ7F4/MmuQCW
  KNbMvKT8igTWjJ9TVrEUPGCpaNsm3sA4haWLkYuDRWA9s8Sas1/YQRwhgQlMEhtXL2eDcO4zS
  kyZtZqpi5GTg03AUGLem/eMILaIQJjEiqOdYEXMAicYJdYd/QrUzsEhLBAgMf2BPkRNoMTE+S
  0sELaRxI1Hh8F6WQRUJd5f+8YKYvMKxErMP/8CalkDo8Tv3s1gDZwCbhJzrn4Ga2AUkJX40ri
  aGcRmFhCXuPVkPthBEgICEkv2nGeGsEUlXj7+xwpRHy/Rvv8tO0RcR+Ls9SeMELaSxLIbs1gh
  bFmJS/O7oeK+Ek1vN7KCHCEhcItR4vK26VAJLYnLy65CLcuR2LtqH5QtI/H7dhNUwwtWiUeXr
  oAlhASSJT7MPQu1WU5iVe9DFoiiC8wS55dC/MwMdNKC3Z/YIGxtiWULXzNPYNSYheS7WUjKZi
  EpmwUOMkGJkzOfsCxgZFnFaJlUlJmeUZKbmJmja2hgoGtoaKwLJC1N9BKrdBP1Ukt1k1PzSoo
  SgbJ6ieXFesWVuck5KXp5qSWbGIFJKqWQ4dAOxi9L0w8xSnIwKYnyPvoxN0aILyk/pTIjsTgj
  vqg0J7X4EKMMB4eSBG/MT6CcYFFqempFWmYOMF3CpCU4eJREeP1A0rzFBYm5xZnpEKlTjLocB
  xY9nMssxJKXn5cqJc7bC1IkAFKUUZoHNwKWui8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEu
  b9DnIlT2ZeCdymV0BHMAEd8ap+NsgRJYkIKakGRp9bF0KeXOZSV37LP/enIEdc+2uXKe/l7+9
  1/Ty1w/b5iZ+VW3xva7y4zVclZ203R/fin7hA8d99meGMXyyVrv4rnJnd/5r//ze7y3u5Ds6N
  0pIJ44mX3TV/ntSGc9Gh1neXzjge6iZrljZZ9tL/n4G1jJszDtiaLgy+HfGj3YZHd99mExOP7
  0osxRmJhlrMRcWJAE9caqvYAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-24.tower-223.messagelabs.com!1553857281!3326106!1
X-Originating-IP: [104.47.14.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27982 invoked from network); 29 Mar 2019 11:01:22 -0000
Received: from mail-vi1eur04lp2058.outbound.protection.outlook.com (HELO EUR04-VI1-obe.outbound.protection.outlook.com) (104.47.14.58)
  by server-24.tower-223.messagelabs.com with AES256-SHA256 encrypted SMTP; 29 Mar 2019 11:01:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULYCrCQfJz3F2LJdHRHYrycvCei2RgW2P+zgHBaq5Qo=;
 b=uxcJKavz33iLoDT3k/7/6pi+9+/904sHV+G8zX6SFNeUxzCsYemJbD8RwobWAOGWchLxo+mTcgpzLvWQDFr0dS7WyO3hUHhvk54w1fbwGGmzXHIhYdFhLdlpKvQhgkmW6dfb3vnxHbS6Q7IizbPol6ObXo9Y/2titIlaAK82Hew=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM (10.167.201.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Fri, 29 Mar 2019 11:00:53 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 11:00:53 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 5/6] mfd: da9063: remove leftover platform_data
 definitions
Thread-Topic: [PATCH 5/6] mfd: da9063: remove leftover platform_data
 definitions
Thread-Index: AQHU3aIiUQO9QaSztEa+kVgNsipmi6YifqsQ
Date:   Fri, 29 Mar 2019 11:00:53 +0000
Message-ID: <VI1PR10MB2352E6A2FBAE49E3EFD3EFD0FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318154759.21978-6-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cf3a470-cc3f-4c94-01c9-08d6b435d03c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0512;
x-ms-traffictypediagnostic: VI1PR10MB0512:
x-microsoft-antispam-prvs: <VI1PR10MB0512774A8DBECF8F4BFF2E65F55A0@VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(8936002)(186003)(107886003)(256004)(86362001)(68736007)(71190400001)(14444005)(52536014)(305945005)(3846002)(6116002)(71200400001)(66066001)(7736002)(53546011)(6506007)(55016002)(11346002)(229853002)(316002)(478600001)(486006)(476003)(14454004)(33656002)(76176011)(446003)(106356001)(7696005)(54906003)(53936002)(2906002)(110136005)(105586002)(8676002)(6436002)(4326008)(81166006)(97736004)(81156014)(26005)(5660300002)(99286004)(25786009)(6246003)(4744005)(102836004)(9686003)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0512;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RLzn1XkxPtSNzsVo9A4+ItHYX0ZPlBEnZGpdEFdzYFVOHdsHdb2UrsMPVRMFNTlhXQUHkwhbAKBF9Ut+cYvquFG2ptekaihgnE2I1+PM3kvvPWRNRqcEmg1pBua6umq5/MthjtVWa62yXxpY49iteZc9v4DcWvFkR2w59tbF/08triLXu10GM04Z7W+yWLR5lF9QCGSy5PL+O0n1wdXfWoLorwzNibZOKat/2Wx0faXkbiLUqurp3CZPv2x9Dj60zlN4sJ/B+pdCa+8RJ1cKnYqnpj3E56gN/M0Q5ega2FI57sVyE1C8E3tUv7xfAmsPm2tq3/CGAlgszpZJW53Hxb+I8ejZrpxj7A2Vhooy74Bah9qgqEYIm6EZOwtO9ZHb2J1r0pWkw6m5+/7nt9jtSqFD+ha9UBFbyzKPvbq+K50=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf3a470-cc3f-4c94-01c9-08d6b435d03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:00:53.8052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB0512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18 March 2019 15:48 Wolfram Sang wrote:

> Subject: [PATCH 5/6] mfd: da9063: remove leftover platform_data definitio=
ns
>=20
> Not used, not needed, remove them.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  include/linux/mfd/da9063/pdata.h | 65 ----------------------------------=
------
>  1 file changed, 65 deletions(-)
>  delete mode 100644 include/linux/mfd/da9063/pdata.h
>=20
> diff --git a/include/linux/mfd/da9063/pdata.h

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
