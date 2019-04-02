Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB031C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA042082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="PTqt1Iyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbfDBJhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:37:11 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:38271 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729189AbfDBJhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:37:10 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 77/95-25562-34D23AC5; Tue, 02 Apr 2019 09:37:07 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSWUwTURSGuTPT6UCouRSUYwVNGh4UmUJB46h
  xiS80GqPxgRCD0SmMtEkZaqeNKC41RiEgBI1CrCKgpAgaF1QU96AYMCwuKIuoEHFDRQLEKCZq
  p4Pb25/7/ee/55wchtQ+pHWMkOUUHCJv09NBlCWWns8uY0+kxHW7F3I5Q14196bnBsE9vnqU5
  i69HyK4e6c6aK6wLZGrbvKQS9WmY6ezTQ13cpHpTcVZytR8f4AyjdZOX61aq7KK5sysDSrL0S
  t2u2dK1pnGd4QbvdXmoSCGwmdJyP06RuShQEaL9xNQdSZCBlr8AkHTs1EkAxob4djHzz7NMGE
  4GfZ1J8keEt8koCj/Di17QnEsHLzw0h8UhuOgt6FTLZvC8G4E7eWlfkDhKHhe2ekv0OB1MFqy
  i1R+q6ageDTfDwKxAQqHyvwFCEfC2K5TpKxJHA49A8o7YAyV19tJRU+G969+qBT/esi59Umtv
  MdAa+cAUrQevF0elaIj4VFZvn8awCvhSf00uQfADxF0n780kRkNewqKaUXroKJ9bCLTBnkFhZ
  SiI+D196uUUjyugqGuErWyx1QYLm2dKJgONQX9E6YHJPT2nlMp08RA+bURugjN8vwznOcfpOj
  Z4K34QHr8GwuB5sMDVDmiahBndljTLc4M3mpjjXFxrNGYwM5huXgDv5U1GwQXmyqITgfvgwZ+
  s2SQtmSk2tIMouCsRb7zSttErbmCvFXpDWgqQ+gna05Hn0jRTjJnpm2x8JJlvcNlE6QGFMEwe
  tAUxfhYiENIF7I2Wm2+G/2NgQnWh2lGZvuwRrLzGZI1XUH3EcvcPt5fSmopMVMUdOGaeDkDyy
  aLS/wT8fvSH6FIXagGBQQEaIPtgiPD6vyfD6JwBulDNWY5JdgqOv/8NOhrgvA1wbnK5Cac/F+
  kc6OkRQd+XtvUljImvBXH947v2bHhsxR10KtqNa9K6Pj4BYeeHFzcVzeSvHVx1OU0NzFX11fq
  yb6LXJ32pDUl2+kleXX2vZUf5s2Y+eVQ14JtT4+kVPE7a4brqWIhMai2vrHO1vIk++nFkRXLE
  7/drsp5kFt9yB0oWrTNO1uii12N64b1lGThjdGkQ+J/AaStcsfkAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-11.tower-239.messagelabs.com!1554197826!3555341!1
X-Originating-IP: [104.47.6.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18048 invoked from network); 2 Apr 2019 09:37:06 -0000
Received: from mail-ve1eur02lp2057.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.57)
  by server-11.tower-239.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 2 Apr 2019 09:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BM5OELWD1p8J2atd9wGi3k9nzX1OTi8cl9lewJjttfE=;
 b=PTqt1IycaV2TY3WfiVQ+KH7cCAIJH370oNTAgF6YDpvEM3to16tGt0NQk8MmAOjHvDh6YuAxt0SfMbEY5nVNB8od6sSYbhZ28QrjyfbgioYJIZ4qmZsubroYrxpb6Nn9mgKGrUuKDvhGsDamdfN7Rj2Zq43L9k/OJ+qih0Dy5GM=
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM (20.177.121.154) by
 DB7PR10MB2108.EURPRD10.PROD.OUTLOOK.COM (52.134.102.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Tue, 2 Apr 2019 09:37:03 +0000
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1dc3:973e:6ed6:a60b]) by DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1dc3:973e:6ed6:a60b%5]) with mapi id 15.20.1750.021; Tue, 2 Apr 2019
 09:37:03 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] rtc: da9063: set range
Thread-Topic: [PATCH 1/2] rtc: da9063: set range
Thread-Index: AQHU388srtB02IcKs0uFchLWhDDC3qYnDdiAgAAE+gCAAAkNIIAANSwAgAAK4ICAAAUwgIAAGJUAgAACcwCAAAnyAIAAMsQAgAALXICAAN89gIAAAbUg
Date:   Tue, 2 Apr 2019 09:37:03 +0000
Message-ID: <DB7PR10MB2348E32107CAFBB68AC1C35AFE560@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
References: <CAMuHMdW_Gz4qaRXFeW-h7vNxJ5RwjDXDP4oZZcUaYHcqEC75bA@mail.gmail.com>
 <VI1PR10MB235254A7A95F4045A5410D1EFE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
 <CAMuHMdVsp86n_1+c6NZpCG1MwcAzEH7rgaESHfYESb5YcLk6zw@mail.gmail.com>
 <20190401132109.GA4570@kunai>
 <CAMuHMdV79HAn8jpodQcripAViCqBh3rFGZ39oEiSiP8nC+UyTA@mail.gmail.com>
 <20190401150741.vwqzzngnma4jvkid@ninjato> <20190401151628.GK3430@piout.net>
 <20190401155204.GA5964@kunai> <20190401185346.GP3430@piout.net>
 <20190401193424.sqnapthocznhjqok@ninjato> <20190402085325.GT3430@piout.net>
