Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF99C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D1C2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="sXS+4qgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfCRQe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:34:58 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.132]:20581 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfCRQe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:34:58 -0400
Received: from [46.226.53.56] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.eu-west-1.aws.symcld.net id 8C/97-22588-DA8CF8C5; Mon, 18 Mar 2019 16:34:53 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjH955zdjzZTrzOZE+SQoMgqq3NKFZ
  GFHQZUVChCWHUUY9uMOfcmWkRYl/SLksjjFpepuUIywyjkjQ0a3nLFUplFwtpWWoXtTvEaGdn
  lX37vc///9xeHoZU9tKxDF/g4O1WzqKmIynTEsUKTUNXaarO932BoXzYTxteffUiw9Opb3LDw
  M0K2nBt9CNhOO7buIY2NtUfpo0vHrfSxpGaRsr4uSl+K7VTbram5RTskZuuVRUTtkmm4HDnzi
  JUF3EERTIUbiQh4C0hxYcSlxFw0O8JKjOCj1cIKptzRaaxHqref0Iiz8bJ0HS/RC4mkLiWAHf
  tKCkK0XglVBc9ISRTIvT72sOcAN6KoVAyhedDecmvELN4F3Q01xFSs/Vw6tG7UJ0ZeAMM9vlp
  kRGOgy8HL4biJFbBM391yA8Yw/nWB6TEMTD6OiCX/LuhuO1DhBRfDH1P/EhiNXgGXXKJ46C/+
  mg4vgUGbzwPfQXgZwh+FdeEGyyEyUMjYZMFvEP94WZzYaBL9IgJPXLoOFGPpA3SYaKyL9w5Hu
  qdw5TED0lwfTNKGywGd8sULfEi8NSMk2VogWvacq5pNtc0myv0YVHQfcZPuRFVj5an2c1ZJkc
  2Z7Zo9DqdRq9P0CTo9JqlWm6/Jl3L52nyecGh0Wu5fEEr7MtOt2RorbyjCQVPKsPWTTajkQtZ
  HWgOQ6hj2GX3SlOVs9JyMvaZOMG0255n4YUONJdh1MDe6gxqUXY+iy/INFuCd/lHBkahns0mi
  TIr2LhswZwlST1oKdNeO1xJMi9vv60klZQ1x8rHqthE0YpFqynP+rfQnxvvR3Gx0SySyWRKhY
  23Z5sd/+tjSMUgdTR7V6yiMFsdf/uNBUchgqNcrgqN4uD+SbFFaG9uSkszqVq0o/DcscKisaS
  fSllb9X2fuytlzPPjp8tZcfJUYLt9y9s0HBkT4e9OzXgwc9Mdyzr98iFsy3WvDgiTnivXkxs/
  KiY2b4zp2bH2KvViXBZocLYTvdt6nIF5szJPsGtXOj+oNq0a8J2ldAHvm+2PV12aaDl9wKnw5
  RSqKcHE6ReSdoH7DSuCfHDeAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-16.tower-308.messagelabs.com!1552926893!3791870!1
X-Originating-IP: [104.47.12.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21646 invoked from network); 18 Mar 2019 16:34:53 -0000
Received: from mail-db3eur04lp2057.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) (104.47.12.57)
  by server-16.tower-308.messagelabs.com with AES256-SHA256 encrypted SMTP; 18 Mar 2019 16:34:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs/YECII6fMB+DIwXJkEdxK/XyI6fmyjDVoyN0l0J/E=;
 b=sXS+4qgM+tx4POxUP1twF6nqjBzBbXlZUPzucxaDJOi6YgZb7blUeO7zHkcBs63+C4PlrVny2qrVrhwko3gv1pYdmO3n0WwShmaNxwShwdMfZkYrTvBPzMC8+s4KS5SDDVISS2+J+APgDX7normGssKjqAwU95EjgdJ/zwqYCCw=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1614.EURPRD10.PROD.OUTLOOK.COM (10.165.191.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 16:34:52 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 16:34:52 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH 0/6] mfd: da9063: remove platform_data
Thread-Topic: [PATCH 0/6] mfd: da9063: remove platform_data
Thread-Index: AQHU3aIiRxuJGE6LNESZwBdNcQFfU6YRjIxg
Date:   Mon, 18 Mar 2019 16:34:52 +0000
Message-ID: <VI1PR10MB23522C4EA0F730414CD14B56FE470@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a783dd0-3ddd-456b-4675-08d6abbfa583
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1614;
x-ms-traffictypediagnostic: VI1PR10MB1614:
x-microsoft-antispam-prvs: <VI1PR10MB1614598D80130D8D1F1AD8F4F5470@VI1PR10MB1614.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39850400004)(136003)(396003)(376002)(189003)(199004)(14454004)(476003)(99286004)(6116002)(86362001)(6506007)(102836004)(7736002)(3846002)(26005)(7696005)(446003)(4326008)(76176011)(53546011)(305945005)(52536014)(11346002)(33656002)(186003)(25786009)(486006)(71190400001)(2906002)(110136005)(478600001)(8676002)(97736004)(81166006)(71200400001)(81156014)(5660300002)(53936002)(55016002)(316002)(105586002)(6246003)(54906003)(68736007)(229853002)(9686003)(106356001)(256004)(6436002)(66066001)(74316002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1614;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 36oigYzDyClE692fplUzD8x7ynZT7RDCnSQx0a58DCUgnSZVUO7pFtTSLfDgFGgsGR9WmxPLO1AIm+DZKuMinY/vo488UgfFi2aW/sPOe60DbasXe6B99KknsGqSKPZwvKU26F8pSC8Ov3taPKpmDQsKlmq4yMtmeV3ItVxm/3+buZ0cd/r6K2gBAjb3HjBM85THBhojhb4cOwQHlKt8RMf0bu+05F83m3tXBp/vdv16c0c6gc0EabYZIKjUtn8VSUlPp0V2wwSCVDCSARQ6uKtKKQKlJSNqf8/koOqvVRLvVxCcf4DCl95ydNnFYEdqUS/NlD2j1GmkYXiP5QyM1TWdDLzG+LB8Nmocp2foZfZP5kZMhebiJCM0nIYUj/NxCi9llk2rvHbPfYDjmOTwKeDs6qrXWZ0kjMH1r9Zp0Rg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a783dd0-3ddd-456b-4675-08d6abbfa583
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 16:34:52.2130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 18 March 2019 15:48, Wolfram Sang wrote:

> To: linux-kernel@vger.kernel.org
> Subject: [PATCH 0/6] mfd: da9063: remove platform_data
>=20
> When working with this driver while debugging something else, I noticed t=
hat
> there are no in-kernel users of platform_data anymore. Removing the suppo=
rt
> simplifies the code and gets rid of quite some lines. The biggest refacto=
ring
> went to the regulator driver which could maybe benefit from more
> refactorization. However, there is no in-kernel user of that driver, so n=
o
> testing. I left it at this stage. I think the changes are still at a leve=
l
> where review and build-testing will give enough confidence.
>=20
> Besides the regulator thing, it was tested on a Renesas Lager board (R-Ca=
r H2).
> No regressions encountered. buildbot was happy, too.
>=20
> The patches are based on v5.1-rc1. I'd vote for all of them going through=
 the
> MFD tree. Looking forward to comments!
>=20
>    Wolfram

My regulator tests are currently broken, so I'm looking into it.
I'll read-through and test these patches as soon as I've solved the regress=
ions.

Regards,
Steve
