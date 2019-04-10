Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE37AC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0502083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="KU6pPfO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbfDJMUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:20:47 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:59135 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbfDJMUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:20:46 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id AB/80-24446-B9FDDAC5; Wed, 10 Apr 2019 12:20:43 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUgTcRzH/e/u5imeXdPw50iJUVTmLW+Rrhf
  RA70YRCC96knsppebbFN2EzUJtecssSx0rZkpYea0B1+IubKRlq0SSyFNypWZoWkPJtiLqHa7
  afXu8/99v//fEz8SU7TLlSRfYOOtFs6kkofjhrVIwzh8LfuSKrrV2oEOp1w7dKMzVDtW90ymf
  T/xC9uM6643NxO6O3MlobrvrfGp2B7CaNHnFOwnDB6PC+UekRcMjkaUoCqiDIWROH0Tg5qTK8
  tQOKmgK2RwdXxAJj18CHyNjUh0yWkWLk99CXA0vRNG3b9DRRNGuxH0eI8GUkXRemj1vSUkUwa
  MV3UHP2hgsvo8VoZIf7kV4HSmiGGKToO2tldykRV0EXj7zgW+htHb4KfdIRMZ0XEwW+rCRMbo
  GBgeqw3Egabh6t0+TOIlMPH+FyH50+HE/elQKZ4IvYNjSGIVNAw5CInjoL/2dDC+A+rOfwj6X
  yCotMdKnACuNnvQr4THLx4G2QSzt2pwiZfCj5kOubgHoL8QcO/OGVwaJgO+1vQGk8ZDU/k7XD
  I9x+Dwm4+ENE0iXHHPyM+i1Y5/hnP8I0m8BhrqPmGOwMIWg/fiGH4F4U1Iq7casww2M2c0MWx
  SEsOyGobdkMxo2GQ1d5DRq/k8Jp8XbAyr5vIFtVBozjBlqi28rRX5rygzt3uoHc1ey3qAYkmZ
  aglled2yTxGpz8ksNHCCId2aZ+KFB2gpSaqA6hvxa4utfBZfcMBo8p/ivAxkhCqacosyJeRyZ
  sGYJUlPEEN66t/VYArckmPhlTHULtFEiyZDnmUhxfxB96M4ZRSFQkJCFBG5vNVstP2vT6IYEq
  miqF4xS4TRYluoNOlvQuZv4kKiS2zCxv2VlCXowLH8R/quzpFT7tKj7Z7KVwnMD++6oewt9VG
  aWu2ct6kzpdeZ2rPr897jF1qaG5eTrnVriqdLj2UObz+EKhqmNrHFPqS4lDbiTDaYr9GjGwd0
  zvKW8afZYYzmbo4jOtnzMTWVXB/7zd6l/134svbx1mWRu6m3KauKOqoX3R7OjlPhgoFjEzCrw
  P0B19xjUMsDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-2.tower-288.messagelabs.com!1554898842!6689738!1
X-Originating-IP: [104.47.1.50]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31496 invoked from network); 10 Apr 2019 12:20:42 -0000
Received: from mail-ve1eur01lp2050.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.50)
  by server-2.tower-288.messagelabs.com with AES256-SHA256 encrypted SMTP; 10 Apr 2019 12:20:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjB0QuhR18rgYiSXjsFHr/E27Emg0RuYfmb1MsQ8hq4=;
 b=KU6pPfO4LAks5cT2wNGhNT4SRnicdBVGIo86sMVO0BF18xhO9vKnz2TzPGm61IVuIG4n09AG/Mt+Svgl/ZaR3OZ5iKK0kQuPU3ssV95iuKUGH1nCFqjfp/IsDtT8jet0gXo5TdZnr6bMDDm2XFjiqHdm7aDA+NcylLeY0H4V0yk=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2429.EURPRD10.PROD.OUTLOOK.COM (20.177.62.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Wed, 10 Apr 2019 12:20:39 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25%2]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 12:20:39 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 11/22] watchdog: da9062_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Thread-Topic: [PATCH 11/22] watchdog: da9062_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Thread-Index: AQHU7kLa43YqYuciqEqk4d0bkd+M+aY1UU2Q
Date:   Wed, 10 Apr 2019 12:20:39 +0000
Message-ID: <VI1PR10MB2352D1A1496EB4AC848DFE6CFE2E0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-12-git-send-email-linux@roeck-us.net>
In-Reply-To: <1554752326-13319-12-git-send-email-linux@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2957eae1-81f9-4fb2-4479-08d6bdaef1e0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB2429;
x-ms-traffictypediagnostic: VI1PR10MB2429:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR10MB2429FEFA6265B81B0B1C3251F52E0@VI1PR10MB2429.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(366004)(396003)(199004)(189003)(97736004)(3846002)(6116002)(7736002)(2906002)(76176011)(74316002)(4744005)(99286004)(68736007)(66066001)(71200400001)(8936002)(305945005)(5660300002)(81156014)(81166006)(106356001)(6436002)(105586002)(8676002)(966005)(71190400001)(446003)(478600001)(11346002)(14454004)(110136005)(33656002)(7696005)(107886003)(6246003)(53936002)(186003)(54906003)(25786009)(316002)(476003)(256004)(229853002)(4326008)(26005)(102836004)(6306002)(486006)(55016002)(9686003)(6506007)(86362001)(53546011)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2429;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A0hkEC/YD/28/qxPMZrqOBr0vuBXME6HpEEq03leVjxzqbl5zlXHKnbuGvqzieu1+Cv2x252E2SSY4BD+6fSnlRmtKtgX1APt/r0kJXUP2uvRdRdKeAIFhsaPJysmkJ5cQg6+00Zq2lu7o79PWSPD1kVUgcpdUWi0S8ipf9T0iyz3T1t0btZX/fV2axeIxCDQqiqnjMYO+0R6GWyADDJhvTAsW/Y6CZZWJpc97of+EuqS+ItrrqqIrgK5pEkWdZ38rSiraCz/1trfZRZpeR18mxQI90wIMfRssy27bwFaSQ3q3+asiwtPsgboKtpjAc3+drY5lGCWWfU02tcQL5rIUEVld/sEnTiudP3k/ZRBrlCc/IHLJ9y7kGUJtNPXYN46g+OwznUb1HkHHU3ei/G+XQv42SEn14Exe5gIpHRkuE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2957eae1-81f9-4fb2-4479-08d6bdaef1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 12:20:39.8148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 08 April 2019 20:39, Guenter Roeck wrote:

> Subject: [PATCH 11/22] watchdog: da9062_wdt: Use 'dev' instead of
> dereferencing it repeatedly
>=20
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatedly. Also replace 'ret =3D func(); return ret;'
> with 'return func();'.
>=20
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>=20
> Cc: Support Opensource <support.opensource@diasemi.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Thanks for that,
Regards,
Steve
