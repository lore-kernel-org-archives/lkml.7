Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7DAC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6D321D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="PbLbHEeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505136AbfIYQTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:19:09 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.3]:50347 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502064AbfIYQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:19:08 -0400
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-west-1.aws.symcld.net id EB/3A-26280-7739B8D5; Wed, 25 Sep 2019 16:19:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRWlGSWpSXmKPExsWSoc9grVs2uTv
  WoO+jnMXUh0/YLOYfOcdqsWrqThaL+1+PMlp8u9LBZHF51xw2iw+7rjJbtO49wu7A4bFz1l12
  j02rOtk87lzbw+bR/9fA4/MmuQDWKNbMvKT8igTWjCW9bWwFk2UqLr5cyNrAuE2si5GLg1FgK
  bPE8zkn2SGcYywSv6Y/Z4NwNjNK/O79CeawCJxglvhz4TAriCMkMJVJYlXTJiYI5wmjxMzet0
  BlnBxsAhYSk088ALNFBOIljs89ywxSxAzSvm3SL3aQhLBAosTm+W+YIIqSJH59eMoIYTtJzJx
  8B6yGRUBVYlnfS2YQmxeofuedC4wQ274xSjT+3AvWwClgK3Hzxg4WEJtRQFbiS+NqsAZmAXGJ
  W0/mgy2QEBCQWLLnPDOELSrx8vE/Voj6VImTTTcYIeI6EmevP4GylSTmzT0CZctKXJrfDWX7S
  pxpP8kCcoSEwFNGibf3zsE198/eD7XAQmJJdysLhC0lceLiUaBlHEC2isS/Q5UQ4QKJ80f/Qt
  2mJnHjTQfzBEaDWUjOhrB1JBbs/sQGYWtLLFv4mnkWOCwEJU7OfMKygJFlFaN5UlFmekZJbmJ
  mjq6hgYGuoaGRrqGlsa65kV5ilW6iXmqpbnlqcYmuoV5iebFecWVuck6KXl5qySZGYDJLKTjo
  sYOx88hrvUOMkhxMSqK8ATndsUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeDdOAMoJFqWmp1akZ
  eYAEytMWoKDR0mE98JEoDRvcUFibnFmOkTqFKMux4SXcxcxC7Hk5eelSonzzgWZIQBSlFGaBz
  cCluQvMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmVQJZxZOZVwK36RXQEUxAR+Tlgx1Rkoi
  QkmpgmrddJyZnhqiwTlHhLJsnF0vuzPnHZ7ry6YJHJl5+dxtmbsiabNQybcVW04b3chJR2XNZ
  V0pJ7T7bnBVf4tu1O8no/EuRdx3FLR8svT2+Cjv/++Swtzy2SSisqipE22fu+jkrlFk23lLVa
  K14/uXvrw37ct49W+AZOW3H8ecFTVH7Lj35svRrpK7TWhn+W8KnjzjoCUavldjydFJHaUpx5c
  z98W5HZNJcPxwxcF0YYH1/KfuNp9drK4KZGuZyz9k+5VFoDOujuhJFGYeLeg+P1XU6NXx9K75
  ijizzirhH5zaefvtnbevhh31ng3N72UVd570x6V47cfJKUZHta/+4PDf5cS+8N9T252H+1+d6
  WJRYijMSDbWYi4oTAerIpP9tBAAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-25.tower-262.messagelabs.com!1569428340!6956!1
