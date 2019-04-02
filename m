Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0418C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF7B20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Da/RVecE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfDBLww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:52:52 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:51873 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728748AbfDBLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:52:52 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 57/2F-17148-01D43AC5; Tue, 02 Apr 2019 11:52:48 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRWlGSWpSXmKPExsWSoc9oocvvuzj
  G4PxEE4v2d8vYLebOnsRo8ezWXiaLy7vmsFlsffmOyeLY6itsFn3n3C1WnpjF7MDhMW9NtcfE
  s7oehw53MHo8W7iexePkqScsHp83yQWwRbFm5iXlVySwZkw7f4q1oIupYtHmc6wNjJcZuxg5O
  VgE1jNLfO6U7WLk4hASmMAksfLMfXYI5x6jxMmeWawgVWwChhLz3rwH6xARiJD4sHIDM0gRs8
  BbJomre76wgSSEBfQlpmy+zwRRZCBx59B1sEkiAssZJd60L2CD2KcisXBHP9BUDg5egViJm/c
  NIbbtYpZ4uOssWA2ngJbEu5NHwWxGAVmJL42rmUFsZgFxiVtP5oMtkBAQkFiy5zwzhC0q8fLx
  P1aI+niJ9v1v2SHiOhJnrz9hhLCVJJbdgPhGAmjmpfndUHFfiae/drGAHCEhcJFR4v+5jVALg
  I6Yt4kNws6RWDr5NFRcRuLpb5iGq6wSe/bOALtCSCBZ4sPcs1Cb5SRW9T6EKrrALNE66RYbxA
  s6Egt2f4KytSWWLXzNPIFRYxaS72YhKZuFpAzE5hUQlDg58wnLAkaWVYyWSUWZ6RkluYmZObq
  GBga6hobGuoa6huYWeolVuol6qaW6yal5JUWJQFm9xPJiveLK3OScFL281JJNjMCkllLIuGkH
  45Tl6YcYJTmYlER512gtjhHiS8pPqcxILM6ILyrNSS0+xCjDwaEkwZvlDZQTLEpNT61Iy8wBp
  leYtAQHj5IIr7QPUJq3uCAxtzgzHSJ1ilGX48Cih3OZhVjy8vNSpcR5A0CKBECKMkrz4EbAUv
  0lRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8bSBTeDLzSuA2vQI6ggnoCIvS+SBHlCQipKQ
  aGPs6G8+mn+LeELBTwGmZeO/MROVNsTPnay/ee+VqcWltjeFva/39InfDvgZMNtvrzdHCeNW9
  KPK+6ItqgcoT3GzzuJVFPiVNEeTsLKuf7GTgtP6Soo5PaJtH1u0jDwMNqyZn/X3KN6njlrPS5
  qRZNX9vVqxkDv3zPHbZ21vuLkvNz01p1gryUmIpzkg01GIuKk4EAPLdvDDwAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-8.tower-229.messagelabs.com!1554205967!3675386!1
X-Originating-IP: [104.47.1.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28262 invoked from network); 2 Apr 2019 11:52:47 -0000
Received: from mail-ve1eur01lp2056.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.56)
  by server-8.tower-229.messagelabs.com with AES256-SHA256 encrypted SMTP; 2 Apr 2019 11:52:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0vGpnG1asuG4Oq7RSpe15xS8mKYKxPkpAzrwJse0tU=;
 b=Da/RVecEnWcJmVP+qkIwnC/WgAq7sFRPyeaIErZyUQBWuTB7sqkuIcMqriHb4APn4NX3Xb4f6UJdm+ZJ/y9lK6BY0ck53SIWiPmmLqloexqONE8Ea+gykzq4L7Mb1Eewgsh+U3wdDQ0rryD5mNETyk7a4WQASf+P2gQc45CW9A4=
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM (20.177.121.154) by
 DB7PR10MB2092.EURPRD10.PROD.OUTLOOK.COM (52.134.102.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Tue, 2 Apr 2019 11:52:46 +0000
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1dc3:973e:6ed6:a60b]) by DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1dc3:973e:6ed6:a60b%5]) with mapi id 15.20.1750.021; Tue, 2 Apr 2019
 11:52:46 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] rtc: da9063: set range
