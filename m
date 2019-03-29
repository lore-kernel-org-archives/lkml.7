Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03F6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE94B217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Suyx7ZAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfC2LAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:00:43 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.68]:6546 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727675AbfC2LAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:00:42 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id 35/FE-07686-7DAFD9C5; Fri, 29 Mar 2019 11:00:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTWUwTURSGuZ2F0VAdC8qxLDFNNC5MpbgwqDH
  GRG2iIuHBRK3iYEfa2BbSKVL0wWJMFIgiiBqrIC6pWk0wJC6IC4LGqIALgrgi2hjANQIKGKkz
  nar49t/zf3P+c2/OUJiqhVRTvNPB222cRUOOxE3TFXOZ1sEyQ3xf7Tx2f4ePZNv7biP2+5NdC
  rb5yhGSvdD1WcHuaVqygNRXu1+F6qu8+aT+ZetVUv/+WCWu76mKTSFWE2ZbeqZzPWEq8t0js7
  4Tzvd1paEuVEoUoJEUTldiUNJYHjio6L0KqG66Q8qHdgSv39SIzgiKpHVQ/vELknQEnQODPW0
  KCcLoBgT1J9oxyQin10JXwekgtA4G639gsk6A4u5isU6JeROhstwglZUivsdbFQxzIXCV3FZI
  xgh6MQz1XMMljegY6M07G+iD0ZHw3Hc0wABNw8mrDzBZj4Wud0OEzKfBzhufQuV6HDQ+9SFZa
  8DT5iZkHQOPjxYG68vh1/lCTBoC6OcImi8eDBpTodnTEgyzQGd9NS7raPj5Yjshf9BMwAF/a6
  Crit4AX8sag8mx4N3dgcvQQwxKG84h+QpxUFHzjZT1NPAc+4DtRZPdw27nHoa5h2HuwJONgbu
  HfHgFwr2ITbebM0wOK2e2MLr4eEanS2B0SUlMQgKr5bYw6Vo+m8nhBQej03I5glbItW6wGLU2
  3lGFxOUyZt3xXUb+gow6NJ5SaMYq3/aXGVSj0jONuSZOMKXZsy28UIeiKUoDSsOA6I2x8xm8c
  6PZIm7oHxuoME2EMlmylUIWZxXMGbJ1D82gao93lGFUxbPBckyF2zJtvDpSuVtCaQk1Zdv+Nv
  qz7Y9RjDpciUJCQlRhWbzdanb873ejSAppwpVzxZ9CFWa2Of7mdYujKMRRurcdlkZxcP8stQs
  lTjC6Er/UuGrP7IvIvzVvcd6pGbMeRV1PSylOtRpvDTnmOHvZpbFq07aVoZ0e/zLuyfyUIufo
  7M0LayOiCtd43ZtWLVo9yTPNljol7nLJo3F9S+KGtP7ktk9CdGOxfceKm0XGxK33R11qN+hQf
  Of8ptkNTF7LlYHC1uv9fu3Mc/2XNLhg4nRTMbvA/QZw+A886AMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-2.tower-288.messagelabs.com!1553857238!5703158!1
X-Originating-IP: [104.47.2.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1307 invoked from network); 29 Mar 2019 11:00:38 -0000
Received: from mail-db5eur01lp2059.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.59)
  by server-2.tower-288.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 29 Mar 2019 11:00:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcsOwnY0yQ4HS1D5SCz3TSQcDSnxCzmz7j/tifRiFqU=;
 b=Suyx7ZAA1PEFif40j3qNkBmzkWnl53H5Hhyl28l+R12K3Je1LlAniCwCk6cNN3Ng7wEyyUgVlYrfAd+mJmV3E8hQ0wzAldvHLP9cIzqJ6W0tHeEe/jfUB4b56qKrfoyaUN5dJTQkzEcPIukBHKLwE9ipC+4H/bBcTjrlH+wY0B4=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM (10.167.201.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Fri, 29 Mar 2019 11:00:37 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 11:00:37 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: RE: [PATCH 4/6] regulator: da9063: move definitions out of a header
 into the driver
Thread-Topic: [PATCH 4/6] regulator: da9063: move definitions out of a header
 into the driver
Thread-Index: AQHU3aIdHTncDZU+0kC17NefMlzMF6Yifj0g
Date:   Fri, 29 Mar 2019 11:00:37 +0000
Message-ID: <VI1PR10MB23522792917A3C3C3C766CD2FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318154759.21978-5-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2c90eaa-41cc-4ee9-e640-08d6b435c67b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0512;
x-ms-traffictypediagnostic: VI1PR10MB0512:
x-microsoft-antispam-prvs: <VI1PR10MB051215EC1CDBD33E9C789E01F55A0@VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(8936002)(186003)(256004)(86362001)(68736007)(71190400001)(52536014)(305945005)(3846002)(6116002)(71200400001)(66066001)(7736002)(53546011)(6506007)(55016002)(11346002)(229853002)(316002)(478600001)(486006)(476003)(14454004)(33656002)(76176011)(446003)(106356001)(7696005)(54906003)(53936002)(2906002)(110136005)(105586002)(8676002)(6436002)(4326008)(81166006)(97736004)(81156014)(26005)(5660300002)(99286004)(25786009)(6246003)(4744005)(102836004)(9686003)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0512;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6q9EOM2KpKJ8ttjvEwVU905BX2cu2d59+K/0B7hnBVdzeDvCeeLuBB5lUGMAFo0B15khY5Z20NcynYxP03rOYVXwsGfPWFXIEC90iqTlWz6pBRGCMi03lKzm5HnoE9WbzH/HIUdBh1Sk5gJwruvLOGw8K5Qc21ALb4baAWh8i5x3LAIbGClK8sfNz7W+Yc22O/4YBOkSgixOSktGa/Twm0iSvvA4mX+1ZMSX0MAYjbmNwm0iPgThtVFf8TjtuSCbrbCJgekxbpsNffLNvJVZ+qy65eJdeVe84vp6Z8WfL5xaX4w1fA1EViQ5O51UAy+8QgncrWSbt/HFFmkwaF8Cb6Dss5CmUE2FpwUlOcd/h6JVUoDzPAw/ihC3Ef2FSI68PIx0XleXEkmiDP9CEcs4UomOYvB0J/eFa+1/nvsq8Cs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c90eaa-41cc-4ee9-e640-08d6b435c67b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:00:37.4057
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

On 18 March 2019 15:48, Wolfram Sang wrote:

> Subject: [PATCH 4/6] regulator: da9063: move definitions out of a header =
into the driver
>=20
> Those definitions are only used within the driver meanwhile, so put them
> there.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/regulator/da9063-regulator.c | 44
> +++++++++++++++++++++++++++++++-
>  include/linux/mfd/da9063/pdata.h     | 49 ------------------------------=
------
>  2 files changed, 43 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9=
063-regulator.c

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
