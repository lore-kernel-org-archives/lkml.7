Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129D5C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5AD2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="hv7nSuCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfC2K6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:58:11 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:8529 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727788AbfC2K6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:58:11 -0400
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id 84/4E-04122-F3AFD9C5; Fri, 29 Mar 2019 10:58:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSWUwTURSGuZ2lQ6XmMmg4oqiUuKGtVGOoDxo
  TFxq3oFFjDAqDjG1NabFTtPoCGpVQlRh3KhVwI+KCqUsQSHBXjCihRgVRRBqRuoKKBo3Y6aDi
  23fP/5/t5jAE20hHMbzDztssnFlFK0jjREWCenqPOzk+ryRBt7/VR+tuHH2DdC1fbyFdY1c3p
  fNWFtK6Sx0fZLr8B4kz5Porrudyvacsj9Y3P66m9a9Lykn9Z8/wJGoFZbKkWR2plLH8Z648cz
  vpKD28jc5B1wgnUjAkLifAva+OEh8szpfBF/92Unq0IOj0v5Q5UShDYy0cefcRiTwIc3BwV69
  cNBH4lAy2dHmDpgg8F7Y2uAnJNA+KG1tkEk+CqscHgskkHgUfbtwPshKvhH3us3KpWw6C9npf
  MDkUz4He21/lIiMcDV82nw7GCRwJTb6iYFHAGI5XPyQkHgwdbb8oyZ8CuTXv5VJ8AtQ98SGJV
  XDyqYuSOBoainb0xRdAW+VnJA4BuAnBsQZnX3IcFOWdCjRjAmyG8tpYKTwMfjzbQkl+LwVnzt
  eTosDi1fDJXdeXOxzKdrWSkqmegMsFbpm0wQQoruqiJR4PJ0veErvRWFe/5Vz9bK5+Nlfwx8K
  htsBHFiOyDCWk2UwGoz2DM5nV2vh4tVY7Sa2dOlk9JUHDbVJzGj5LvYEX7GqthtsgaISNGavN
  6RoLb/egwIGlZ16bWoHulRquoyGMTDVY+eq7O5kdmGZN32jkBGOKLcvMC9fRMIZRgXKAqIXbe
  APvWGMyB670jwxMmGqQ0tMdkJVCJpchmAySdA9NZq4ebXUTTHFjzxGCJS1WCx8VqZwmVsKi1Z
  hl+Vvoz8U3oOioCCUKCQlhwzJ5W4bJ/r/uR5EMUkUo734LVAkzWex/+/kDo8gCo/izD4uj2Ll
  /UlQOuqBoDg+tyjv0allF7OyY6gPePScWW9+9yB2482Wns7ssopBNOrd+fn5ioSNmzJ2rNxUz
  F4xwHkram+wPH3fRmLjIUDMKxfUu8TVT7UuI0tHLF85Yum7ojtpQa0+7p83fYeok2bFsjAGPz
  l6rWtVUMyv1kvapPix22aOR3uxfgu2bTkUKRk4bR9gE7jcbrHcl7AMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-18.tower-262.messagelabs.com!1553857086!4220497!1
X-Originating-IP: [104.47.10.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31285 invoked from network); 29 Mar 2019 10:58:06 -0000
Received: from mail-db5eur03lp2055.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) (104.47.10.55)
  by server-18.tower-262.messagelabs.com with AES256-SHA256 encrypted SMTP; 29 Mar 2019 10:58:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cg/hgxgFoCEnMqeyVbBoD3i50m+jcBbl/2UqsFftyec=;
 b=hv7nSuCtC04FwAHq2K+wo2jCMQEyOvcOA6/YyAbspCIokpj/xFGSg/oGpMQ1hX7iZwVRkVqaHiT24/Usp8uJAJKF2JQynmflq6jb/olIVigXte6zZVL5RSTbfSrPqhoB3uYYtgP+ga023fEESPOh8trgXjrN2Gqzx4YHbGvqF6c=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2255.EURPRD10.PROD.OUTLOOK.COM (20.177.62.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Fri, 29 Mar 2019 10:58:00 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 10:58:00 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH 2/6] input: da9063_onkey: remove platform_data support
Thread-Topic: [PATCH 2/6] input: da9063_onkey: remove platform_data support
Thread-Index: AQHU3aIjgnLzkyST00a6QkH/UQtfnKYifeWQ
Date:   Fri, 29 Mar 2019 10:58:00 +0000
Message-ID: <VI1PR10MB2352701871983EF8677C5CB8FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bee264d-4049-4956-f9dc-08d6b4356915
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2255;
x-ms-traffictypediagnostic: VI1PR10MB2255:
x-microsoft-antispam-prvs: <VI1PR10MB225522C74395AD476AB8B352F55A0@VI1PR10MB2255.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(136003)(39860400002)(189003)(199004)(186003)(25786009)(53546011)(102836004)(6506007)(8936002)(71190400001)(26005)(71200400001)(6436002)(74316002)(6246003)(229853002)(7696005)(99286004)(11346002)(7736002)(256004)(106356001)(305945005)(52536014)(446003)(3846002)(6116002)(86362001)(105586002)(486006)(476003)(5660300002)(66066001)(68736007)(81166006)(53936002)(9686003)(81156014)(8676002)(33656002)(97736004)(4744005)(54906003)(14454004)(55016002)(4326008)(110136005)(478600001)(316002)(2906002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2255;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xJN8fwrlk+k4YFgLh8L16d8m3CyrlUOCvVmHcmDx4zps4VsaqWZln0q6W65eK7T+eTMsbmzhVhTRGr/cv2n0/4GBvBBnhxh8hiCW1Wf1fuN/HNUMrjKoKzlCXMJr6ht2BX1W2WTymRsw/fLEf2eh8wyo86ZL9qNHF8uNOETK0G1NoD6vNg7T//Ffx0frW7GstAgm6KhzC0YUj3ghCaeBpsMbB21RqntBnwxauq/XaKScIsG4Z4SUVMJ9PKPWQ1beerV9c/eT529Ovk/I4x5Lwsrs/+cFEfO0A8ljQGlkTRjyklnmZcveC29Yp8Vy/t4AW7jCf8yEO8LjyXcwAYEEthmm7LSu6OsC6bdk7lNzEhT1PQo/NMDvrwIQcwLgxFomLcFT6IW024DpvRHpySZ69Dp5738xwPTwMXZJAu+xVYI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bee264d-4049-4956-f9dc-08d6b4356915
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 10:58:00.7937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18 March 2019 15:48, Wolfram Sang wrote:

> Subject: [PATCH 2/6] input: da9063_onkey: remove platform_data support
>=20
> There are no in-kernel users anymore, so remove this outdated interface.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/input/misc/da9063_onkey.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