X-Originating-IP: [104.47.0.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.12; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12885 invoked from network); 25 Sep 2019 16:19:02 -0000
Received: from mail-he1eur01lp2059.outbound.protection.outlook.com (HELO EUR01-HE1-obe.outbound.protection.outlook.com) (104.47.0.59)
  by server-25.tower-262.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 25 Sep 2019 16:19:02 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvWzEQ3cmva2lr7bwCVrvX+hBvB6N698193iK+01UxzEH3h7QzoU49iOvYzhSf02z1RnS2VaTgd9qumMgMh7RGlx7jpsL9hIUk7YJN4g2UJfbyYFG/PO6PspdTudv6X8udUgN4yWKGrlqEDNgZ9GuGMtHqGQP5KjaxvfwNjSZpuasi90i2kw6N48O0rYCRq1+PzZWndD3+rj5loEZdjVutam5XE5EY90PSjUkAImetsIFdfh05TlNbLImBQYf8fup7sW6EubLiYFwqJ6GDQtcQ1x+eFap285CcLnxcT6CVAgKJ1VuJV4YxhVlhpRxquEf3To+fbCmTES7D63VGE2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYfh4xr/BWUeKoZCmm8lWo9GvItq83hi+SGpJv+bRpY=;
 b=HAlViV6pJyuM0s4JVBJZLulqODSGbP/irzb5aNc8Ie9Pkv36kgUdAwjseKJRmuP82NwUvDoTPH/Uxv7iOr5NGJID+dx8lbJk+pFVtsoFF1i74Ja3lnEkpNS6I1hOkL1iOb1I72RjhbhXx9zqrZfyKeL3XurWz340HQm+1b/AftU+8fH22xZAZSDSw+pag5v5eTSusg50Tjl85qcbNve6ltNceHx8IaTf/mcu1bUonY3lMvyXjcqQzMePMsabk4WcsPWKBE43rbrDeuxckk3rO16ssZDerCBQ8lEaQNjw5oNi6vM4FrEMcezMatnO0ZMC3uIdm5GPMcncO7ONO4Q2hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYfh4xr/BWUeKoZCmm8lWo9GvItq83hi+SGpJv+bRpY=;
 b=PbLbHEegUomdUsJCTl0S1+YnHOdeWxzdVD3f5DmQsX+7ZQGxIXKxgtIjERdvi1gXtgIBDbXBS173CrMD8U1GJewo5y6w4ZQ8VgefMQr2ejt/SUEPbP8IYf9vSVtBsnjvfOPhDVy8mzkpPuOZXOiGHgcOHvoEu0h9FJ+5c/eASG0=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1010.EURPRD10.PROD.OUTLOOK.COM (10.169.153.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.21; Wed, 25 Sep 2019 16:18:59 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::15de:593a:8380:b8ef%12]) with mapi id 15.20.2284.023; Wed, 25 Sep
 2019 16:18:59 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Thread-Topic: [PATCH 2/5] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
Thread-Index: AQHVbVV1957uISHJUEeJggkt0eobi6c6l9DggAH/z4CAAAcsgA==
Date:   Wed, 25 Sep 2019 16:18:59 +0000
Message-ID: <AM5PR1001MB09941810C3AE97110DD82E0F80870@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190917124246.11732-1-m.felsch@pengutronix.de>
 <20190917124246.11732-3-m.felsch@pengutronix.de>
 <AM5PR1001MB0994ABEF9C32BFB7BEA099B680840@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20190925155151.75uaxfiiei3i23tz@pengutronix.de>
In-Reply-To: <20190925155151.75uaxfiiei3i23tz@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c57c08f4-a840-4d92-1a93-08d741d4125c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR1001MB1010;
x-ms-traffictypediagnostic: AM5PR1001MB1010:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR1001MB1010267DD02FE7AA3E6C85E5A7870@AM5PR1001MB1010.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(99286004)(6436002)(102836004)(5660300002)(478600001)(33656002)(186003)(7696005)(71190400001)(71200400001)(6506007)(305945005)(74316002)(53546011)(14454004)(55236004)(52536014)(54906003)(3846002)(6116002)(110136005)(316002)(76176011)(25786009)(4326008)(966005)(11346002)(81166006)(7736002)(2906002)(476003)(446003)(6246003)(8936002)(81156014)(55016002)(64756008)(6306002)(66446008)(66556008)(26005)(76116006)(66066001)(9686003)(8676002)(486006)(66946007)(86362001)(256004)(229853002)(14444005)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1010;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aniAiNSo+nbcbZZRcCmmSq12JVIA8eZcTSt6XVjinvLM5EtIz3XNJuk23wfjV9KrvzaBOU7S3GL5BTpXOWiieBaBRBLf/oDxOjM+NaCBoLuUxsGoCB0OnTBVFrdVEnVAIvvtQ/IXfjwmdwqoaRrToXsP79idf/yXNqP9ybjM8FjzTF/7g17nkdLgqHG+8N73XKKAGDHEsLWooLo4g5vemKuJBomQMVHk9mzvVKde6RoqIslEisHM5ljHYqL7dobTqS4upSmU7FJaO5pmR1VKpvj1QxLwi5uF/xkTm1oy5R2NanlFFdpHy8ogbOvsOPbkJT8XpXGkQ5+NUDExCZkIuwf76M8W1znZlR0WLWeGDOwmoXhK+mWqihOySf+S9AZO/6fA9hZty+PvbmUX6viLxmpWtwRejXNsNCdde0VtHpSHUovvdQGMPbz1LYQF0iTOOum4u5GP+CXNq9gLza08Pg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57c08f4-a840-4d92-1a93-08d741d4125c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 16:18:59.1843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fj0Bu6SfO7+fz1qt1aZ3DoxdnWtRcTdKHqYmR06kiRfet0MyjXdWvP6J9mL8MvDS6pWkHU5PoyrSNjiMer9XTXAYOQvuH8GYQPVZCHsy0Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 September 2019 16:52, Marco Felsch wrote:

