Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0FEC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AEF21473
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="HhpYnFz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfD2JQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:16:30 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.66]:40422 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727811AbfD2JQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:16:29 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 27/E1-23323-9E0C6CC5; Mon, 29 Apr 2019 09:16:25 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHfc85OzsrT7zN0idLqUFB5lmui5w
  uH6QPMaggpChCqrN5coM5185ELYKSjbxkdmGk5S0rCyMUCbEU02nRBcvMLCtHq0G6CsIuRnTb
  2dEu3/7n+f+e//O8h4chtcN0PCPmu0SnXbDp6GmUZamG58a6bmWkVB7W8HfdHWp+8KGP4L2BI
  M1/GSwi+EfXq2i++Hq5im+euILS1Mbmj4W00TPwgzZeOz2iNrY0FtPGzvcNtLHp6mPK+LElcb
  N6h8pqN+Xk71ZZ3M2vaMc4k9/w3K06iL7TJUjDULiJhI7i3SVoGqPFXgK8hW2k8hFAcGmiTC1
  TNObh5O2XkY5ZeDsU+R/RMkTiXgL6a4eIEsQwMXgbdLYXTDGVdRWEolfDmdGzpDJtIUzcK4/g
  LBbAXbNKLmuxBTz+xsgoDV4O/ssnkKwRToBPhy5HWkkcB8+CtZFIwBjOdzwgFT0bxl7/VCm8C
  HcKnyKlngx9T4JIHgV4AZS9pJRyAgzUlk4im8DX2aJS9AsEI9/TplqPVxVN8jycL/VQSowDBu
  tXKuVF8PRd0eQG86DrSI9a/iGAL9JQ+OQFrTzLDB+q+9QKlAiNZQFKgfpJOFJepT6Gkk7/8zR
  FJ0Nd+zit6CXQcPYtKWsWz4Q7lUGqDlGNiDc5rVkWV7ZgtXGGlBTOYFjGGValcobU5XphH2fS
  i7lcnii5OINeyJP0UkG22Zapt4uuFhQ+s0xH77k2FLqY5UNzGEI3m73QejNDO8OUk1lgESTLL
  meuTZR8aB7D6ICde+NWhnamU8wS8/dYbeFbnbKBidbNYr92hm1WcgjZkjVLse4ijumqD1STWs
  qeYxfj49h1cgaWIUuu/U/E1MUPoIT4GBZFRUVpox2iM9vq+t8PoTgG6WLYGDkl2mp3/ZkUCi9
  BhJfYVRNZwiX8teIPor3VxhH25LedXzZ0bWk9tY1d3OpdP5GTtrHXU2Fmhg/PafP4F4SCDd70
  2KbxtRvelyQO7t9qqpmevsXZvX48drR0oMyfVJywJk9zNPbNAVX/SreuYqzn13z754Lke+lNQ
  6GhK4l9K4g3qd3sjL2B4VF30Ozr7mnv7l9qvu8J/pxfp6Mki2BIIp2S8Bs2A6rB7AMAAA==
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-3.tower-288.messagelabs.com!1556529384!8013547!1
X-Originating-IP: [104.47.9.56]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30202 invoked from network); 29 Apr 2019 09:16:25 -0000
Received: from mail-ve1eur03lp2056.outbound.protection.outlook.com (HELO EUR03-VE1-obe.outbound.protection.outlook.com) (104.47.9.56)
  by server-3.tower-288.messagelabs.com with AES256-SHA256 encrypted SMTP; 29 Apr 2019 09:16:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZfKhUE6GU5bTJIVhERVZ8WhN0wrcDd15Z8YGY06B6A=;
 b=HhpYnFz8BzjSTJiYlRJ1NUCjELAtdwS3rL88ykNM45yMtZPe9uQI5KSsq0qzwppDZdfscjwMj5UH/f8cMOdN/1KJvKRcRMjF05Je9rZVclXZaRzVzc7xrjI9Od19Gw/0A+4o5qLN0y3kFZYnzaR9DsoRq6acVOFnpCEmxdwZU1c=
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM (10.169.154.136) by
 AM5PR1001MB1124.EURPRD10.PROD.OUTLOOK.COM (10.169.155.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Mon, 29 Apr 2019 09:16:08 +0000
Received: from AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971]) by AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::45b2:d8a8:e1c:b971%5]) with mapi id 15.20.1835.018; Mon, 29 Apr 2019
 09:16:08 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled
 bclk/wclk case
