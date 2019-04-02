Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3766AC10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07712084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="xvsDQN7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfDBKdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:33:45 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.4]:6283 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730342AbfDBKdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:33:43 -0400
Received: from [46.226.52.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-west-1.aws.symcld.net id B3/8D-04122-38A33AC5; Tue, 02 Apr 2019 10:33:39 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLJsWRWlGSWpSXmKPExsWSoc9orttstTj
  G4NpjEYv2d8vYLebOnsRo8ezWXiaLy7vmsFlsffmOyeLY6itsFn3n3C1WnpjF7MDhMW9NtcfE
  s7oehw53MHo8W7iexePkqScsHp83yQWwRbFm5iXlVySwZuxoXcdYcJO/oqfpOXMD41ueLkYuD
  haB9cwSKw62soE4QgITmCQWr5/IDuHcY5S4uO4eUxcjJwebgKHEvDfvGbsYOThEBCIkem6Ggd
  QwC7xlkri65wsbSI2wgL7ElM33wepFBAwk7hy6DjZIRGAyo8S53n9gRSwCKhK7zy0BK+IViJV
  Y/2k3E8S2S8wSy2/3MoMkOAX0JF7N/swOYjMKyEp8aVwNFmcWEJe49WQ+WLOEgIDEkj3nmSFs
  UYmXj/+xQtTHS7Tvf8sOEdeROHv9CSOErSSx7MYsVghbVuLS/G6ouK/Epb6pYEdICFxklFj/b
  REbREJLYmrTd6gGKYkTF49C2TkSK5pXQB0hI/H09y4WiOaPrBJPL09kAUkICSRLfJh7FuoKOY
  lVvQ+hii4wS9w93cIK8Y6OxILdn9gmMGrOQvLdLCQpCFtbYtnC18yzwEEmKHFy5hOWBYwsqxg
  tkooy0zNKchMzc3QNDQx0DQ2NdA0tjXWNjE30Eqt0E/VSS3XLU4tLdA31EsuL9Yorc5NzUvTy
  Uks2MQKTWkrBwVc7GHetSD/EKMnBpCTKu0ZrcYwQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCV49S
  6CcYFFqempFWmYOML3CpCU4eJREeG+BpHmLCxJzizPTIVKnGHU5Dix6OJdZiCUvPy9VSpxXFq
  RIAKQoozQPbgQs1V9ilJUS5mVkYGAQ4ilILcrNLEGVf8UozsGoJMzLDTKFJzOvBG7TK6AjmIC
  OsCidD3JESSJCSqqBsdk74N/5yZFnnaKdor6d5dr1ID9h0fc/8dcSXMqPa+rLrlVRzZ7MlP7r
  qHFLyYX9/V3PuNl+XnJRMb14qKTpaci8DVKVmzUz//Efn1N7/WlWjbLfu4Yv/z+1Ploalbgwl
  u2ZTMutoCOvdSRWvuw8d+Tkh7c77ky1KZb0XKjmltLq5aWv9tRnihJLcUaioRZzUXEiAOESho
  /wAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-10.tower-268.messagelabs.com!1554201218!4442828!1
X-Originating-IP: [104.47.1.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27918 invoked from network); 2 Apr 2019 10:33:39 -0000
Received: from mail-ve1eur01lp2055.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.55)
  by server-10.tower-268.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 2 Apr 2019 10:33:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6w4DOgBTU7i+GdJuJQeRad1CE2lvqKySW+C9JUjZcV8=;
 b=xvsDQN7iV0Jn10uxr6NOASb67rlG3SBTxXJUA0sH5JlCKn8lzBWo+Jm/Vl70Kk4tbqjCvvmFqZrwDASIOnicOW0OL+PbMf0F0lLKGNnV/qRGgFTogr9+v2wOvzsJs3jcQ56Gxu6iQz4SJurZRy5U7tz7JOnRYBdgizZ0IpIoS68=
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM (20.177.121.154) by
 DB7PR10MB2060.EURPRD10.PROD.OUTLOOK.COM (52.134.102.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 10:33:37 +0000
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1dc3:973e:6ed6:a60b]) by DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1dc3:973e:6ed6:a60b%5]) with mapi id 15.20.1750.021; Tue, 2 Apr 2019
 10:33:37 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] rtc: da9063: set range