In-Reply-To: <20190402085325.GT3430@piout.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7b3be7b-8154-47fa-05b2-08d6b74ec3c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB7PR10MB2108;
x-ms-traffictypediagnostic: DB7PR10MB2108:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DB7PR10MB2108249B8EF3A40EF15E0601F5560@DB7PR10MB2108.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(199004)(189003)(4326008)(99286004)(102836004)(14454004)(6246003)(74316002)(486006)(256004)(9686003)(7696005)(6436002)(11346002)(55016002)(229853002)(6306002)(305945005)(106356001)(5660300002)(14444005)(966005)(97736004)(26005)(2906002)(76176011)(54906003)(86362001)(476003)(33656002)(68736007)(81156014)(71190400001)(25786009)(71200400001)(53936002)(446003)(316002)(186003)(6506007)(478600001)(93886005)(7736002)(3846002)(6116002)(8936002)(52536014)(53546011)(66066001)(8676002)(110136005)(81166006)(105586002)(527914007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR10MB2108;H:DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 397WBbLxMBpii2MxBtsOFD0uGj7pbUmyARDroCPQ/GRt4d1+4648TaL4SqTSAz3iEbfRAfVVuLoGlufEj+PSRJzocoLklyQyI55IoDuWGXOmfje2e/A+VocTc8sqDQbzzgwoGFN0fw4HS2S3QbWbjNM4V3dp8dFMwNBt5TEd9ESDt6xvO3ll9ca6DkJIjXfr9kYzxVYPT6hJ55DnXORvkKfatpPBttedPc/Cx7NeRz6jCf7oOU8aWNjB3m5I6kuhk/mH+gAgOuQKHS6USNYx4graxe1/I7rEGtJ+cBfn6FLSXjZb3lExwrXbzF4jTMspgzR18TwLfE3fRXjDZNwwSb/xXFZgSnv+62vHzlXBl8xiCaY4krkv8BZZlEZck2AQxc0BICRSIrnbMjsX+CvY72s1+Cc3pcrNug2KtrT9VkM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b3be7b-8154-47fa-05b2-08d6b74ec3c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 09:37:03.8545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

02 April 2019 09:53 Alexandre Belloni, wrote:
> Subject: Re: [PATCH 1/2] rtc: da9063: set range
> On 01/04/2019 21:34:25+0200, Wolfram Sang wrote:
> >
> > Thanks for your assistance! What I did just now was to make use of the
> > 'uie_unsupported' flag. This is the outcome:

[...]

> > I wonder why the_set_minute tests pass, but the other ones fail.
> > [...]
> > I also wonder why all this works fine for Steve.
> >
>=20
> I had a look at the driver and I guess you have a 9063AD while Steve
> uses another model.

That would be my immediate guess also.

https://elixir.bootlin.com/linux/v5.1-rc3/source/include/linux/mfd/da9063/c=
ore.h#L39

Reading the PMIC register 0x182 and examining the 4 highest bits of that
value will provide the variant code for the DA9063.

> That explains why you need the uie_unsupported flag. The 9063AD can only
> do alarms on a minute boundary.

For AD, alarms only happen to the minute boundary (i.e. alarms to 0 seconds=
 only)
https://elixir.bootlin.com/linux/v5.1-rc3/source/drivers/rtc/rtc-da9063.c#L=
84

Whereas, BB and greater can alarm to any of the second values 0-59
https://elixir.bootlin.com/linux/v5.1-rc3/source/drivers/rtc/rtc-da9063.c#L=
113
=20
I can confirm that I was only running my previous regression tests with a
BB and CA compliant silicon version. I didn't even think to mention what va=
riant
I was testing with.

[...]

> I suggest the following patch:
>=20
> =3D=3D=3D
>=20
> From 37b2ab7d537e76e42bde64cf4b57701b0ed8e8cd Mon Sep 17 00:00:00 2001
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Date: Tue, 2 Apr 2019 10:06:46 +0200
> Subject: [PATCH] rtc: da9063: set uie_unsupported when relevant
>=20
> The DA9063AD doesn't support alarms on any seconds and its granularity is
> the minute. Set uie_unsupported in that case.
>=20
> Reported-by: Wolfram Sang <wsa@the-dreams.de>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-da9063.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
> index 1b792bcea3c7..53e690b0f3a2 100644
> --- a/drivers/rtc/rtc-da9063.c
> +++ b/drivers/rtc/rtc-da9063.c
> @@ -475,6 +475,9 @@ static int da9063_rtc_probe(struct platform_device
> *pdev)
>  	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
>  	rtc->rtc_sync =3D false;
>=20
> +	if (config->rtc_data_start !=3D RTC_SEC)
> +		rtc->rtc_dev->uie_unsupported =3D 1;
> +
>  	irq_alarm =3D platform_get_irq_byname(pdev, "ALARM");
>  	ret =3D devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
>  					da9063_alarm_event,

Thanks Alexandre,

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Apologies, I am unable to test this on DA9063 AD silicon since I no longer =
have
that variant.

Regards,
Steve
