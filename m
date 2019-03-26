Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E4C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD8220857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="aWe5T0il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfCZJYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:24:01 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:11175 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbfCZJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:24:00 -0400
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id A8/51-18573-CAFE99C5; Tue, 26 Mar 2019 09:23:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSfVAMcRjH+92+tNWtWZf0OOqPI5muPa0Y6x9
  ixPnDjDHGhIw2re5mriu3F2nMiAzjDJO3SRd1ml6IGaPReMkoNUwyQnnJiaZc6JK8xzDGbbvI
  f599vt99vs/zm4fCdPdJPSXmOUWHXbAZyFDcMlMzjz03XJKaUPk6lD/W6yP5loo3iO/5chPxT
  z9+JfjOqydIvn7gnYY/2L40Kdh8xf082FxXu480dz++RppfnTqPmz/VRa8g1hJWe3p2Xhphee
  0qJXKOYXmFHbvxAnRH40KhFM6cx+CS51bgI4TSMUUa8LSkyIKO6UHQf68KyQLJcFD2dniUJzC
  JcK6wNFhmjHmigf3+zTKHM4uhvHNE9STDi9JbKs+Cp4e7CZlxJgbc10dGmWbWQ2fNPlwJLkBQ
  4Et2IYoKYZbA855YuYyYKPi88yymREWC11c+OicwDFReu4cpHAEDL38Rin8D7G0cClbq8XD3i
  Q8pbIDqLjehcBR0lO9X68vh8MMyQt4XGC+CykM1atM4eON1qWyD4xV3VJ4CXcWtpPJDKwHfiy
  6oC2yE9yfvqsnRUHugF1dM9zGoHixUV4gHT8NHUmEjVJ8axIrQDPeY7dxjbO4xNvfog42H2yU
  +3IPwWjQ33WHNtDizBKuN5RISWI6bxXLzEtnZiSYhnxVMYi67VZScLGcStkomaVvWRluGyS46
  61DgujJybhgvI19NZjOaRGkMEXR+c0mqblx6dsY2iyBZNjhybaLUjKZQlAHoqYEr1I13iJli3
  iarLXCif2SgtIYJ9M+hgExLOUKWZM1UpDbEUk0VvScxHW7Ptov6SDrkXcDEyCZLrv1viz+H3o
  Gi9OE0CgoK0mlzREeW1fm/7keRFDKE02FyF63V7vyb5A8MoQkMMclVLA/hFP5J+gJE+/v5Ta7
  N0+pNKY9G9EW7FmERqzmPf3pP2tQzC6Jjk45OHuirv7jjx7q6NKM3uarxGfN+or6pPbZZGH6F
  hx3R9n3oinmwq23ZlWLX/FVez9r8hlTt6e189Igxzp7S921lzMKkJU0N/cXgr2qd8/nTUPtOU
  5ixqnv75S2D7j1c3BoDLlkELg5zSMJvwvks6uMDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-14.tower-262.messagelabs.com!1553592235!3962871!1
X-Originating-IP: [104.47.2.57]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24457 invoked from network); 26 Mar 2019 09:23:56 -0000
Received: from mail-db5eur01lp2057.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.57)
  by server-14.tower-262.messagelabs.com with AES256-SHA256 encrypted SMTP; 26 Mar 2019 09:23:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inqpvUuOZFASRaEBIkasJMpwUTtkU62btfu7pHeShJ0=;
 b=aWe5T0il6OkMNSsAklJzcftw4+6z62SCaCGgV8EUYNxZqES0Ie+BnnE/nuzYJxICDtjTl/DfrVBR0LLstfOD9J/Fo93lx6HPaAPzcWtkOL+u59icIJKBOZXaPepT7l5ogDQCHq1YaEhMHrdws0s8J0qGzhCLaOX4iyB/FO/jcaA=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2653.EURPRD10.PROD.OUTLOOK.COM (20.178.126.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 09:23:50 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 09:23:50 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH 3/4] input: da9063_onkey: convert header to SPDX
Thread-Topic: [PATCH 3/4] input: da9063_onkey: convert header to SPDX
Thread-Index: AQHU3aNX2bq1czMO70+VGi54iTWdmqYdrzAQ
Date:   Tue, 26 Mar 2019 09:23:49 +0000
Message-ID: <VI1PR10MB2352E1F0C929F73D7220A998FE5F0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
 <20190318155728.28365-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190318155728.28365-4-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 894a09b1-259f-4769-096a-08d6b1ccc1aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2653;
x-ms-traffictypediagnostic: VI1PR10MB2653:
x-microsoft-antispam-prvs: <VI1PR10MB265318E4B221F5F4814A9B43F55F0@VI1PR10MB2653.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39850400004)(376002)(346002)(396003)(189003)(199004)(6436002)(6246003)(8676002)(81156014)(305945005)(4744005)(52536014)(229853002)(81166006)(55016002)(74316002)(68736007)(4326008)(9686003)(97736004)(53936002)(25786009)(86362001)(2906002)(6116002)(3846002)(26005)(33656002)(76176011)(102836004)(66066001)(105586002)(11346002)(106356001)(53546011)(486006)(54906003)(5660300002)(476003)(8936002)(6506007)(186003)(446003)(316002)(478600001)(71190400001)(71200400001)(256004)(7736002)(99286004)(14454004)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2653;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gUn4GqZA8lXfzwcXBiv+O7eGQT/oroT39ri2dhUeML/aF8xxcgWqLPHJkuEQBaz0ZopbIFApI9ZzG01VQBjkZHd8eDPF24lK6OzW+60jXrYJzZhtSGQ2yc2pkQhXVB0jwkYr6rI8gYlYFBOsvbrGycbIiYVmmBtrBTsPEohkCqAawgH9tkPE1Z2Nzp4n3Qqt52yLz65mwl4g1mwjjKcAtBmPb7SOqGbtt/WIIckvP+bA8D1qJF5poIathFzn6SiEYAZlghrY//7DBC9EZjIaPBNUsqfTWQ5z3HCcQDBZLXMvAdIrFVWNOQA4IuYraVnRAbAdyoip+x5kMghiNhKfVqP5m0pCcXggT/SQ8/wDbvQN1IKNtejtppvC59/HaaUJJIMgItAida57C+/Y4R++o5K8ZuGI9w1hrbK/T7FOItw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894a09b1-259f-4769-096a-08d6b1ccc1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 09:23:49.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2653
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 March 2019 15:57, Wolfram Sang wrote:

> Subject: [PATCH 3/4] input: da9063_onkey: convert header to SPDX
> Covnert the header of the source file to SPDX.

[...]

> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * OnKey device driver for DA9063, DA9062 and DA9061 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
[...]
>   */

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