Thread-Topic: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled
 bclk/wclk case
Thread-Index: AQHU/C/ieslj5Bfz40yQWTvSO33hHaZQQn2AgAKcQvA=
Date:   Mon, 29 Apr 2019 09:16:08 +0000
Message-ID: <AM5PR1001MB0994EA351AEF82224D9AA6BF80390@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20190426125925.04F3F3FB4A@swsrvapps-01.diasemi.com>
 <20190427171955.GH14916@sirena.org.uk>
In-Reply-To: <20190427171955.GH14916@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26bb1539-bd11-4108-bd85-08d6cc8350d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:AM5PR1001MB1124;
x-ms-traffictypediagnostic: AM5PR1001MB1124:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AM5PR1001MB1124C70FE6F8DFD45D290381A7390@AM5PR1001MB1124.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0022134A87
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39860400002)(136003)(199004)(189003)(68736007)(478600001)(305945005)(66066001)(5660300002)(72206003)(102836004)(14454004)(76176011)(71200400001)(71190400001)(2906002)(81156014)(7696005)(81166006)(74316002)(99286004)(316002)(8676002)(25786009)(6246003)(97736004)(33656002)(55016002)(4326008)(52536014)(26005)(8936002)(7736002)(110136005)(9686003)(186003)(6436002)(55236004)(229853002)(66556008)(53936002)(486006)(86362001)(6116002)(3846002)(446003)(256004)(14444005)(107886003)(66946007)(73956011)(11346002)(54906003)(6506007)(476003)(66446008)(64756008)(76116006)(53546011)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR1001MB1124;H:AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s0849gx6b9qET1bgAo5yxi1f3u6fQLe9pRMQAbKwT56Ehy1T0sc/k9T3YkayEJHHxclUUZBu6j33Sa3RHSVERjv3HhLDx38e6U0U9iiGRPWrQ/eHy2uJUeIyFMk5JKm9j1szPXfMmeUlZYHz1VFndTlQwr+YxYjOZ+qlxROOwdgHogJhCvlc+MhVYYdZ+ku6jyM/XKqTV3KnDu0BUL7aL5hQvzezpYThwLN6BLiYGVfw15V9tLHpbIf7MdWGGdgI2JYt9JlBS5tFJx+0aChhhu39ProtwDB4X5dTeHbcBpDqczjQ7fRK1b93CwL/pLUvI+kpLS9wmc93rhK1EFWtzhE9I5Mt/lZWFiXNr32RtGRhIdvAq6IE5UgpwikzCUZxiNhjJQAd8d3jX/Ov8jaYq6zJjkR7/41tP0hvs+fWDjI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26bb1539-bd11-4108-bd85-08d6cc8350d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2019 09:16:08.7052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR1001MB1124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 April 2019 18:20, Mark Brown wrote:

> On Fri, Apr 26, 2019 at 01:59:24PM +0100, Adam Thomson wrote:
>=20
> > +		/*
> > +		 * Rounding the rate here avoids failure trying to set a new
> > +		 * rate on an already enabled wclk. In that instance this will
> > +		 * just set the same rate as is currently in use, and so should
> > +		 * continue without problem.
> > +		 */
> > +		sr =3D clk_round_rate(wclk, sr);
> >  		ret =3D clk_set_rate(wclk, sr);
> >  		if (ret) {
> >  			dev_err(component->dev,
>=20
> Don't we need to validate that the rounded rate is actually viable for
> the parameters we're trying to set here?  If there's missing constraints
> causing something to try to do something unsupportable then we should
> return an error rather than silently accept.

Thanks for directing my gaze to this again. Actually I don't think the SR s=
hould
be rounded at all. If it doesn't match exactly it should fail so I'll remov=
e the
rounding here. Not sure what my brain was doing there.

For the BCLK rate, I'll see what checking can be added there to make sure t=
he
word length is compatible with the 'rounded' BCLK rate.
