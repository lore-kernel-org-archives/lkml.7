Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179E7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAA3206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="bkx/jhwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbfDQLZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:25:48 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.115]:43457 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbfDQLZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:25:48 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-central-1.aws.symcld.net id 09/F3-23601-83D07BC5; Wed, 17 Apr 2019 11:25:44 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa2wMURiGe3ZmZ6e1I9Nt6aehiXFJQ3e1VmR
  dQoNIf7gmBNXSaTu6m+6ldqax/CFF6JbeFOlGLaIuqy7Z0KIX1wZle1EUaUNZFBG3oFTKzM6i
  /pw857zv+b73nHwkprlDRJOcQ+DsVtbMEGG4cULYNK2BqkmJz38/1LC7208Y3NeblYav97YrD
  O0X9xGGyo42hWFr/XVVIpFUtb8KJV1wdamSvJ58IumzN2YRnqw0WdNtjjSl8fCPV1jOllBH19
  5KbBOqVDlRGInTpzF4VNSOSxsNXaSAymKfSt48QeDZ34g5UShJ0IlQ796mlDiSToOuvgJCMmH
  0TwS/GmoJSYigF0CdpyRoWgSvynuQzFOh83ZTwIPTY8Db3xBgik6FnR1VwW43EbT0nAwIofRE
  2PG5CJcY0UPhW1OVQmKMjoLHfneAgabhcF0LJvMQeP28Xyn7M+BERaNKPo8DX4dfDEGKzEDjN
  Yd8PALuuguQzPOhq9yLSRmAfowgr7klWH8cNL+7EWQznOt8Ssg8HJzPrijkC6+V4OspDgTViI
  0/VPiCjWPAs7Mbl02tGPh6m1TyC+LgQO0nQubxcOTgW6wYxboGPM41wOYaYHMFfiwcbpX78QM
  I96Ap6XZTllGwsCazNiE+XpuQoNdOFtfJOnaDNl3H5WozOKtgZ0VVx67jdfx6S4Y5U2flBC8S
  JytzLSGcR4eOZl1Fw0gFM4Tq/1idohmcbstcb2R542p7rpnjr6LhJMkApVbXpGjC7VwW51hjM
  ovj+UcGUs1EUmMGiTLF57AW3pQlS01IS14+1F2BaXCrzcpFR1EayURLJmOu9W+JP0N+F42Ijq
  BQSEiIRp3D2S0m4X/9DYoiERNBlUlV1Car8LfTGzGEQgxRFndCCiGw/6ToTaiCZHS/hr2MUJc
  uWdo3y7f4SOvZXYWbnY194Xzq2MK9nceYfYl5lppL31smTVuWOPvB8lMz2rJt87Jv+lIXtB7X
  p9YubOjfkV9Y/1A/+l7y9l41CoUv1zauvFIwd6NrxQtndYne1txbU7pnFOdFq87oSdP93bFrh
  On+OXnukTPbzjxjcN7IJozD7Dz7G/bJAoTfAwAA
X-Env-Sender: eric.jeong.opensource@diasemi.com
X-Msg-Ref: server-25.tower-239.messagelabs.com!1555500343!4388493!1
X-Originating-IP: [104.47.10.59]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21973 invoked from network); 17 Apr 2019 11:25:44 -0000
Received: from mail-db5eur03lp2059.outbound.protection.outlook.com (HELO EUR03-DB5-obe.outbound.protection.outlook.com) (104.47.10.59)
  by server-25.tower-239.messagelabs.com with AES256-SHA256 encrypted SMTP; 17 Apr 2019 11:25:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScgjeSrJDLJLzCLBiwXHOXHkVGgGekjdPC2bu4q+55E=;
 b=bkx/jhwfEuacsOvzQ4ONX2+XoNqdax/h+dazowKw+q5tDk8rjvn+04O1urahDHsVgQNgcUyUl/c3IF4/imOalKbbzc7lW6WMr9dzyJ8EPurOwQn6xwOBKjQwZrJUtdSzuJs7Kachqyo7eukiYiTpeEBvKm1WWuutL8vtf6HXkAk=
Received: from VE1PR10MB2880.EURPRD10.PROD.OUTLOOK.COM (10.255.158.29) by
 VE1PR10MB3102.EURPRD10.PROD.OUTLOOK.COM (20.179.31.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 17 Apr 2019 11:25:29 +0000
Received: from VE1PR10MB2880.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::89a5:a0b2:9b64:d257]) by VE1PR10MB2880.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::89a5:a0b2:9b64:d257%3]) with mapi id 15.20.1792.021; Wed, 17 Apr 2019
 11:25:29 +0000
