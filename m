Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99ACC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCEE217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 11:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="fkrdkBWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfC2LC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 07:02:29 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:50458 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728545AbfC2LC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 07:02:29 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 32/BA-05904-34BFD9C5; Fri, 29 Mar 2019 11:02:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VSa0hTYRjet3PxKE6O0/BNsx8LK8xNVySz/kR
  qjaDoAhFll6OetsGctjNrBpEmJa6M7pfVXFmoGGUNii4DzTIzXZpWXirNHJpmmV0VK9rOmWb/
  nvd5nu99n/fjpTDpMzKcYs0m1mhg9DIyANfGiuPlieO2lLhmu5/qZI+bVHV/r0Wqji8/CFXr3
  fOk6ubAJ7Hq8NPlS0i1o6KQVL9+6STVfRcrcfVXx8zV+EZCZ0jNNG8jtNWPG4msX5S5vOwano
  vK/SwogMLpSgwavzn5QkofEcOJMw5MKLoRDBQf8xT+FEkroXhoGHlxKM3B6ZITpNeE0fli6H/
  zkPQKIfQisOe2iQXTYmh5Wu3D86Gh9w7fCKej4M3QKI8l9Gaoyh/h30rpZDj14j3P+9PLoN3l
  5nlER8K3vCs8j9Fh0Om28z2BpuGyswkT8DQY6P1DCP6tUFD10U/gY8DV5kYClkFpu5UQcCS02
  A/6+JVgv3SVXwboTgStt077hGhoLX3hG6YHS/sfH54B46/2EcKDVgLG2vJ8G6TBZ5vLN3kmVB
  T14IKpGYMiSx0urBADF+59IQU8D0ovfsCOoLnWKdtZp9isU2xW/seCof6sG7+A8AqUkGrUabS
  mDEanlyvj4uRK5QL5QrlyYbyC2S1PVbDZ8jTWYDIyHlXB7OIUXE5Gmj5dYWBNDuQ5rPQdxPnb
  6J5FU4OmU2LZNMm7UVuKNCg1Mz1Hy3DarcZsPcvVoBkUJQNJyphHCzayGta8Xaf3XOeEDFSgL
  FSyyitLuCwmg9NpBOkJWkBVl/TYMKrrfr8Nk+KGTAMbHiYp8lppr1WbbZhsNHHpLSgyPESCRC
  KRNDCLNWboTP/rgyiMQrIQyU9v1kCdwTQ5b9ATReyJMrj3nDeKifknheci7Yipv2apZf/6ZP+
  x5OdJh8w7njtXdPXHuhIi8lyJDR1BtwfmKxJOPQrZHNG0Jn+2qjioQz6njOnb8sr/elTJzsLC
  4d9rqwqlORuqHfquWZX1s9NrHzw87ux+e8nZOGStXH5DqXayropc97pVSZuiBw8kHtWUy0TWg
  quZe6JEdTE1MpzTMspozMgxfwEdLYil5AMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-6.tower-239.messagelabs.com!1553857346!3376302!1
X-Originating-IP: [104.47.2.54]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25849 invoked from network); 29 Mar 2019 11:02:27 -0000
Received: from mail-db5eur01lp2054.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.54)
  by server-6.tower-239.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 29 Mar 2019 11:02:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Gkx1szDbW1BV/WUQV/DwoYtTOoHnKiyQ9VUP7VnKC0=;
 b=fkrdkBWbgzKUOdEACZ9yl3zcAclNZ3qsg7lERkuYX7frQITU7o6tbE1T1GCr8/s8SLIKCT9KJh4hOFR8i5wF0iJ9ZQQ4n9JMMy7t7brzIGWNoSk03Xq4dpCaJcysnh5Eby7mOLJvizPxguf+XNJseWO3mdaUMgItIycYD3jrbDw=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM (10.167.201.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Fri, 29 Mar 2019 11:02:25 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 11:02:25 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH 0/6] mfd: da9063: remove platform_data
Thread-Topic: [PATCH 0/6] mfd: da9063: remove platform_data
Thread-Index: AQHU3aIiRxuJGE6LNESZwBdNcQFfU6YigYOw
Date:   Fri, 29 Mar 2019 11:02:25 +0000
Message-ID: <VI1PR10MB235256E1840C1E594ECDC0A5FE5A0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc746189-7b21-43c0-2e9d-08d6b43606ea
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB0512;
x-ms-traffictypediagnostic: VI1PR10MB0512:
x-microsoft-antispam-prvs: <VI1PR10MB05127C1C9C9B74A326412BF9F55A0@VI1PR10MB0512.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(136003)(376002)(396003)(199004)(189003)(8936002)(186003)(256004)(86362001)(2501003)(68736007)(71190400001)(52536014)(305945005)(3846002)(6116002)(71200400001)(66066001)(7736002)(53546011)(6506007)(55016002)(11346002)(229853002)(316002)(478600001)(486006)(476003)(14454004)(33656002)(76176011)(446003)(106356001)(7696005)(54906003)(53936002)(2906002)(110136005)(105586002)(8676002)(6436002)(4326008)(81166006)(97736004)(81156014)(26005)(5660300002)(99286004)(25786009)(6246003)(102836004)(9686003)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB0512;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AxLJAZhJDqFANLcolnLuqT5RCIaZ9oV5BRkKt2SHy6p2CAQWWSfZkkpUbnwrVT/pqWLRFixmrWh5OQFOzDyZ2ZOKf08kolvhxseqLhZ9nNMZo/Xdnl7Il6fdCZkMu5JqyIpHioOQGjr+dvZv7VpM+u1q9RAet5Aicg34Pt1Ys8O4SY04KtNNkGjkQK+bmlzwIVO8nSct7dDVW8dOFOjGhsZLIOn9MG+EbOUGdAqUIlQ2xozurV5YS1EXtDih5PBNHE4swie+yeNmxlp9IrbUY5irOIAysiNunif+czXb4kxjbhKm/7Oye3h99YEHOuzMFbwXfwuo+XwRQEMrNpNK2sQl6X2CTNYXztr64wnWRnn3N6Ht7jWBOGhTyviXgXAOeeMkMXaLeZKk6XZNjgpmIuLAsmIpvCHkM3D831ZbO78=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc746189-7b21-43c0-2e9d-08d6b43606ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 11:02:25.5427
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

On 18 March 2019 15:48 Wolfram Sang wrote:

> Subject: [PATCH 0/6] mfd: da9063: remove platform_data
>=20
> When working with this driver while debugging something else, I noticed t=
hat
> there are no in-kernel users of platform_data anymore. Removing the suppo=
rt
> simplifies the code and gets rid of quite some lines. The biggest refacto=
ring
> went to the regulator driver which could maybe benefit from more
> refactorization. However, there is no in-kernel user of that driver, so n=
o
> testing. I left it at this stage. I think the changes are still at a leve=
l
> where review and build-testing will give enough confidence.
>=20
> Besides the regulator thing, it was tested on a Renesas Lager board (R-Ca=
r H2).
> No regressions encountered. buildbot was happy, too.
>=20
> The patches are based on v5.1-rc1. I'd vote for all of them going through=
 the
> MFD tree. Looking forward to comments!
>=20
>    Wolfram

I've acked-by and tested-by for all the patches now. Apologies because it t=
ook
such a long time to get around to looking at this.

(For my benefit) I regression tested against v5.0 and v5.1-rc1, ok.

Thanks,
Steve