Thread-Topic: [PATCH 1/2] rtc: da9063: set range
Thread-Index: AQHU388srtB02IcKs0uFchLWhDDC3qYnDdiAgAAE+gCAAAkNIIAANSwAgAAK4ICAAAUwgIAAGJUAgAACcwCAAAnyAIAAMsQAgAALXICAAN89gIAAC1WAgAAE04CAAAEDQIAADU8AgAAI04CAAApYwA==
Date:   Tue, 2 Apr 2019 11:52:46 +0000
Message-ID: <DB7PR10MB2348782FBA43910CBD31348BFE560@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
References: <20190401150741.vwqzzngnma4jvkid@ninjato>
 <20190401151628.GK3430@piout.net> <20190401155204.GA5964@kunai>
 <20190401185346.GP3430@piout.net> <20190401193424.sqnapthocznhjqok@ninjato>
 <20190402085325.GT3430@piout.net> <20190402093359.GB2960@kunai>
 <20190402095115.GW3430@piout.net>
 <DB7PR10MB2348398516E5744F4CF8C18BFE560@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
 <20190402104230.GY3430@piout.net> <20190402111405.GF2960@kunai>
In-Reply-To: <20190402111405.GF2960@kunai>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da5fe007-bd94-4113-a8cc-08d6b761b901
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR10MB2092;
x-ms-traffictypediagnostic: DB7PR10MB2092:
x-microsoft-antispam-prvs: <DB7PR10MB20923BB8EF1FF52305950AD3F5560@DB7PR10MB2092.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(199004)(189003)(25786009)(76176011)(478600001)(81166006)(446003)(97736004)(305945005)(3846002)(54906003)(6436002)(14454004)(7736002)(486006)(229853002)(6506007)(7696005)(74316002)(26005)(33656002)(102836004)(256004)(4326008)(8676002)(68736007)(186003)(6246003)(71200400001)(558084003)(110136005)(2906002)(71190400001)(86362001)(316002)(105586002)(106356001)(55016002)(5660300002)(66066001)(99286004)(9686003)(6116002)(93886005)(8936002)(11346002)(53936002)(52536014)(81156014)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR10MB2092;H:DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bl/y1OBlCwBj3l6SugyS4cS+zwmVN+ZgKvpo4JO2C5HQ1vP5KET/QpATw9BmT/djw/TQdFSHIyza69/w1zOLVJNFMLp9uiZOhU3jx7B2Sv4ThjYrDi+5A5RkUfLY6b5F82qRO+PnbIJXzMbhwhcVX5og1XYyCXOS/8wLhdjxunqjAMDgh6xrL4OMupa40Dlx81Lur+EiHnpmI1LjSUYMA0TUYLAkqHjIm9jiqpeBb+ioUcs2F/JtVf02AjdhmL0BKdvQiJ7wHMmN57jL5TdSLVa0+DzVYPo4sf9WaVmIfVmBxWvpRqaVY+dtIDAGjRVHRG4VghjB47Mm08Cp3tLVHv/pqbci8hB1jW0qQ35nOsv+vWnVFzIxMJFXmg0+IKL7tyosn2U5dC1jRXfEZJjzy3peTQ4pllCVbOYcclu9bZY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5fe007-bd94-4113-a8cc-08d6b761b901
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 11:52:46.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 April 2019 12:14 Wolfram Sang wrote,
> Subject: Re: [PATCH 1/2] rtc: da9063: set range
>=20
> > But my plan is to actually expose the capability to userspace and the
> > core so this doesn't have to be handled in the driver.
>=20
> I like that plan!

fwiw, +1
