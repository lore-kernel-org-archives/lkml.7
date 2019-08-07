Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B60AC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A7721E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="YfbiZYcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHGKnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:43:09 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.70]:49615 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbfHGKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:43:09 -0400
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta.az-b.eu-west-1.aws.symcld.net id FF/5B-19136-93BAA4D5; Wed, 07 Aug 2019 10:43:05 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNJsWRWlGSWpSXmKPExsWSoc9jpWux2iv
  W4N5GbYvLu+awWVzbe5zZgcnj8yY5j/VbtjIFMEWxZuYl5VcksGZsbOxiL7jBV9Fzbx1LA+Nd
  7i5GTg5GgaXMEkf/ancxcgHZx1gkbpxZxw6RWM8o0TBBCCTBInCCWeLYzqNsII6QQD+TxIXVO
  1khnDuMEh8Pn2IDaWETMJSY9+Y9I4gtAmQve7OBFcRmFnCUuL33LROILSzgJXHs/Gc2iBpvib
  NLDjFD2E4SHY2PwFazCKhITL54G2wOr0CsRPvmvSwgtpDALkaJW7vUQGxOAWOJ/U/PM0KcKiv
  xpXE1M8QucYlbT+aD7ZIQEJBYsuc8M4QtKvHy8T9WiPp4ifb9b9kh4joSZ68/YYSwlSSW3ZjF
  CmHLSlya3w0V95V4tg0ULFxA9i1GibcHnkMltCTOd12BWiYlceLiUajmHIkrHf9YIGw1iRtvO
  oCO4ACyZSROb4Iq+ccqcWZ/3QRGvVlIzoawdSQW7P7EBmFrSyxb+Jp5FjgoBCVOznzCsoCRZR
  WjRVJRZnpGSW5iZo6uoYGBrqGhka6hpaWuoYmpXmKVbpJeaqlueWpxia6hXmJ5sV5xZW5yTop
  eXmrJJkZgukkpOD5xB+O8G2/0DjFKcjApifKavfCMFeJLyk+pzEgszogvKs1JLT7EKMPBoSTB
  u2GlV6yQYFFqempFWmYOMPXBpCU4eJREeK+ApHmLCxJzizPTIVKnGHU5Jrycu4hZiCUvPy9VS
  pxXEKRIAKQoozQPbgQsDV9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzbDDKFJzOvBG7TK6
  AjmICOKHrnCXJESSJCSqqBSZbxH9uzo1f5dD/+5kq6XFfLP+/KpAxrNw1Tm7nJKWqXP4hdOO9
  tzXxB49++1wftt/w8wpqf4Zn8Mz7K9opd1AadiFetn8WYTc2U9/D2c03+YObN9Ne+c9LPJxaV
  c70Tj//XWG0Y5fErsXVr93bndqfNnTwa53bNLHWYZnuj/sLDvk0tHsd+VNtZTF5m7PyJsXbpl
  INyZz4Fz3H8Zb3w7oXkw++y9O82hO3zFl6QGDMz9fxrPxaezkXb3/e+2fQ65N37dQEnTmZdj/
  3kJSjofHYTt5s4Y3GEW/hegz3xl1hnrdJ2tPo/p9jONb3vGHNxFa93xKqPDiFKCz2ZY8PEF2j
  qxpx2ktC4erYmr+S5EktxRqKhFnNRcSIAbOejpD4EAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-282.messagelabs.com!1565174584!134985!1