Thread-Topic: [PATCH 1/2] rtc: da9063: set range
Thread-Index: AQHU388srtB02IcKs0uFchLWhDDC3qYnDdiAgAAE+gCAAAkNIIAANSwAgAAK4ICAAAUwgIAAGJUAgAACcwCAAAnyAIAAMsQAgAALXICAAN89gIAAC1WAgAAE04CAAAEDQA==
Date:   Tue, 2 Apr 2019 10:33:37 +0000
Message-ID: <DB7PR10MB2348398516E5744F4CF8C18BFE560@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
References: <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato> <20190401151628.GK3430@piout.net>
 <20190401155204.GA5964@kunai> <20190401185346.GP3430@piout.net>
 <20190401193424.sqnapthocznhjqok@ninjato> <20190402085325.GT3430@piout.net>
 <20190402093359.GB2960@kunai> <20190402095115.GW3430@piout.net>
In-Reply-To: <20190402095115.GW3430@piout.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d886baf5-a221-43b9-83d5-08d6b756aa67
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR10MB2060;
x-ms-traffictypediagnostic: DB7PR10MB2060:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR10MB20600D9B088817C5615B8039F5560@DB7PR10MB2060.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(136003)(396003)(189003)(199004)(68736007)(55016002)(33656002)(76176011)(186003)(26005)(7696005)(66066001)(6506007)(97736004)(14454004)(71190400001)(8676002)(71200400001)(81156014)(81166006)(86362001)(966005)(305945005)(229853002)(478600001)(53936002)(6246003)(14444005)(74316002)(446003)(11346002)(99286004)(102836004)(486006)(476003)(6436002)(6306002)(8936002)(4326008)(3846002)(6116002)(110136005)(7736002)(256004)(54906003)(2906002)(5660300002)(52536014)(93886005)(316002)(105586002)(25786009)(106356001)(9686003)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR10MB2060;H:DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IF0FcfVmycob5noONLebUWYx3n4qDoh6a/sidDOKHJj+bRzN8OuVna7Xr+zBiR/6NEcy1fV5vxxq96Lk0bxqhsWvilUZ1q2fwj36xKJUnxirNkTACAt/zzZvkD/WVXUt6bf+Dz8P0Ifev45RH/mOx657UI2VBjCniv+H9lzP4a/MR1gZE/ZPgp9dX6dr9xXhHHe1sx9Av1y1n7HA8/5zGJ0PlN51YVpwQTMZ99C+SKORajRh7MzhzsfKkIwFC4tCBbEiC43ooVHLG2XEwqaEnBrujocYQ1gUsmlk6AYc8KQOAh2BDw4PUEd+IcToNx8mWOugrSr5Oh1gT9uDOxedqSEXVAyJsMcfjO1B6169GXmoNPYmKPa/Fg5l2e4pK++7RfegS9Z47NjS/iTYqwchZsgQc7LHAt+1/Y4ZstgnhKY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d886baf5-a221-43b9-83d5-08d6b756aa67
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 10:33:37.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > >  drivers/rtc/rtc-da9063.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
> > > index 1b792bcea3c7..53e690b0f3a2 100644
> > > --- a/drivers/rtc/rtc-da9063.c
> > > +++ b/drivers/rtc/rtc-da9063.c
> > > @@ -475,6 +475,9 @@ static int da9063_rtc_probe(struct platform_devic=
e *pdev)
> > >  	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
> > >  	rtc->rtc_sync =3D false;
> > >
> > > +	if (config->rtc_data_start !=3D RTC_SEC)
> > > +		rtc->rtc_dev->uie_unsupported =3D 1;
> > > +
> >
> > I think we should have a comment here, like:
> > /* FIXME: Make use of the TICK interrupt once the RTC core supports it =
*/

Is this TICK interrupt suggestion to use the DA9063 TICK interrupt to simul=
ate
a second granularity in the AD alarm?

If I remember correctly, the original DA9063 patch set which was for AD sil=
icon
only, and which was sent to LKML before I took over looking at DA9063, used=
 the
DA9063 1-second TICK interrupt to count-down the seconds from the nearest
minute in order to simulate second resolution on the RTC alarm for AD.

... yes. Here it is. The original patch was from Krystian Garbaciak and tri=
ed to
support RTC alarms on the AD silicon to a second resolution by counting dow=
n
the DA9063 TICK interrupt:

https://marc.info/?l=3Dlm-sensors&m=3D134613501230005&w=3D2

However, I dropped that patch completely and wrote a new RTC device driver
because it didn't work in my tests.

The problem was: the TICK interrupt was indistinguishable from the ALARM
interrupt for a wake event and when I tested AD silicon to wake up an Andro=
id
device from suspend or power-off using the RTC IRQ, the device woke up on t=
he
ALARM minute (0 seconds), discovered it was not the correct time and immedi=
ately
went back to sleep. Then it woke-up and returned back to sleep every TICK I=
RQ
second until the correct alarm time was reached (up to 59 times!). At which=
 point
it woke up properly.

Regards,
Steve
