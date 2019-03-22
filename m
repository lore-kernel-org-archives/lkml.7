Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0CAC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A11820830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="GkyTxbJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCVPRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:17:09 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.68]:29013 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbfCVPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:17:08 -0400
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.eu-west-1.aws.symcld.net id E4/6C-07686-07CF49C5; Fri, 22 Mar 2019 15:17:04 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSaUgUYRjHfefaqZx63S18kgzaiMKczVkotvr
  SBVkUBVEfxKjZnNyNdXfZWUkLuikqurfDKa+I7VBY3A7Ktctiw3LTstKs6FCCDs3MDiykGWcr
  +/Z7nv//fY6XhyWNNUwKKxX4JZ9bdJmZwZRjEjuN9/4KZGc8Vky2HZ1Bg62p+gRju/iuk7BFK
  x4xtr33586gM0sq12e+LQ9RmV/CoxeTWbTTbfcUrKQdZ6IPkPcWU3Cx6yy1Cd2id6HBLIVDJH
  z+caE/MOKDBFS3dcaDFwjKt1w37EKDWAYLUPLxE9J4OPZA3/3DpGYi8RcETxt7+gUTngSB8y8
  J3ZQBz2ub1ccGla1wx6NlKTwOwtEIozGHl0Ok+wGtsRHPAqX4iepm2UF4NtyLTNbSCKdCz+YK
  UmMSJ0Nre2l/ccAYTtU0kDqPgHdtfbTuXwE7rncY9Hw6xJrbkc5mCLYotM6p8LB0dzy/EJ492
  k1omwBuRfAm9jReNA0azmxldHbBs7ddcR4FW24eo/UHz2loDSmEvsAq6CqOxTuPhnN7XlO6qZ
  GEfZEYoa+QDmWRbkbniRAs/0DuRxOUAdspA2zKAJvS/2FJUFfUTpUh6hyy2X3OXIc/T3S6eCE
  jgxcEKy9MncJbhSkWcR1vt0j5/FpJ9vOCRVwrW+TCvFWuHItb8oeRekk53tstl1HP6dxaNJIl
  zCO49O5AtnGo3ZNT6BBlxwpfvkuSa9EoljUDN/mnqiX5pFypYLXTpZ7jHxnYRPNwbowmc7JXz
  JOdubp0F/HsjZOvi0kj5fa4pZRkLtyrmrBmcuS7/5b4c9QPUWqKiUMJCQnGRK/ky3P6/9ffo2
  QWmU3cEa1KotPt/9vpvToEoQ5hDxzShvCL/6SUTSg1eeaBnY1r6IXL9lwiKuonbpsbHX/84BB
  X3bE51cMqhk2vP3w0eDVU9RFvFJqu1MzjOi9lB+yF1zwvx8541Y6mLQkN+fptftFSQ9KFO7Gk
  DfUdpWGq7WRWSdPyG99vdyiLWsgoTuMaqPq0WWULKpv7LNupXrouy2EN9RZZg1UmyUzJDlFII
  32y+BuIdFI1zwMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-282.messagelabs.com!1553267823!2949039!1
X-Originating-IP: [104.47.8.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9465 invoked from network); 22 Mar 2019 15:17:04 -0000
Received: from mail-am5eur03lp2058.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.58)
  by server-20.tower-282.messagelabs.com with AES256-SHA256 encrypted SMTP; 22 Mar 2019 15:17:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlrWyiLXCpIWaxZgMSaDlmO9+3HKZgc1/hzf3IMo+4M=;
 b=GkyTxbJEdkJkIcghn8dpYPFD9Zr+mevwOIuoHs4TBqcXiEbrihVeTgmifZtFlXQM+qlgvGiqrG/y9EmsCba9oiUdlOqJVjtve14JiBWtwCsnyeABgd5p2mvyRw+8ZHXbRClvOyHtB0Dk+1hHbLnEWxzl99XIO6Z8FogP2F2cc48=
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM (20.177.121.154) by
 DB7PR10MB2346.EURPRD10.PROD.OUTLOOK.COM (20.177.121.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Fri, 22 Mar 2019 15:16:54 +0000
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f8d2:d5b6:cca:1bcf]) by DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f8d2:d5b6:cca:1bcf%5]) with mapi id 15.20.1730.017; Fri, 22 Mar 2019
 15:16:54 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] rtc: da9063: set range