X-Originating-IP: [104.47.12.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.43.9; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19464 invoked from network); 7 Aug 2019 10:43:04 -0000
Received: from mail-db3eur04lp2058.outbound.protection.outlook.com (HELO EUR04-DB3-obe.outbound.protection.outlook.com) (104.47.12.58)
  by server-20.tower-282.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 Aug 2019 10:43:04 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY5rO6XFIaFGiardxf4hhZGMDU/3qSAOsDZt2e7fkNSG4Vvd1eUIU4THUDYf7w5MrzZ2L0cFzKx04MZSEPfmHJ7dWtZZCq9/3NAL0/6jE/zMikjL4KGD2x9rLTIZ5NTFAs8Kr8DxZ7URzvD2/q+jpTom062XsysTV3YIjAr93n1EXwFJZ7DQ5MK1113dGAtRlnLUr+iVJtOuIr1TLgJujyDFL26v243lexUb6NoMbEQjX1B1QYpjqSKuXtgiFYK30nVcAWWBtnfo9OIgJ/o030hA+w2+sk6We7WqWvu3N1BDssiEMjXAo5K6dHsQnuAxh6C++pfu7CuGgKWuDyw39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdHmmZfPRH4Sx95SAeZvrnROPuOHHGbK9gjaTwrmwU8=;
 b=nNA1Eam7cBquAnVJQU7WBtPlMbGScPNFt8YU9CEqQnBMafwMgoFn9vsB/wTNaJvmM4q1QF8Bjs3IKKR3SpAW5bsRECPKJWJ3vW1h8Dxi0DdZ3rpDj+VBieBwYoKz3tqPg6+bQiUbsYIdYkYdATYUYVladajw8yKttj762YYY+AJyBBTsPnBofSd7NK3wdMz/b2oQE9XAqvJgk4o38NMkVbFUVWuMMZYeWpeY3oolBLOpVe3OEgbz1bdgk3cAIqb024zYqzuAqI2ykgJmiCnhVPYrFh7JARlnpz/0z/PF408Siq0tECpO2P496nJjI6OvNGQeSoHH9nv9e9bOnh58Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=diasemi.com;dmarc=pass action=none
 header.from=diasemi.com;dkim=pass header.d=diasemi.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector2-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdHmmZfPRH4Sx95SAeZvrnROPuOHHGbK9gjaTwrmwU8=;
 b=YfbiZYcJybPNJBzhsIHKvU3WvHeBZi85RvdI+vk1wY51bh3kr6HqDGok1x2KP8nT7Z0zxhL/gP1CSovfxQm5Rpo6CrtBCL7ihTpML3wW3GbNHnqc6wjIbcWDMt21SNlsxHPQxYoh5CJaYXWvVnCjpCGRYCUsHVqXuwsCTOgNsqM=
Received: from VI1PR10MB2192.EURPRD10.PROD.OUTLOOK.COM (20.177.60.74) by
 VI1PR10MB3613.EURPRD10.PROD.OUTLOOK.COM (10.186.161.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 7 Aug 2019 10:43:02 +0000
Received: from VI1PR10MB2192.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ae:3860:5cb6:c1aa]) by VI1PR10MB2192.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ae:3860:5cb6:c1aa%5]) with mapi id 15.20.2136.018; Wed, 7 Aug 2019
 10:43:02 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
Thread-Topic: [PATCH v2 00/22] mfd: demodularization of non-modular drivers
Thread-Index: AQHUisAczvba87NOX02k8riZ/bkUjaVwDbfwgAO0IwCBfUBB4A==
Date:   Wed, 7 Aug 2019 10:43:02 +0000
Message-ID: <VI1PR10MB219250E43C2C31F73387DCF5FED40@VI1PR10MB2192.EURPRD10.PROD.OUTLOOK.COM>
References: <1543811009-15112-1-git-send-email-paul.gortmaker@windriver.com>
 <6ED8E3B22081A4459DAC7699F3695FB7021C509AD4@SW-EX-MBX02.diasemi.com>
 <20181207203021.GR23156@windriver.com>