> Hi Adam,
>=20
> On 19-09-24 09:23, Adam Thomson wrote:
> > On 17 September 2019 13:43, Marco Felsch wrote:
> >
> > > Add the documentation which describe the voltage selection gpio suppo=
rt.
> > > This property can be applied to each subnode within the 'regulators'
> > > node so each regulator can be configured differently.
> > >
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/da9062.txt | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > index edca653a5777..9d9820d8177d 100644
> > > --- a/Documentation/devicetree/bindings/mfd/da9062.txt
> > > +++ b/Documentation/devicetree/bindings/mfd/da9062.txt
> > > @@ -66,6 +66,15 @@ Sub-nodes:
> > >    details of individual regulator device can be found in:
> > >    Documentation/devicetree/bindings/regulator/regulator.txt
> > >
> > > +  Optional regulator device-specific properties:
> > > +  - dlg,vsel-sense-gpios : The GPIO reference which should be used b=
y the
> > > +    regulator to switch the voltage between active/suspend voltage s=
ettings.
> If
> > > +    the signal is active the active-settings are applied else the su=
spend
> > > +    settings are applied. Attention: Sharing the same gpio for other=
 purposes
> > > +    or across multiple regulators is possible but the gpio settings =
must be the
> > > +    same. Also the gpio phandle must refer to to the dlg,da9062-gpio=
 device
> > > +    other gpios are not allowed and make no sense.
> > > +
> >
> > Should we not use the binding names that are defined in 'gpio-regulator=
.yaml'
> as
> > these seem to be generic and would probably serve the purpose here?
>=20
> Hm.. as the description says:
>=20
> 8<--------------------------------------------------
> gpios:
>    description: Array of one or more GPIO pins used to select the
>    regulator voltage/current listed in "states".
> 8<--------------------------------------------------
>=20
> But we don't have a "states" property and we can't select between
> voltage or current.

Yes I think I was at cross purposes when I made this remark. The bindings t=
here
describe the GPOs that are used to enable/disable and set voltage/current f=
or
regulators and the supported voltage/current levels that can be configured =
in
this manner. What you're describing is the GPI for DA9061/2. If you look at
GPIO handling in existing regulator drivers I believe they all deal with ex=
ternal
GPOs that are configured to enable/disable and set voltage/current limits r=
ather
than the GPI on the PMIC itself. That's why I'm thinking that the configura=
tions
you're doing here should actually be in a pinctrl or GPIO driver.

I'd be interested in hearing Mark's view on this though as he has far more
experience in this area than I do.

>=20
> Regards,
>   Marco
>=20
> > >  - rtc : This node defines settings required for the Real-Time Clock =
associated
> > >    with the DA9062. There are currently no entries in this binding, h=
owever
> > >    compatible =3D "dlg,da9062-rtc" should be added if a node is creat=
ed.
> > > --
> > > 2.20.1
> >
> >
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
