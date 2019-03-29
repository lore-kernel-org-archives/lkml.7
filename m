Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DF4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12C2217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="c7kO3et4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfC2K5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:57:52 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.116]:39151 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727788AbfC2K5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:57:51 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.eu-central-1.aws.symcld.net id 6B/E6-12473-C2AFD9C5; Fri, 29 Mar 2019 10:57:48 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSWUwTURSGuZ2lg2HIWDAciWCcaKJoKxWJ44O
  RqNGaaNUHQ0IwOMDYNpaCnaJgYkSMgKioxLVQoGpQMYYEl2jBICSyGFfAXTRoXcAFcWVRdKZT
  FN/+e77/3P/cm0Nhmg4ynBKyHILdxltZcgxunonHaKcPuhKjuz5y3MEuL8k9/3YNcd87ClRcu
  6eU5C50f1RxRbeWxJGGy85OtaGmaidpeHq/jjS8dlfjhi81kSuJBMJiS07PWkuY+xpq1Rnb8K
  ztxUNYDqrDCtEYCmeqMWhuqkLyQcPsU8Hp+vMSCZQOzxG0FCXImmT0UPa+F8k6lFkNntx+Xzf
  G9CIo76gnZBDCGMB5skCtmJZCT38uoehZ8GC/Gy9ElBQ3BVyHF8hlmlkDx994cCU4B8Gruy99
  wYHMYrjQ8tN3D2Ii4Ou2M746xoTBY2+5StbAMHCi7jam6HHQ/XKYUPxJkF//Qa3UZ8DNB16ka
  BYqHzoJRUdAW/kuf3059DXsJuQhgHmMoP3iYT+IgvbKe/4wK3i6m/3NE2DoSa6/oZ2AQ7/vE8
  p3pcAn101/ciRU7enCFdMdDLyDR1TKE2ZARe1nUtHTodL9DtuHpjpHvc45yuYcZXP6vmwstB7
  14hUIr0Jcst1iMjvSeItVq4+O1ur1MdpYbWyMjt+sTdYJmdoUweaw8xLU8ZtEnZidlmJN1dkE
  Rw2Sdit1AxF7CX3INzWi8ZSKHUe/6HclaoKT01OzzbxoTrJnWgWxEU2gKBboxAGJjbULJiFrn
  cUqLegIBiqIDaWNMqbFDD5NtJgUdB3FUFePdbkwquLRYBmmwW3pNiE8jJ4npzCy1Zxp+3vRyL
  K3oYjwEBoFBARogjIEe5rF8T/vQWEUYkPoH/ItQRab429ejzSKShqlZ2uJPIqD/4fCcxAezOf
  P3MtHpC4ayLvR0qQu0TfsPzdt4+ZCdskzY2sr6Q46e9eoip9MnDpiMkQOVyS8DazzHDBMjL6S
  MTfv4uyieWzBr8K4pJKoNfGlOzpPbnfEuT8VG5/NoZG+rWNhXE32qhul3WFvh/TLJonNfaYVB
  QG91Vu86znjpUn35md2JrG4aOb1UZhd5P8ANG+PpucDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-13.tower-246.messagelabs.com!1553857067!3745772!1
X-Originating-IP: [104.47.4.51]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13159 invoked from network); 29 Mar 2019 10:57:47 -0000
Received: from mail-am5eur02lp2051.outbound.protection.outlook.com (HELO EUR02-AM5-obe.outbound.protection.outlook.com) (104.47.4.51)
  by server-13.tower-246.messagelabs.com with AES256-SHA256 encrypted SMTP; 29 Mar 2019 10:57:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEExDvrETVRHCLX+heBp9u+dfhOV5MRapgESVRvaXfY=;
 b=c7kO3et4vRXFubK+kIHYPS7IDSbOig3R3CBIl/WHmxwAyipvMAfYEDuFu5Y9n2m1DR353IuWr5Wats+Sfi2OG5uc3Jc1NxKsTJG3XowiJKgNZx0MuYYcfoZR1mw+mZt2Vu80j+RsA748XUXwxp+u2HvsWq234P5Mqq9i1bCZy0w=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM (10.167.201.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Fri, 29 Mar 2019 10:57:45 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 10:57:45 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: RE: [PATCH 1/6] regulator: da9063: remove platform_data support
Thread-Topic: [PATCH 1/6] regulator: da9063: remove platform_data support
Thread-Index: AQHU3aIc2wkSIc3KlkendcBVviXhdaYifYyg
Date:   Fri, 29 Mar 2019 10:57:45 +0000
Message-ID: <VI1PR10MB23522CBA67AC5EBB1F7DEE39FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318154759.21978-2-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6f51991-0461-4733-3451-08d6b4355feb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0512;
x-ms-traffictypediagnostic: VI1PR10MB0512:
x-microsoft-antispam-prvs: <VI1PR10MB0512ADB40CEF979CC572B7F5F55A0@VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(8936002)(186003)(256004)(86362001)(68736007)(71190400001)(52536014)(305945005)(3846002)(6116002)(71200400001)(66066001)(7736002)(53546011)(6506007)(55016002)(11346002)(229853002)(316002)(478600001)(486006)(476003)(14454004)(33656002)(76176011)(446003)(106356001)(7696005)(54906003)(53936002)(2906002)(110136005)(105586002)(8676002)(6436002)(4326008)(81166006)(97736004)(81156014)(26005)(5660300002)(99286004)(25786009)(6246003)(4744005)(102836004)(9686003)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0512;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V1w8DNelDI5sMzlj3prce8MLHe5GNHlHIIsa20rvDpbh4RDGvVnzZY99icgR5AItST0DfHavELFPK8x4Mohjd6p9KQaqLkGGUz6JG0IRVWIX4IqC5HxBVSt0Eq92VwNcraPvsnGQ/Jd7A/3/htoQ5jUAQjCnKQbOXGPVQeTEJ3KSfdFL0IwCRyVIOa8qlPGe7Pc3f7xY+AS/xFxRo2QQ4zO9fyyn4cEufxA1IHtsBDcKla630cNGwqjtSGha1CeUf3kEs3lVlv4cyZEF8hHfmyZXykd3juSUuSqPQRwnZr0ql6Vb2GQUk+mksNhAqWKkGRAStTkw+AA8CWL9UY7rKE8F/LwL1ssUUfao6Vz8gbXVtCtljcWRo4E4krH7B38S5DN7cPx3ubNEZsxpTIBnz4p3WljzDcPt0IMBjv1UGQQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f51991-0461-4733-3451-08d6b4355feb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 10:57:45.3969
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

> Subject: [PATCH 1/6] regulator: da9063: remove platform_data support
>=20
> There are no in-kernel users anymore, so remove this outdated interface.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/regulator/da9063-regulator.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