In-Reply-To: <20181207203021.GR23156@windriver.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 208aeea6-122e-4073-212b-08d71b2405ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR10MB3613;
x-ms-traffictypediagnostic: VI1PR10MB3613:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR10MB361342909FC47E8FE3777CDAF5D40@VI1PR10MB3613.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(39850400004)(136003)(199004)(189003)(966005)(25786009)(102836004)(6436002)(6506007)(9686003)(66066001)(53546011)(7696005)(99286004)(186003)(55016002)(6306002)(26005)(53936002)(14454004)(68736007)(71200400001)(71190400001)(478600001)(4326008)(81166006)(8676002)(52536014)(486006)(86362001)(5660300002)(81156014)(11346002)(8936002)(476003)(66446008)(76116006)(6246003)(66946007)(229853002)(6116002)(3846002)(33656002)(66476007)(66556008)(64756008)(6916009)(14444005)(316002)(2906002)(446003)(305945005)(76176011)(7736002)(256004)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB3613;H:VI1PR10MB2192.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vBQMI9dPzcHwsQ7qupNfVmbj/KIqZoYWtYnA2+iexHzDdKfQcDlKBHSZDOpOQ9fs8Hd5Z3UpeZgYKLb0VSsCCZDJRcoIPmjD7Roh+wj3e5daTPLr+t8CLHIn2nY5vZH9HjRWN2IonhrgB9SokVQ7m7/eQjqwX4AS3k6d9NkAwVCZ+Ifq6K8MVMAFhZFNuXOv4NOpNnxaEWnU8qX2vc98zojNTkLZdNoA5HXN/NGvz4Hj4rvbkRjXx+TOOGKtiOAwRCfSKRIg1qyiXE7oUrWkjYR7HN0SAKwwgtfCDq6eT9yYtofe5NwB567c/WghoYNVfLa4t3vMYCalFNAXAFD1IbHA7HgICRvZquS+sCwadU5BPX5ChzLXHHAtZlgE9R/JL2lpyV70FkjnQkMBnO33sO0Kua6ujAf+kDhoYadxSmQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 208aeea6-122e-4073-212b-08d71b2405ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 10:43:02.7749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stephen.twiss@diasemi.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I will not be able to make these changes to support modularity any more.

Although the support.opensource@diasemi.com e-mail address for Support
is still working, I will not be able to review your patches if you were to =
re-send
them again.

Regards,
Stephen

On 07 December 2018 20:30, Paul Gortmaker=20
> > On 03 December 2018 04:23, Paul Gortmaker wrote:
> > > Subject: [PATCH v2 00/22] mfd: demodularization of non-modular driver=
s
> > >
> > > [v1 --> v2: add some more commits as requested by Lee (MFD maintainer=
),
> > >  update the 00/NN text; re-do build and link testing on new linux-nex=
t. ]
> > >
> > > This group of MFD drivers are all controlled by "bool" Kconfig settin=
gs,
> > > but contain various amounts of largely pointless uses of infrastructu=
re
> > > related to modular operations, even though they can't be built modula=
r.
> > >
> > > We can easily remove/replace all of it.  We are trying to make driver
> > > code consistent with the Makefiles/Kconfigs that control them.
> >
> > For the DA9052 and DA9055, changes:
> >
> > -  drivers/mfd/da9052-core.c         | 11 -----------
> > -  drivers/mfd/da9052-i2c.c          | 22 ++-------------------
> > -  drivers/mfd/da9052-irq.c          |  1 -
> > -  drivers/mfd/da9052-spi.c          | 22 ++-------------------
> > -  drivers/mfd/da9055-core.c         | 13 ++-----------
> > -  drivers/mfd/da9055-i2c.c          | 24 ++---------------------
> >
> > The responsibility can fall back to Dialog for these changes. We will
> > submit Kconfig patches for these and make them explicitly non-modular.
> > This will remove the ambiguity caused by the Kconfig bool options.
>=20
> Just FYI, I dropped the diasemi commits from my v3 send.
>=20
> https://lore.kernel.org/lkml/1544213465-16259-1-git-send-email-
> paul.gortmaker@windriver.com/
>=20
> Thanks for taking on the modular conversions.