Thread-Topic: [PATCH 1/2] rtc: da9063: set range
Thread-Index: AQHU388srtB02IcKs0uFchLWhDDC3qYXwQWw
Date:   Fri, 22 Mar 2019 15:16:54 +0000
Message-ID: <DB7PR10MB2348BE83A0907337835A1FCBFE430@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9762b954-9d65-4b5d-615d-08d6aed96b12
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DB7PR10MB2346;
x-ms-traffictypediagnostic: DB7PR10MB2346:
x-microsoft-antispam-prvs: <DB7PR10MB2346D915DBE1776B4282C7D1F5430@DB7PR10MB2346.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(2501003)(4326008)(81166006)(25786009)(478600001)(86362001)(99286004)(11346002)(76176011)(14454004)(8676002)(186003)(7696005)(26005)(102836004)(81156014)(446003)(486006)(476003)(7736002)(305945005)(74316002)(6116002)(3846002)(6506007)(97736004)(256004)(106356001)(14444005)(105586002)(71200400001)(5660300002)(33656002)(71190400001)(6246003)(54906003)(4744005)(110136005)(316002)(9686003)(53936002)(55016002)(229853002)(6436002)(2906002)(52536014)(68736007)(8936002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR10MB2346;H:DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x0Z5LWjyWGTnend2icFXT9Y0KmPmSKRa403gKh2ECyq0kWfBZqHAJ3Am4JJPWz5ko/6BW0h+50svIzG0h1VaE84ERYNw0Jkyjt53zgQoTsJh2lOFYev8Fof9ILlk2eY5S7ZSFKWwoLPGhbIFd11x7F6IF1qjwW7lVYFIrqdVKxxP7eM0USjEUHTtQHs+dFoCSdovsBXK0m/lb4wXfF5VaunVu+YrEVSIUKztQmZBFJNymnXOQxXkiGPHkAMBrnW/Z88JYXDmxaDsE7Kq01aJQyp3frZhDPia6O+5hNO9ke/LEwR36k0cgL2HWMBpft3pcllnwbeNhvfGWkbgCtTIjxg46g7NyUBHy8ZTqecCa0dlsG77kGU9vGLDNhCPPnkkXZdK4IfUcyv61GzX4q23Sc+INrYf3AQq2g2YXjmVog0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9762b954-9d65-4b5d-615d-08d6aed96b12
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:16:54.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2346
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thanks.

Sorry, I didn't see this immediately because of our e-mail filtering algori=
thm,

On 21 March 2019 10:16, Alexandre Belloni wrote,

> Subject: [PATCH 1/2] rtc: da9063: set range
> The DA9062 and DA9063 have a year register that can go up to 0x3F.

Yep.

[...]
> index 588120ba372c..09fb4af5edab 100644
> --- a/include/linux/rtc.h
> +++ b/include/linux/rtc.h
> @@ -164,6 +164,7 @@ struct rtc_device {
>  /* useful timestamps */
>  #define RTC_TIMESTAMP_BEGIN_1900	-2208989361LL /* 1900-01-01 00:00:00 */
>  #define RTC_TIMESTAMP_BEGIN_2000	946684800LL /* 2000-01-01 00:00:00 */
> +#define RTC_TIMESTAMP_END_2063		2966371199LL /* 2063-12-31 23:59:59 */

Thanks.
Yes.

Register min and max values are:
2000-01-01 00:00:00
2063-12-31 23:59:59

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