From:   Eric Hyeung Dong Jeong <eric.jeong.opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>,
        Eric Hyeung Dong Jeong <eric.jeong.opensource@diasemi.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH V1 3/3] regulator: slg51000: add slg51000 regulator driver
Thread-Topic: [PATCH V1 3/3] regulator: slg51000: add slg51000 regulator
 driver
Thread-Index: AQHU9Bx2fFZf2nBWBUGu3nix4k72BaY+6NUAgADqhPA=
Date:   Wed, 17 Apr 2019 11:25:29 +0000
Message-ID: <VE1PR10MB288069C2FC4B6F79AE8F26A891250@VE1PR10MB2880.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
 <5e4a6a007e45feac6d35203305cafd865be48755.1555389447.git.eric.jeong.opensource@diasemi.com>
 <20190416152448.GC4834@sirena.org.uk>
In-Reply-To: <20190416152448.GC4834@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.116.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2468c1e7-bc51-4027-7d31-08d6c327656f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(2017052603328)(7193020);SRVR:VE1PR10MB3102;
x-ms-traffictypediagnostic: VE1PR10MB3102:
x-microsoft-antispam-prvs: <VE1PR10MB31026B1A54EA8F70B4EEB12BB6250@VE1PR10MB3102.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39850400004)(396003)(366004)(45074003)(189003)(199004)(68736007)(107886003)(8676002)(81156014)(55236004)(8936002)(52536014)(81166006)(25786009)(105586002)(478600001)(6506007)(106356001)(305945005)(97736004)(53546011)(53936002)(5660300002)(6246003)(186003)(6116002)(4326008)(14454004)(3846002)(26005)(86362001)(9686003)(55016002)(7736002)(66066001)(33656002)(76176011)(99286004)(2906002)(486006)(476003)(102836004)(316002)(71200400001)(256004)(229853002)(6436002)(7696005)(54906003)(110136005)(71190400001)(11346002)(446003)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR10MB3102;H:VE1PR10MB2880.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nuqRX5a4aJe/4Id8YTI99kl5cxk1YPxxbJYivICZE+MCCXyGfmmgiTFRYhYMaP8bj0BDf/NWxYRU51kUE1fhS62i//OEi2OpWTgJC35zwb7b+8ieqPZxFr/mPo6hAq9sD+PWbMK8VF0p8biXQSViO+GfMu689+l8gbtrXn9e4c+DIu+iGuUK0IFcw7OAXPiUC7C+uKvGESM9AM/OY8bgmJUJXEsgCIo4RpkyL75L14Z5ffAC8TZi1noyWM5VAsf338oqe2Q6yKGgz2yD7CHHm9+yXMWxJa53S8DBRVvwy6VKzsw8WAIad+F9nAtGqtFEozEfusexwpCNTuL7lUesl+gM43mCMvMfLqsZ0T5eNUXzpwTgkSRyjOQmwt5hC6Acc8JBakamLv7zVWKoYq1gF4nUcowMvXKcqaA0cRYJQ2Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2468c1e7-bc51-4027-7d31-08d6c327656f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 11:25:29.1069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 17, 2019 12:25 AM +0900, Mark Brown wrote:
=20
> On Tue, Apr 16, 2019 at 01:37:27PM +0900, Eric Jeong wrote:
>=20
> > +static int slg51000_regulator_is_enabled(struct regulator_dev *rdev)
> > +{
> > +	struct slg51000 *chip =3D rdev_get_drvdata(rdev);
> > +	int ret, id =3D rdev_get_id(rdev);
> > +	unsigned int state;
> > +
> > +	ret =3D regmap_read(chip->regmap, es_reg[id].sreg, &state);
> > +	if (ret < 0) {
> > +		dev_err(chip->dev, "Failed to read status register(%d)\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	if (!(state & SLG51000_STA_ILIM_FLAG_MASK) &&
> > +	    (state & SLG51000_STA_VOUT_OK_FLAG_MASK))
> > +		return 1;
> > +	else
> > +		return 0;
>=20
> This looks like it should be a get_status() operation as it's reading
> status bits rather than the command we sent to the device - for that
> just use regulator_is_enabled_regmap().

I thought that it needs to return current status of a regulator when the fu=
nction is called.
I am wondering that the *is_enabled()* function is just to check=20
If a regulator has been turned on or not rather than getting current status=
 of the regulator.

Thanks
Eric
